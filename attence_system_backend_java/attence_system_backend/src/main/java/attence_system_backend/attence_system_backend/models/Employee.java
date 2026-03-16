package attence_system_backend.attence_system_backend.models;

import java.util.List;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "employees")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Employee {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // --- Basic Information ---
    private String fullName;
    
    @Column(unique = true, nullable = false)
    private String employeeId;
    
    private String department;
    private String position;
    private String joinDate; 
    private String workStatus;
    private String profileImageUrl; 

    // --- Authentication & Account (Formerly in User model) ---
    @Column(unique = true, nullable = false)
    private String email;

    @Column(nullable = false)
    private String password;

    private String role; // ADMIN, EMPLOYEE

    // -------------------------------
    // NEW PROFILE INFORMATION (Mobile App)
    // -------------------------------

    // Personal
    private String khmerName;
    private String gender;
    private String birthDate;
    private String relationshipStatus;

    // Contact
    private String phoneNumber;
    private String idCard;

    // Work extra
    private String residency;
    private String employmentType;

     // Relationship with attendance
    @OneToMany(mappedBy = "employee", cascade = CascadeType.ALL)
    private List<Attendance> attendances;

}