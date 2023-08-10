package fintrex.dropinnet.controllers;

import fintrex.dropinnet.datatable.DataTableRequest;
import fintrex.dropinnet.datatable.DataTablesResponse;
import fintrex.dropinnet.dto.CommentDataTable;
import fintrex.dropinnet.dto.MainMenuDataDTO;
import fintrex.dropinnet.dto.MisDTO;
import fintrex.dropinnet.dto.SlimSelectDTO;
import fintrex.dropinnet.dto.TicketCategoryDataTable;
import fintrex.dropinnet.dto.IncidentDataTable;
import fintrex.dropinnet.dto.TicketDTO;
import fintrex.dropinnet.dto.TicketDataTable;
import fintrex.dropinnet.dto.TicketTrackingDTO;
import fintrex.dropinnet.dto.UserCardDTO;
import fintrex.dropinnet.model.Ticket;
import fintrex.dropinnet.model.TicketLog;
import fintrex.dropinnet.service.TicketService;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/ticket")
public class TicketController {

    @Autowired
    private TicketService ser;

    @GetMapping("/get")
    public Iterable<TicketDTO> getTicket() throws Exception {
        return ser.getTickets();
    }

    @PostMapping("/shows")
    public DataTablesResponse<TicketDataTable> getTickets(@RequestBody DataTableRequest param, HttpSession session) throws Exception {
        return ser.getTickets(param, session.getAttribute("uid").toString());
    }

    @PostMapping("/comments")
    public DataTablesResponse<CommentDataTable> getComments(@RequestBody DataTableRequest param) throws Exception {
        return ser.getComments(param);
    }

    @PostMapping("/incident")
    public DataTablesResponse<IncidentDataTable> getIncident(@RequestBody DataTableRequest param) throws Exception {
        return ser.getIncident(param);
    }

    @PostMapping("/all")
    public DataTablesResponse<TicketDataTable> getApplicationTickets(@RequestBody DataTableRequest param, HttpSession session) throws Exception {
        return ser.getApplicationTickets(param, session.getAttribute("uid").toString());
    }

    @PostMapping("/category")
    public DataTablesResponse<TicketCategoryDataTable> getTicketCategory(@RequestBody DataTableRequest param) throws Exception {
        return ser.getTicketCategory(param);
    }

    @GetMapping("/show/{id}")
    public Ticket getTicket(@PathVariable Integer id) throws Exception {
        return ser.getTicket(id);
    }

    @PostMapping("/Data")
    public TicketDTO ticketData(@RequestParam Integer id) throws Exception {
        return ser.saveToTitketLog(id, "SEEN");
    }

    @PostMapping("/ticket-data")
    public TicketDTO ticketDatauser(@RequestParam Integer id) throws Exception {
        return ser.getUserTicketData(id);
    }
//    @PostMapping("/Data")
//    public TicketDTO ticketData(@RequestParam Integer id, HttpSession session) throws Exception {
//        return ser.saveToTitketLog(id, "SEEN", session.getAttribute("uid").toString());
//    }

    @GetMapping("/edit")
    public TicketDTO ticketDataa(@RequestParam Integer id) throws Exception {
        return ser.loadEditLog(id);
    }

    @PostMapping("/status-ticket")
    public ResponseEntity<CommonResponse> changeStatus(@RequestParam Integer ticketId, Integer type, Integer status) throws Exception {
        ser.changeStatus(ticketId, type, status);

        if (status.equals(3)) {
            ser.saveToTitketLog(ticketId, "In Progress");
        } else if (status.equals(2)) {
            ser.saveToTitketLog(ticketId, "Finish");
        } else {
            ser.saveToTitketLog(ticketId, "Finish");
        }
        CommonResponse response = new CommonResponse("Success!", 200);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

//    @PostMapping("/save-ticket-application")
    @RequestMapping(value = "/save-ticket-application", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<CommonResponse> saveApplication(@RequestParam String selected, @RequestParam Integer type, @RequestParam(required = false) Integer status, @RequestParam(required = false) Integer assign, @RequestParam Integer select_app, @RequestParam String priority, @RequestParam String subject, @RequestParam String description, @RequestParam Integer behalf) throws Exception {
        ser.saveApplication(selected, type, status, assign, select_app, priority, subject, description, behalf);
        CommonResponse response = new CommonResponse("Success!", 200);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PostMapping("/save-ticket-recruitment")
    public ResponseEntity<CommonResponse> saveRecruitment(@RequestParam String access, @RequestParam Integer type, @RequestParam String description, @RequestParam Integer behalf, @RequestParam String fullname, @RequestParam String calling, @RequestParam String epf, @RequestParam java.sql.Date joindate, @RequestParam String address, @RequestParam Integer phone, @RequestParam String nic, @RequestParam String department, @RequestParam String designation, @RequestParam String gender, @RequestParam String location) throws Exception {
        ser.saveRecruitment(access, type, description, behalf, fullname, calling, epf, joindate, address, phone, nic, department, designation, gender, location);
        CommonResponse response = new CommonResponse("Success!", 200);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PostMapping("/Update_new_reqruitment")
    public ResponseEntity<CommonResponse> updateNewReq(@RequestParam Integer ticketId, @RequestParam String assetlist, @RequestParam String pc_username_input, @RequestParam String email_input, @RequestParam String system_username_input) throws Exception {
        ser.updateRecruitment(ticketId, assetlist, pc_username_input, email_input, system_username_input);
        System.out.println(pc_username_input);
        CommonResponse response = new CommonResponse("Success!", 200);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PostMapping("/save-ticket-termination")
    public ResponseEntity<CommonResponse> saveTermination(@RequestParam Integer type, @RequestParam Integer behalf, @RequestParam Integer employee, @RequestParam Date lastdate, @RequestParam String access) throws Exception {
        ser.saveTermination(type, behalf, employee, lastdate, access);
        CommonResponse response = new CommonResponse("Success!", 200);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PostMapping("/save-ticket-transfer")
    public ResponseEntity<CommonResponse> saveTransfer(@RequestParam Integer type, @RequestParam Integer behalf, @RequestParam String employee, @RequestParam String department, @RequestParam String branch, @RequestParam String designation) throws Exception {
        ser.saveTransfer(type, behalf, employee, department, branch, designation);
        CommonResponse response = new CommonResponse("Success!", 200);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PostMapping("/assign")
    public ResponseEntity<CommonResponse> saveAssign(@RequestParam Integer type, @RequestParam String user, @RequestParam Integer ticketId) throws Exception {

        ser.saveAssign(type, user, ticketId);

        CommonResponse response = new CommonResponse("Success!", 200);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PostMapping("/assign-user")
    public ResponseEntity<CommonResponse> saveAssignUser(@RequestParam String user, @RequestParam Integer ticketId) throws Exception {

        ser.saveAssignUser(user, ticketId);

        CommonResponse response = new CommonResponse("Success!", 200);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

//    @PostMapping("/save-ticket-hardware")
    @RequestMapping(value = "/save-ticket-hardware", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<CommonResponse> saveHardware(@RequestParam String selected, @RequestParam Integer type, @RequestParam(required = false) Integer status, @RequestParam(required = false) Integer assign, @RequestParam Integer select_hard, @RequestParam String priority, @RequestParam String subject, @RequestParam String description, @RequestParam Integer behalf, @RequestParam Integer user) throws Exception {
        ser.saveHardware(selected, type, status, assign, select_hard, priority, subject, description, behalf, user);
        CommonResponse response = new CommonResponse("Success!", 200);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PostMapping("/save-chat")
    public ResponseEntity<CommonResponse> saveChat(@RequestParam String chat, @RequestParam Integer ticketId) throws Exception {
        ser.saveChat(chat, ticketId);
        CommonResponse response = new CommonResponse("Success!", 200);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PostMapping("/save-comment")
    public ResponseEntity<CommonResponse> saveComments(@RequestParam Integer ticketId, @RequestParam String status) throws Exception {
        ser.saveComments(ticketId, status);
        CommonResponse response = new CommonResponse("Success!", 200);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PostMapping("/save-comment-text")
    public ResponseEntity<CommonResponse> saveCommentsText(@RequestParam Integer ticketId, @RequestParam String comment) throws Exception {
        ser.saveCommentsText(ticketId, comment);
        CommonResponse response = new CommonResponse("Success!", 200);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PostMapping("/save-ticket-incident")
    public ResponseEntity<CommonResponse> saveIncident(@RequestParam Integer type, @RequestParam(required = false) Integer status, @RequestParam Integer incident_type, @RequestParam(required = false) Integer assign, @RequestParam String time_of_incident, @RequestParam String nature_of_incident, @RequestParam Integer behalf, @RequestParam Integer user) throws Exception {
        ser.saveIncident(type, assign, status, incident_type, time_of_incident, nature_of_incident, behalf, user);
        CommonResponse response = new CommonResponse("Success!", 200);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PostMapping("/change_category")
    public ResponseEntity<CommonResponse> changeCategory(@RequestParam Integer tctId, @RequestParam Integer type) throws Exception {
        ser.changeCategory(tctId, type);
        CommonResponse response = new CommonResponse("Success!", 200);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PostMapping("/reactivate-ticket")
    public ResponseEntity<CommonResponse> reactivateTicket(@RequestParam Integer id) throws Exception {
        ser.reactivateTicket(id);
        CommonResponse response = new CommonResponse("Success!", 200);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PostMapping("/closed-ticket")
    public ResponseEntity<CommonResponse> closedTicket(@RequestParam Integer tctId) throws Exception {
        ser.closedTicket(tctId);
        CommonResponse response = new CommonResponse("Success!", 200);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PostMapping("/rate-ticket")
    public ResponseEntity<CommonResponse> rateTicket(@RequestParam Integer ticketId, @RequestParam Integer rate) throws Exception {
        ser.rateTicket(ticketId, rate);
        CommonResponse response = new CommonResponse("Success!", 200);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PostMapping("/re-open-ticket")
    public ResponseEntity<CommonResponse> reOpenTicket(@RequestParam Integer ticketId, @RequestParam String comment) throws Exception {
        ser.reOpenTicket(ticketId, comment);
        CommonResponse response = new CommonResponse("Success!", 200);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @GetMapping({"/count"})
    public Iterable<MainMenuDataDTO> showCount(HttpSession session,HttpSession ses) throws Exception {
        return ser.showCount(session.getAttribute("uid").toString(),ses.getAttribute("type").toString());
    }

    @PostMapping("/search-type")
    public Iterable<SlimSelectDTO> searchType(HttpSession session) throws Exception {
        return ser.getType(session.getAttribute("type").toString());
    }

    @PostMapping("/search-job-type")
    public Iterable<SlimSelectDTO> searchjobType(@RequestParam String search) throws Exception {
        return ser.getJobType(search);
    }

    @PostMapping("/search-job-sub")
    public Iterable<SlimSelectDTO> searchsubType(@RequestParam String search) throws Exception {
        return ser.searchsubType(search);
    }

    @PostMapping("/get-app")
    public Iterable<SlimSelectDTO> searchAPP(@RequestParam String search) throws Exception {
        return ser.searchAPP(search);
    }

    @PostMapping("/get-dep")
    public Iterable<SlimSelectDTO> searchDep(@RequestParam String search) throws Exception {
        return ser.searchDep(search);
    }

    @PostMapping("/get-des")
    public Iterable<SlimSelectDTO> searchDes(@RequestParam String search) throws Exception {
        return ser.searchDes(search);
    }

    @PostMapping("/get-loc")
    public Iterable<SlimSelectDTO> searchLoc(@RequestParam String search) throws Exception {
        return ser.searchLoc(search);
    }

    @PostMapping("/get-hard")
    public Iterable<SlimSelectDTO> searchHard(@RequestParam String search) throws Exception {
        return ser.searchHard(search);
    }

    @PostMapping("/get-incident")
    public Iterable<SlimSelectDTO> searchIncident(@RequestParam String search) throws Exception {
        return ser.searchIncident(search);
    }

    @GetMapping("/cards")
    public Iterable<UserCardDTO> getCardCount(HttpSession session) throws Exception {
        return ser.getCardCount(session.getAttribute("uid").toString());
    }
}
