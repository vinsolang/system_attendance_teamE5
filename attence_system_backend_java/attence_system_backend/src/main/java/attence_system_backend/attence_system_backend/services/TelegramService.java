package attence_system_backend.attence_system_backend.services;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDateTime;
import java.time.Duration;
import java.time.format.DateTimeFormatter;

@Service
public class TelegramService {

    @Value("${telegram.bot.token}") // from application.properties
    private String botToken;

    @Value("${telegram.chat.id}") // from application.properties
    private String chatId;

    private final RestTemplate restTemplate = new RestTemplate();

    public void sendTelegramAlert(String fullName, String status, LocalDateTime now, String device) {
        DateTimeFormatter dateThai = DateTimeFormatter.ofPattern("dd MMM yyyy");
        DateTimeFormatter timeFormat = DateTimeFormatter.ofPattern("hh:mm a");
        DateTimeFormatter fullFormat = DateTimeFormatter.ofPattern("dd/MM/yy hh:mm a");

        // Work start/end for note
        LocalDateTime todayStart = now.toLocalDate().atTime(8, 0); // 08:00 AM
        LocalDateTime todayEnd = now.toLocalDate().atTime(17, 0);  // 05:00 PM

        StringBuilder message = new StringBuilder();
        String note;

        if ("CHECK_IN".equals(status)) {
            message.append("🔵 ").append(fullName).append(" Clocked In!\n");
            if (now.isAfter(todayStart)) {
                note = "ចំណាំ៖ ⚠️ Late";
            } else {
                note = "ចំណាំ៖ On Time";
            }
        } else { // CHECK_OUT
            message.append("🔴 ").append(fullName).append(" Clocked Out!\n");
            if (now.isBefore(todayEnd)) {
                Duration diff = Duration.between(now, todayEnd);
                long hours = diff.toHours();
                long minutes = diff.toMinutesPart();
                long seconds = diff.toSecondsPart();
                note = String.format("ចំណាំ៖ ⚠️ Early %02d:%02d:%02d", hours, minutes, seconds);
            } else {
                note = "ចំណាំ៖ Completed work day";
            }
        }

        message.append("Date៖ ").append(now.format(dateThai)).append("\n");
        message.append("Time៖ ").append(now.format(timeFormat)).append("\n");
        message.append(note).append("\n");
        message.append("កាលបរិច្ឆេទ: ").append(now.format(fullFormat));

        try {
            String url = "https://api.telegram.org/bot" + botToken + "/sendMessage";

            restTemplate.getForObject(
                    url + "?chat_id={chat_id}&text={text}&parse_mode=HTML",
                    String.class,
                    chatId,
                    message.toString()
            );

        } catch (Exception e) {
            System.err.println("Error sending Telegram alert: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
