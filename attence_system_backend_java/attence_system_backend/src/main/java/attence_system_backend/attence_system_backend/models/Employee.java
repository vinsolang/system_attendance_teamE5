package attence_system_backend.attence_system_backend.models;

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

    private String fullName;
    private String employeeId;
    private String department;
    private String position;
    private String joinDate; // store as String for simplicity
    private String workStatus;

    private String profileImageUrl; // store file path or URL

    
}
