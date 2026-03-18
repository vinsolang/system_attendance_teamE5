package attence_system_backend.attence_system_backend.controllers;

import attence_system_backend.attence_system_backend.models.Attendance;
import attence_system_backend.attence_system_backend.services.AttendanceService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/attendance")
@CrossOrigin(origins = "*")
public class AttendanceController {

    @Autowired
    private AttendanceService attendanceService;

    @PostMapping("/checkin/{employeeId}")
    public ResponseEntity<?> checkIn(@PathVariable Long employeeId, @RequestParam String device) {
        return ResponseEntity.ok(attendanceService.checkIn(employeeId, device));
    }

    @PostMapping("/checkout/{employeeId}")
    public ResponseEntity<?> checkOut(@PathVariable Long employeeId, @RequestParam String device) {
        return ResponseEntity.ok(attendanceService.checkOut(employeeId, device));
    }

    @GetMapping("/today/{employeeId}")
    public ResponseEntity<?> getToday(@PathVariable Long employeeId) {
        return ResponseEntity.of(attendanceService.getTodayAttendance(employeeId));
    }

    @GetMapping("/history/{employeeId}")
    public ResponseEntity<List<Attendance>> getHistory(@PathVariable Long employeeId) {
        return ResponseEntity.ok(attendanceService.getHistory(employeeId));
    }
}





    // private void sendTelegramAlert(String fullName, String status, LocalDateTime now, String device) {
    //     DateTimeFormatter dateThai = DateTimeFormatter.ofPattern("dd MMM yyyy");
    //     DateTimeFormatter timeFormat = DateTimeFormatter.ofPattern("hh:mm a");
    //     DateTimeFormatter fullFormat = DateTimeFormatter.ofPattern("dd/MM/yy hh:mm a");

    //     LocalTime workStart = LocalTime.of(8, 0); // 08:00 AM
    //     LocalTime workEnd = LocalTime.of(17, 0); // 05:00 PM
    //     LocalTime currentTime = now.toLocalTime();

    //     StringBuilder message = new StringBuilder();
    //     String note = "";

    //     if ("CHECK_IN".equals(status)) {
    //         message.append("🔵 ").append(fullName).append(" Clocked In!\n");
    //         // Check if Late
    //         if (currentTime.isAfter(workStart)) {
    //             note = "ចំណាំ៖ If employee come Company late tell to him";
    //         } else {
    //             note = "ចំណាំ៖ On Time";
    //         }
    //     } else {
    //         message.append("🔴 ").append(fullName).append(" Clocked Out!\n");
    //         // Check if Early
    //         if (currentTime.isBefore(workEnd)) {
    //             Duration diff = Duration.between(currentTime, workEnd);
    //             long hours = diff.toHours();
    //             long minutes = diff.toMinutesPart();
    //             long seconds = diff.toSecondsPart();
    //             note = String.format("ចំណាំ៖ ⚠️ Early %02d:%02d:%02d", hours, minutes, seconds);
    //         } else {
    //             note = "ចំណាំ៖ Completed work day";
    //         }
    //     }

    //     message.append("Date៖ ").append(now.format(dateThai)).append("\n");
    //     message.append("Time៖ ").append(now.format(timeFormat)).append("\n");
    //     message.append(note).append("\n");
    //     message.append("កាលបរិច្ឆេទ: ").append(now.format(fullFormat));

    //     // Send to Telegram
    //     try {
    //         String url = "https://api.telegram.org/bot" + BOT_TOKEN + "/sendMessage";

    //         // Use a Map for cleaner encoding with RestTemplate
    //         Map<String, String> params = Map.of(
    //                 "chat_id", CHAT_ID,
    //                 "text", message.toString(),
    //                 "parse_mode", "HTML" // Optional: allows for bold/italic
    //         );

    //         // Better way to call to avoid manual URL encoding issues
    //         new RestTemplate().getForObject(
    //                 url + "?chat_id={chat_id}&text={text}&parse_mode={parse_mode}",
    //                 String.class,
    //                 params);
    //     } catch (Exception e) {
    //         System.err.println("Error sending Telegram alert: " + e.getMessage());
    //         e.printStackTrace();
    //     }
    // }

















// package attence_system_backend.attence_system_backend.controllers;

// import java.net.URLEncoder;
// import java.nio.charset.StandardCharsets;
// import java.time.LocalDateTime;
// import java.util.Map;
// import java.util.Optional;

// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.http.ResponseEntity;
// import org.springframework.web.bind.annotation.*;
// import org.springframework.web.client.RestTemplate;

// import attence_system_backend.attence_system_backend.models.Attendance;
// import attence_system_backend.attence_system_backend.models.Employee;
// import
// attence_system_backend.attence_system_backend.repository.AttendanceRepository;
// import
// attence_system_backend.attence_system_backend.repository.EmployeeRepository;

// @RestController
// @RequestMapping("/api/attendance")
// @CrossOrigin("*")
// public class AttendanceController {

// @Autowired
// private AttendanceRepository attendanceRepository;

// @Autowired
// private EmployeeRepository employeeRepository;

// private final String BOT_TOKEN =
// "7587916418:AAEzLlsLWCnIYlo0TPEPm0TRIRpcaP0VEyg";
// private final String CHAT_ID = "-4819861863";

// @PostMapping("/checkin")
// public ResponseEntity<?> attendance(@RequestBody Map<String, String> payload)
// {

// try {

// String employeeId = payload.get("userId");
// String status = payload.get("status");
// String device = payload.get("deviceType");

// System.out.println("Employee ID: " + employeeId);
// System.out.println("Status: " + status);
// System.out.println("Device: " + device);

// if (employeeId == null || status == null) {
// return ResponseEntity.badRequest().body("Missing required fields");
// }

// LocalDateTime now = LocalDateTime.now();

// Optional<Employee> employeeOptional =
// employeeRepository.findByEmployeeId(employeeId);

// if (employeeOptional.isEmpty()) {
// return ResponseEntity.badRequest().body("Employee not found");
// }

// Employee employee = employeeOptional.get();
// String fullName = employee.getFullName();

// if ("CHECK_IN".equalsIgnoreCase(status)) {

// Attendance latestAttendance =
// attendanceRepository.findTopByEmployeeOrderByCheckInTimeDesc(employee);

// if (latestAttendance != null && latestAttendance.getCheckOutTime() == null) {
// return ResponseEntity.badRequest().body("Already checked in");
// }

// Attendance attendance = new Attendance();
// attendance.setEmployee(employee);
// attendance.setCheckInTime(now);
// attendance.setDeviceType(device);

// attendanceRepository.save(attendance);

// sendTelegramAlert(fullName, "CHECK_IN", now, device);

// return ResponseEntity.ok("Check-in successful");
// }

// else if ("CHECK_OUT".equalsIgnoreCase(status)) {

// Attendance attendance =
// attendanceRepository.findTopByEmployeeOrderByCheckInTimeDesc(employee);

// if (attendance == null) {
// return ResponseEntity.badRequest().body("No check-in record found");
// }

// if (attendance.getCheckOutTime() != null) {
// return ResponseEntity.badRequest().body("Already checked out");
// }

// attendance.setCheckOutTime(now);
// attendanceRepository.save(attendance);

// sendTelegramAlert(fullName, "CHECK_OUT", now, device);

// return ResponseEntity.ok("Check-out successful");
// }

// return ResponseEntity.badRequest().body("Invalid status");

// } catch (Exception e) {
// e.printStackTrace();
// return ResponseEntity.internalServerError().body("Server error");
// }
// }

// private void sendTelegramAlert(String fullName, String status, LocalDateTime
// time, String device) {

// try {

// String icon = status.equals("CHECK_IN") ? "🔵" : "🔴";
// String action = status.equals("CHECK_IN") ? "Check In" : "Check Out";

// String message = String.format(
// "%s %s\nEmployee: %s\nDate: %s\nTime: %s\nDevice: %s",
// icon,
// action,
// fullName,
// time.toLocalDate(),
// time.toLocalTime().withNano(0),
// device
// );

// String encodedMessage = URLEncoder.encode(message, StandardCharsets.UTF_8);

// String url = "https://api.telegram.org/bot" + BOT_TOKEN +
// "/sendMessage?chat_id=" + CHAT_ID +
// "&text=" + encodedMessage;

// RestTemplate restTemplate = new RestTemplate();
// restTemplate.getForObject(url, String.class);

// } catch (Exception e) {
// System.out.println("Telegram notification failed");
// e.printStackTrace();
// }
// }
// }