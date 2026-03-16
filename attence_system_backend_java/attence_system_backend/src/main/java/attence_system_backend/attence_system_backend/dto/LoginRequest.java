package attence_system_backend.attence_system_backend.dto;

import lombok.Data;

@Data
public class LoginRequest {
    private String email;
    private String password;
    
}
