package attence_system_backend.attence_system_backend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class LoginResponse {
    private String message;
    private String token;
    private String email;
    private String role;
}