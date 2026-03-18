package attence_system_backend.attence_system_backend.repository;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import attence_system_backend.attence_system_backend.models.Employee;

public interface EmployeeRepository extends JpaRepository<Employee, Long> {
    
    boolean existsByEmployeeId(String employeeId);
    
    // Add this to support Login and Email uniqueness checks
    Optional<Employee> findByEmail(String email);
    
    boolean existsByEmail(String email);
    

    Optional<Employee> findByEmployeeId(String employeeId);

}