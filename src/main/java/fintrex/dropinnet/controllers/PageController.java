package fintrex.dropinnet.controllers;

import fintrex.dropinnet.service.PageService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class PageController {

    @GetMapping("/")
    public String index(HttpSession session) {
        if (session.getAttribute("dashboard").equals("2")) {
            return "dashboard";
        } else if (session.getAttribute("dashboard").equals("1")) {
            return "admin_dashboard";
        } else {
            return null;
        }

    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/home")
    public String das() {
        return "admin_dashboard";
    }
    @GetMapping("/dashboard")
    public String das1() {
        return "dashboard";
    }
//    @GetMapping("/user-type")
//    public String userType() {
//        return "admin/user_type";
//    }

    @GetMapping("/users")
    public String users() {
        return "admin/users";
    }

    @GetMapping("/user-types")
    public String userTypes() {
        return "admin/user_type";
    }

    @GetMapping("/index")
    public String dashboard(HttpSession session) {
        return index(session);
    }

    @GetMapping("/neva")
    public String neva() {
        return "user_type";
    }

//    @GetMapping("/home")
//    public String adminDashboard() {
//        return "admin_dashboard";
//    }
    @GetMapping("/categories")
    public String ticketCategory() {
        return "admin/ticket_categories";
    }

    @GetMapping("/incident")
    public String incident() {
        return "incident";
    }

    @GetMapping("/mis")
    public String mis() {
        return "mis";
    }

    @GetMapping("/job_reference")
    public String jobreport() {
        return "report/job_reference_report";
    }

    @GetMapping("/audit_report")
    public String report() {
        return "report/audit_report";
    }

    @Autowired
    PageService ser;

    @GetMapping("/pages")
    @ResponseBody
    public String getPages(HttpSession session) {
//        return ser.getPagesForUser(2 + "");
        Integer uid = (Integer) session.getAttribute("uid");
        return ser.getPagesForUser(uid.toString());
    }

//    @PostMapping("/login-user")
//    @ResponseBody
//    public String postLogin(HttpSession session) {
//        return ser.getPagesForUser(1 + "");
//    }
    @GetMapping("/uid")
    @ResponseBody
    public String uid(HttpSession session) {
        session.setAttribute("uid", 1);
        return session.getAttribute("uid").toString();
    }

}
