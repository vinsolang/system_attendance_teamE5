package attence_system_backend.attence_system_backend.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class DashboardController {
    
    @GetMapping("/dashboard")
    public String dashboard(){
        return "admin/dashboard";
    }
    @GetMapping("/attendence/status")
    public String attendance(){
        return "admin/page/attendance/attendence-status";
    }

}
