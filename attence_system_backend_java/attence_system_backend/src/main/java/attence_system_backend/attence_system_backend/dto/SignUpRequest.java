package attence_system_backend.attence_system_backend.dto;

import lombok.Data;

@Data
public class SignUpRequest {
    private String fullName;
    private String email;
    private String password;
    private String employeeId;
    private String department;
    private String position;
    private String role; // Usually defaults to "EMPLOYEE"
}