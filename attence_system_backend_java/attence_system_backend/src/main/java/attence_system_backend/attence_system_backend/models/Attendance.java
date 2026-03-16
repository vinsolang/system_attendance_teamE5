package attence_system_backend.attence_system_backend.models;

import java.time.LocalDateTime;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "attendances")
@Data
public class Attendance {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Relation with Employee
    @ManyToOne
    @JoinColumn(name = "employee_id_fk", nullable = false)
    private Employee employee;

    private LocalDateTime checkInTime;

    private LocalDateTime checkOutTime;

    private String deviceType; // Mobile, Tablet, Computer
}