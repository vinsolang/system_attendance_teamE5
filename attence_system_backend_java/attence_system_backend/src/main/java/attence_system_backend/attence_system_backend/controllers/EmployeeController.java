package attence_system_backend.attence_system_backend.controllers;

import java.io.IOException;
import java.nio.file.*;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import attence_system_backend.attence_system_backend.models.Employee;
import attence_system_backend.attence_system_backend.dto.LoginRequest;
import attence_system_backend.attence_system_backend.dto.LoginResponse;
import attence_system_backend.attence_system_backend.dto.SignUpRequest;
import attence_system_backend.attence_system_backend.repository.EmployeeRepository;

@RestController
@RequestMapping("/api/employees")
@CrossOrigin(origins = "*") // Unified cross-origin
public class EmployeeController {

    @Autowired
    private EmployeeRepository employeeRepository;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    private final String uploadDir = "uploads";

    @PostMapping("/signup")
    public ResponseEntity<?> registerEmployee(@RequestBody SignUpRequest signUpRequest) {

        if (employeeRepository.findByEmail(signUpRequest.getEmail()).isPresent()) {
            return ResponseEntity.badRequest().body("Email already exists");
        }

        Employee emp = new Employee();
        emp.setFullName(signUpRequest.getFullName());
        emp.setEmail(signUpRequest.getEmail());
        emp.setRole(signUpRequest.getRole());

        // Encrypt password
        String encryptedPassword = passwordEncoder.encode(signUpRequest.getPassword());
        emp.setPassword(encryptedPassword);

        employeeRepository.save(emp);

        return ResponseEntity.ok("Employee Register successfully!");
    }

    // --- AUTHENTICATION METHODS --
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest request) {
        Optional<Employee> optionalEmp = employeeRepository.findByEmail(request.getEmail());

        if (optionalEmp.isEmpty()) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid email or password");
        }

        Employee emp = optionalEmp.get();

        if (passwordEncoder.matches(request.getPassword(), emp.getPassword())) {
            String token = "sample_token_123"; // In production, generate JWT

            LoginResponse response = new LoginResponse(
                    "Login success",
                    token,
                    emp.getEmail(),
                    emp.getRole());
            return ResponseEntity.ok(response);
        }

        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid email or password");
    }

    @PostMapping("/logout")
    public ResponseEntity<?> logout() {
        return ResponseEntity.ok("Logout successful");
    }

    // --- CRUD METHODS ---

    @PostMapping(value = "/add", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> addEmployee(
            @RequestParam("fullName") String fullName,
            @RequestParam("employeeId") String employeeId,
            @RequestParam("department") String department,
            @RequestParam("position") String position,
            @RequestParam("joinDate") String joinDate,
            @RequestParam("workStatus") String workStatus,
            @RequestParam("email") String email,
            @RequestParam("password") String password,
            @RequestParam(value = "role", defaultValue = "EMPLOYEE") String role,
            @RequestParam(value = "profileImage", required = false) MultipartFile profileImage) {

        if (employeeRepository.existsByEmployeeId(employeeId)) {
            return ResponseEntity.badRequest().body("Employee ID already exists");
        }

        if (employeeRepository.findByEmail(email).isPresent()) {
            return ResponseEntity.badRequest().body("Email already exists");
        }

        String filePath = null;
        if (profileImage != null && !profileImage.isEmpty()) {
            try {
                Files.createDirectories(Paths.get(uploadDir));
                String fileName = System.currentTimeMillis() + "_" + profileImage.getOriginalFilename();
                Path path = Paths.get(uploadDir + "/" + fileName);
                Files.copy(profileImage.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
                filePath = "uploads/" + fileName;
            } catch (IOException e) {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to upload image");
            }
        }

        // Build Employee directly with credentials (No User object)
        Employee employee = Employee.builder()
                .fullName(fullName)
                .employeeId(employeeId)
                .department(department)
                .position(position)
                .joinDate(joinDate)
                .workStatus(workStatus)
                .email(email) // Field added to Employee model
                .password(passwordEncoder.encode(password)) // Field added to Employee model
                .role(role) // Field added to Employee model
                .profileImageUrl(filePath)
                .build();

        employeeRepository.save(employee);
        return ResponseEntity.ok(employee);
    }

    @GetMapping
    public List<Employee> getEmployees() {
        return employeeRepository.findAll();
    }

    @GetMapping("/{email}")
    public ResponseEntity<?> getEmployeeByEmail(@PathVariable String email) {
        return employeeRepository.findByEmail(email)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PutMapping(value = "/{id}", consumes = { "multipart/form-data" })
    public ResponseEntity<?> updateEmployee(
            @PathVariable Long id,
            @ModelAttribute Employee updatedEmployee,
            @RequestParam(value = "profileImage", required = false) MultipartFile file) {

        Employee emp = employeeRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Employee not found"));

        // --- Basic Information ---
        emp.setFullName(updatedEmployee.getFullName());
        emp.setEmployeeId(updatedEmployee.getEmployeeId());
        emp.setDepartment(updatedEmployee.getDepartment());
        emp.setPosition(updatedEmployee.getPosition());
        emp.setJoinDate(updatedEmployee.getJoinDate());
        emp.setWorkStatus(updatedEmployee.getWorkStatus());

        // --- Account ---
        emp.setEmail(updatedEmployee.getEmail());
        emp.setRole(updatedEmployee.getRole());

        // --- Profile Information (NEW) ---
        emp.setKhmerName(updatedEmployee.getKhmerName());
        emp.setGender(updatedEmployee.getGender());
        emp.setBirthDate(updatedEmployee.getBirthDate());
        emp.setRelationshipStatus(updatedEmployee.getRelationshipStatus());

        // --- Contact ---
        emp.setPhoneNumber(updatedEmployee.getPhoneNumber());
        emp.setIdCard(updatedEmployee.getIdCard());

        // --- Work Extra ---
        emp.setResidency(updatedEmployee.getResidency());
        emp.setEmploymentType(updatedEmployee.getEmploymentType());

        // --- Handle Image Upload ---
        if (file != null && !file.isEmpty()) {
            try {

                String uploadDir = "uploads/";
                Path uploadPath = Paths.get(uploadDir);

                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                }

                String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
                Path filePath = uploadPath.resolve(fileName);

                Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

                emp.setProfileImageUrl("uploads/" + fileName);

            } catch (IOException e) {
                throw new RuntimeException("Could not save image file: " + e.getMessage());
            }
        }

        employeeRepository.save(emp);

        return ResponseEntity.ok(emp);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteEmployee(@PathVariable Long id) {
        Employee emp = employeeRepository.findById(id).orElseThrow();
        employeeRepository.delete(emp);
        return ResponseEntity.ok("Employee deleted");
    }

    // @PutMapping(value = "/{id}", consumes = {"multipart/form-data"})
    // public ResponseEntity<?> updateEmployee(
    // @PathVariable Long id,
    // @ModelAttribute Employee updatedEmployee, // Use ModelAttribute for form-data
    // @RequestParam(value = "profileImage", required = false) MultipartFile file) {

    // Employee emp = employeeRepository.findById(id)
    // .orElseThrow(() -> new RuntimeException("Employee not found"));

    // // Update fields
    // emp.setFullName(updatedEmployee.getFullName());
    // emp.setDepartment(updatedEmployee.getDepartment());
    // emp.setPosition(updatedEmployee.getPosition());
    // emp.setWorkStatus(updatedEmployee.getWorkStatus());
    // emp.setEmail(updatedEmployee.getEmail());
    // emp.setRole(updatedEmployee.getRole());
    // emp.setEmployeeId(updatedEmployee.getEmployeeId());
    // emp.setJoinDate(updatedEmployee.getJoinDate());

    // // Handle Image upload if a new one is provided
    // if (file != null && !file.isEmpty()) {
    // try {
    // // . Define the directory
    // String uploadDir = "uploads/";
    // Path uploadPath = Paths.get(uploadDir);

    // // . Create the folder if it doesn't exist
    // if (!Files.exists(uploadPath)) {
    // Files.createDirectories(uploadPath);
    // }

    // // . Create a unique filename (to avoid cache issues and name conflicts)
    // String fileName = System.currentTimeMillis() + "_" +
    // file.getOriginalFilename();
    // Path filePath = uploadPath.resolve(fileName);

    // // . Copy the file to the target location
    // Files.copy(file.getInputStream(), filePath,
    // StandardCopyOption.REPLACE_EXISTING);

    // // . Update the Database field
    // // This string is what the frontend will use:
    // http://localhost:8080/uploads/123_image.jpg
    // emp.setProfileImageUrl("uploads/" + fileName);

    // } catch (IOException e) {
    // throw new RuntimeException("Could not save image file: " + e.getMessage());
    // }
    // }

    // employeeRepository.save(emp);
    // return ResponseEntity.ok(emp);
    // }

}