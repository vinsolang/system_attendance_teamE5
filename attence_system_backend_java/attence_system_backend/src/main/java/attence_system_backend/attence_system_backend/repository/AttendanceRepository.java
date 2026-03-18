package attence_system_backend.attence_system_backend.repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import attence_system_backend.attence_system_backend.models.Attendance;
import attence_system_backend.attence_system_backend.models.Employee;

@Repository
public interface AttendanceRepository extends JpaRepository<Attendance, Long> {

    // Get all attendance of employee between start and end
    List<Attendance> findByEmployeeAndCheckInTimeBetween(Employee employee, LocalDateTime start, LocalDateTime end);
    
    // Get latest attendance record (today) for check-out
    Optional<Attendance> findTopByEmployeeAndCheckInTimeBetweenOrderByCheckInTimeDesc(Employee employee, LocalDateTime start, LocalDateTime end);

    // Optional: get last open record (no checkout)
    Optional<Attendance> findTopByEmployeeAndCheckOutTimeIsNullOrderByCheckInTimeDesc(Employee employee);

    // Get all attendance for an employee
    List<Attendance> findByEmployeeOrderByCheckInTimeDesc(Employee employee);
}