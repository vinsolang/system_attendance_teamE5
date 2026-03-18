package attence_system_backend.attence_system_backend.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class AttendanceDTO {
    private LocalDateTime checkInTime;
    private LocalDateTime checkOutTime;
    private String deviceType;
}
