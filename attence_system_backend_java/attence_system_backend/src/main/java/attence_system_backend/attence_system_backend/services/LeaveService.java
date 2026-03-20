package attence_system_backend.attence_system_backend.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import attence_system_backend.attence_system_backend.dto.LeaveRequestDTO;
import attence_system_backend.attence_system_backend.models.LeaveRequest;
import attence_system_backend.attence_system_backend.repository.LeaveRepository;

import java.util.List;

@Service
public class LeaveService {

    @Autowired
    private LeaveRepository repo;

    // CREATE REQUEST
    public LeaveRequest create(LeaveRequestDTO dto) {
        LeaveRequest leave = new LeaveRequest();

        leave.setType(dto.type);
        leave.setStartDate(dto.startDate);
        leave.setEndDate(dto.endDate);
        leave.setReason(dto.reason);
        leave.setStatus("PENDING");

        return repo.save(leave);
    }

    // GET ALL
    public List<LeaveRequest> getAll() {
        return repo.findAll();
    }

    // UPDATE STATUS
    public LeaveRequest updateStatus(Long id, String status) {
        LeaveRequest leave = repo.findById(id).orElseThrow();

        leave.setStatus(status);
        return repo.save(leave);
    }
}