package attence_system_backend.attence_system_backend.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import attence_system_backend.attence_system_backend.dto.LeaveRequestDTO;
import attence_system_backend.attence_system_backend.models.LeaveRequest;
import attence_system_backend.attence_system_backend.services.LeaveService;

import java.util.List;

@RestController
@RequestMapping("/api/leaves")
@CrossOrigin(origins = "*") // allow Flutter + React
public class LeaveController {

    @Autowired
    private LeaveService service;

    // ================= CREATE =================
    @PostMapping
    public LeaveRequest create(@RequestBody LeaveRequestDTO dto) {
        return service.create(dto);
    }

    // ================= GET ALL =================
    @GetMapping
    public List<LeaveRequest> getAll() {
        return service.getAll();
    }

    // ================= UPDATE STATUS =================
    @PutMapping("/{id}/status")
    public LeaveRequest updateStatus(
            @PathVariable Long id,
            @RequestBody StatusRequest request) {

        return service.updateStatus(id, request.status);
    }

    // DTO inside controller
    static class StatusRequest {
        public String status;
    }
}