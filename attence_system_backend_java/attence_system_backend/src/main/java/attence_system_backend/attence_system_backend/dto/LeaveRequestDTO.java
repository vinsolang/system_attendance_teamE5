package attence_system_backend.attence_system_backend.dto;

import java.time.LocalDate;

public class LeaveRequestDTO {

    public String type;
    public LocalDate startDate;
    public LocalDate endDate;
    public String reason;
}