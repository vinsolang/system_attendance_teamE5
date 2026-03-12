package attence_system_backend.attence_system_backend.controllers;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import attence_system_backend.attence_system_backend.dto.LoginRequest;
import attence_system_backend.attence_system_backend.dto.LoginResponse;
import attence_system_backend.attence_system_backend.dto.SignUpRequest;
import attence_system_backend.attence_system_backend.models.User;
import attence_system_backend.attence_system_backend.repository.UserRepository;



@RestController
@RequestMapping("/api/auth")
@CrossOrigin(origins = "http://localhost:5173")
public class AuthController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @PostMapping("/signup")
    public ResponseEntity<?> registerUser(@RequestBody SignUpRequest signUpRequest) {

        if(userRepository.findByEmail(signUpRequest.getEmail()).isPresent()){
            return ResponseEntity.badRequest().body("Email already exists");
        }

        User user = new User();
        user.setFirstName(signUpRequest.getFirstName());
        user.setLastName(signUpRequest.getLastName());
        user.setEmail(signUpRequest.getEmail());
        user.setRole(signUpRequest.getRole());

        // Encrypt password
        String encryptedPassword = passwordEncoder.encode(signUpRequest.getPassword());
        user.setPassword(encryptedPassword);

        userRepository.save(user);

        return ResponseEntity.ok("User Register successfully!");
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest request){

        Optional<User> optionalUser = userRepository.findByEmail(request.getEmail());

        if(optionalUser.isEmpty()){
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body("Invalid email or password");
        }

        User user = optionalUser.get();

        if(passwordEncoder.matches(request.getPassword(), user.getPassword())){

            String token = "sample_token_123";

            LoginResponse response = new LoginResponse(
                "Login success",
                token,
                user.getEmail(),
                user.getRole()
            );

            return ResponseEntity.ok(response);
        }

        return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                .body("Invalid email or password");
    }

    @GetMapping("/me")
    public ResponseEntity<?> getCurrentUser(@RequestParam String email){

        Optional<User> optionalUser = userRepository.findByEmail(email);

        if(optionalUser.isEmpty()){
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body("User not found");
        }

        User user = optionalUser.get();

        return ResponseEntity.ok(user);
    }
    
    @PostMapping("/logout")
    public ResponseEntity<?> logout(){
        return ResponseEntity.ok("Logout successful");
    }
}