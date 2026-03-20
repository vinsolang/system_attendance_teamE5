package attence_system_backend.attence_system_backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import attence_system_backend.attence_system_backend.models.LeaveRequest;


public interface LeaveRepository extends JpaRepository<LeaveRequest, Long> {
}
