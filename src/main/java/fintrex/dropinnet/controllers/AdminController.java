package fintrex.dropinnet.controllers;

import fintrex.dropinnet.datatable.DataTableRequest;
import fintrex.dropinnet.datatable.DataTablesResponse;
import fintrex.dropinnet.dto.GetPagesDTO;
import fintrex.dropinnet.dto.SlimSelectDTO;
import fintrex.dropinnet.dto.UserDataTable;
import fintrex.dropinnet.dto.UserTypeDataTable;
import fintrex.dropinnet.model.TicketTypeCategory;
import fintrex.dropinnet.model.User;
import fintrex.dropinnet.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    AdminService service;

    @PostMapping("/users")
    public DataTablesResponse<UserDataTable> getUsers(@RequestBody DataTableRequest param) throws Exception {
        return service.getUsers(param);
    }

    @PostMapping("/userType")
    public DataTablesResponse<UserTypeDataTable> getUserType(@RequestBody DataTableRequest param) throws Exception {
        return service.getUserType(param);
    }

    @GetMapping("/user/{id}")
    public User getUser(@PathVariable Integer id) throws Exception {
        return service.getUser(id);
    }

    @GetMapping("/ticket/{id}")
    public TicketTypeCategory getTicketType(@PathVariable Integer id) throws Exception {
        return service.getTicketType(id);
    }

    @PostMapping("/user-type-save")
    public ResponseEntity<CommonResponse> saveUserType(@RequestParam String name, @RequestParam String dashboard, @RequestParam String pages) throws Exception {
        service.saveUserType(name, dashboard, pages);
        CommonResponse response = new CommonResponse("Success!", 200);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PostMapping("/user-type-update")
    public ResponseEntity<CommonResponse> updateUserType(@RequestParam Integer id, @RequestParam String name, @RequestParam String dashboard, @RequestParam String pages) throws Exception {
        service.updateUserType(id, name, dashboard, pages);
        CommonResponse response = new CommonResponse("Success!", 200);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PostMapping("/save-user")
    public ResponseEntity<CommonResponse> saveUser(@RequestParam String username, @RequestParam String name, @RequestParam Integer type) throws Exception {
        service.saveUser(name, username, type);
        CommonResponse response = new CommonResponse("Success!", 200);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PostMapping("/update-user")
    public ResponseEntity<CommonResponse> saveUser(@RequestParam Integer id, @RequestParam String username, @RequestParam String name, @RequestParam Integer type) throws Exception {
        service.updateUser(id, name, username, type);
        CommonResponse response = new CommonResponse("Success!", 200);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PostMapping("/deactivate-user")
    public ResponseEntity<CommonResponse> deactivateUser(@RequestParam Integer id) throws Exception {
        service.deactivateUser(id);
        CommonResponse response = new CommonResponse("Success!", 200);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PostMapping("/reactivate-user")
    public ResponseEntity<CommonResponse> reactivateUser(@RequestParam Integer id) throws Exception {
        service.reactivateUser(id);
        CommonResponse response = new CommonResponse("Success!", 200);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
    
    @PostMapping("/deactivate-user-Type")
    public ResponseEntity<CommonResponse> deactivateUserType(@RequestParam Integer id) throws Exception {
        service.deactivateUserType(id);
        CommonResponse response = new CommonResponse("Success!", 200);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PostMapping("/reactivate-user-Type")
    public ResponseEntity<CommonResponse> reactivateUserType(@RequestParam Integer id) throws Exception {
        service.reactivateUserType(id);
        CommonResponse response = new CommonResponse("Success!", 200);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PostMapping("/getpages")
    public GetPagesDTO getPage() throws Exception {
//    public Iterable<Page> getPage() throws Exception {
        return service.getPage();
    }

    @PostMapping("/get-userType")
    public GetPagesDTO getUserType(@RequestParam Integer id) throws Exception {
        return service.getSelectedPage(id);
    }

    @PostMapping("/search-user-types")
    public Iterable<SlimSelectDTO> searchUserTypes(@RequestParam String search) throws Exception {
        return service.getUserTypeIdAndName(search);
    }
    
    @PostMapping("/search-admin-types")
    public Iterable<SlimSelectDTO> searchAdminTypes(@RequestParam String search) throws Exception {
        return service.getAdminTypeIdAndName(search);
    }

    @PostMapping("/search-category-type")
    public Iterable<SlimSelectDTO> searchCategoryTypes(@RequestParam String search) throws Exception {
        return service.getCategoryTypeIdAndName(search);
    }

    @PostMapping("/search-dashboard")
    public Iterable<SlimSelectDTO> searchDashboard(@RequestParam String search) throws Exception {
        return service.getDashboard(search);
    }

    @PostMapping("/save-ticket-type")
    public ResponseEntity<CommonResponse> saveTicketType(@RequestParam String name, @RequestParam Integer categoryname) throws Exception {
        service.saveTicketType(name, categoryname);
        CommonResponse response = new CommonResponse("Success!", 200);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PostMapping("/update-ticket-type")
    public ResponseEntity<CommonResponse> updateTicketType(@RequestParam Integer id, @RequestParam String name, @RequestParam Integer categoryname) throws Exception {
        service.updateTicketType(id, name, categoryname);
        CommonResponse response = new CommonResponse("Success!", 200);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PostMapping("/deactivate-ticket-category")
    public ResponseEntity<CommonResponse> deactivateTicketCategory(@RequestParam Integer id) throws Exception {
        service.deactivateTicketCategory(id);
        CommonResponse response = new CommonResponse("Success!", 200);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PostMapping("/reactivate-ticket-category")
    public ResponseEntity<CommonResponse> reactivateTicketCategory(@RequestParam Integer id) throws Exception {
        service.reactivateTicketCategory(id);
        CommonResponse response = new CommonResponse("Success!", 200);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

}
