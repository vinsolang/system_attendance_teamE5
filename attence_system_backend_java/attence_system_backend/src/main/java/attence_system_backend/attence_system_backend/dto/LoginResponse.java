package attence_system_backend.attence_system_backend.dto;

public class LoginResponse {
    private String message;
    private String token;
    private String email;
    private String role;

    // Add this constructor to fix your error (2 arguments)
    public LoginResponse(String message, String token) {
        this.message = message;
        this.token = token;
    }

    // Keep this one for more detailed responses later (4 arguments)
    public LoginResponse(String message, String token, String email, String role) {
        this.message = message;
        this.token = token;
        this.email = email;
        this.role = role;
    }
    // Getters and Setters
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public String getToken() { return token; }
    public void setToken(String token) { this.token = token; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}
