package attence_system_backend.attence_system_backend.dto;

import lombok.Data;

@Data
public class AttendanceRequest {
    private String employeeId;
    private String deviceType;
}
