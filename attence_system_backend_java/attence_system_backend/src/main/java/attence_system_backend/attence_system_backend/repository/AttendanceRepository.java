package attence_system_backend.attence_system_backend.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import attence_system_backend.attence_system_backend.models.Attendance;
import attence_system_backend.attence_system_backend.models.Employee;

public interface AttendanceRepository extends JpaRepository<Attendance, Long> {

    // Get latest attendance record of employee
    Attendance findTopByEmployeeOrderByCheckInTimeDesc(Employee employee);

    // Get all attendance history of employee
    List<Attendance> findByEmployeeOrderByCheckInTimeDesc(Employee employee);

    // Find attendance that is not checked out yet
    Attendance findByEmployeeAndCheckOutTimeIsNull(Employee employee);

    // Find today's attendance (optional useful feature)
    List<Attendance> findByEmployeeAndCheckInTimeBetween(
            Employee employee,
            LocalDateTime start,
            LocalDateTime end
    );
}