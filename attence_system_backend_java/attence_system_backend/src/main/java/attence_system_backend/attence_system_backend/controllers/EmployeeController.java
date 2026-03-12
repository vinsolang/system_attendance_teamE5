package attence_system_backend.attence_system_backend.controllers;

import java.io.IOException;
import java.nio.file.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import attence_system_backend.attence_system_backend.models.Employee;
import attence_system_backend.attence_system_backend.repository.EmployeeRepository;


@RestController
@RequestMapping("/api/employees")
@CrossOrigin(origins = "http://localhost:5173")
public class EmployeeController {

    @Autowired
    private EmployeeRepository employeeRepository;

    private final String uploadDir = "uploads"; // folder in backend project

    @PostMapping(value="/add", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> addEmployee(
            @RequestParam("fullName") String fullName,
            @RequestParam("employeeId") String employeeId,
            @RequestParam("department") String department,
            @RequestParam("position") String position,
            @RequestParam("joinDate") String joinDate,
            @RequestParam("workStatus") String workStatus,
            @RequestParam(value = "profileImage", required = false) MultipartFile profileImage
    ) {

        // Check duplicate employee ID
        if (employeeRepository.existsByEmployeeId(employeeId)) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("Employee ID already exists");
        }

        String filePath = null;
        if (profileImage != null && !profileImage.isEmpty()) {
            try {
                Files.createDirectories(Paths.get(uploadDir));
                filePath = uploadDir + System.currentTimeMillis() + "_" + profileImage.getOriginalFilename();
                Path path = Paths.get(filePath);
                Files.copy(profileImage.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
            } catch (IOException e) {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                        .body("Failed to upload image");
            }
        }

        Employee employee = Employee.builder()
                .fullName(fullName)
                .employeeId(employeeId)
                .department(department)
                .position(position)
                .joinDate(joinDate)
                .workStatus(workStatus)
                .profileImageUrl(filePath)
                .build();

        employeeRepository.save(employee);

        return ResponseEntity.ok(employee);
    }
}