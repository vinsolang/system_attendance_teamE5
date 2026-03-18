package attence_system_backend.attence_system_backend.services;

import attence_system_backend.attence_system_backend.models.Attendance;
import attence_system_backend.attence_system_backend.models.Employee;
import attence_system_backend.attence_system_backend.repository.AttendanceRepository;
import attence_system_backend.attence_system_backend.repository.EmployeeRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

@Service
public class AttendanceService {

    @Autowired
    private AttendanceRepository attendanceRepository;

    @Autowired
    private EmployeeRepository employeeRepository;

    @Autowired
    private TelegramService telegramService;

    // --- Check-in ---
    public Attendance checkIn(Long employeeId, String deviceType) {
        Employee employee = employeeRepository.findById(employeeId)
                .orElseThrow(() -> new RuntimeException("Employee not found"));

        LocalDateTime now = LocalDateTime.now();

        // Today’s start and end
       LocalDateTime start = LocalDate.now().atStartOfDay();
        LocalDateTime end = LocalDate.now().atTime(23, 59, 59);

        Optional<Attendance> existing = attendanceRepository.findTopByEmployeeAndCheckInTimeBetweenOrderByCheckInTimeDesc(
            employee, start, end
        );

        if(existing.isPresent()) {
            throw new RuntimeException("Already checked in today");
        }

        Attendance attendance = Attendance.builder()
                .employee(employee)
                .checkInTime(now)
                .deviceType(deviceType)
                .build();

        attendanceRepository.save(attendance);

        // Send Telegram alert
        telegramService.sendTelegramAlert(employee.getFullName(), "CHECK_IN", now, deviceType);

        return attendance;
    }

    // --- Check-out ---
    public Attendance checkOut(Long employeeId, String deviceType) {
        Employee employee = employeeRepository.findById(employeeId)
                .orElseThrow(() -> new RuntimeException("Employee not found"));

        LocalDateTime now = LocalDateTime.now();
        LocalDateTime start = LocalDate.now().atStartOfDay();
        LocalDateTime end = LocalDate.now().atTime(LocalTime.MAX);

        Attendance attendance = attendanceRepository.findTopByEmployeeAndCheckInTimeBetweenOrderByCheckInTimeDesc(employee, start, end)
                .orElseThrow(() -> new RuntimeException("Please check-in first"));

        if (attendance.getCheckOutTime() != null) {
            throw new RuntimeException("Already checked out today");
        }

        attendance.setCheckOutTime(now);
        attendanceRepository.save(attendance);

        telegramService.sendTelegramAlert(employee.getFullName(), "CHECK_OUT", now, deviceType);

        return attendance;
    }

    // --- Today Attendance ---
    public Optional<Attendance> getTodayAttendance(Long employeeId) {
        Employee employee = employeeRepository.findById(employeeId)
                .orElseThrow(() -> new RuntimeException("Employee not found"));

        LocalDateTime start = LocalDate.now().atStartOfDay();
        LocalDateTime end = LocalDate.now().atTime(LocalTime.MAX);

        return attendanceRepository.findTopByEmployeeAndCheckInTimeBetweenOrderByCheckInTimeDesc(employee, start, end);
    }

    // --- Attendance History ---
    public List<Attendance> getHistory(Long employeeId) {
        Employee employee = employeeRepository.findById(employeeId)
                .orElseThrow(() -> new RuntimeException("Employee not found"));
        return attendanceRepository.findByEmployeeOrderByCheckInTimeDesc(employee);
    }
}