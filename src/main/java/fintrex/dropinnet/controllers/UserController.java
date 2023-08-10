package fintrex.dropinnet.controllers;

import fintrex.dropinnet.dto.SlimSelectDTO;
import fintrex.dropinnet.model.User;
import fintrex.dropinnet.service.UserSerivice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jdbc.core.mapping.AggregateReference;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    UserSerivice ser;

    @GetMapping("")
    public Iterable<User> getAllUsers() {
        return ser.getAllUsers();
    }

    @GetMapping("/{id}")
    public User getUser(@PathVariable Integer id) {
        return ser.getUser(id);
    }

    @GetMapping("/save")
    public User getUser(String username, String name, Integer utype) {
        User user = new User();
        user.setName(name);
        user.setUsername(username);
        user.setUserType(AggregateReference.to(utype));
        return ser.saveUser(user);
    }

    @PostMapping("/search-users")
    public Iterable<SlimSelectDTO> searchUserTypes(@RequestParam String search) throws Exception {
        return ser.getUserIdAndName(search);
    }

    @PostMapping("/search-employee")
    public Iterable<SlimSelectDTO> searchEmp(@RequestParam String search) throws Exception {
        return ser.getEmp(search);
    }

    @PostMapping("/search-branch")
    public Iterable<SlimSelectDTO> getBranch(@RequestParam String search) throws Exception {
        return ser.getBranch(search);
    }

    @PostMapping("/search-admin-users")
    public Iterable<SlimSelectDTO> searchAdminUsers(@RequestParam String search) throws Exception {
        return ser.searchAdminUsers(search);
    }
}
