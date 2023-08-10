package fintrex.dropinnet.service;

import fintrex.dropinnet.dto.SlimSelectDTO;
import fintrex.dropinnet.model.User;
import fintrex.dropinnet.repo.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserSerivice {

    @Autowired
    UserRepo repo;

    public Iterable<User> getAllUsers() {
        return repo.findAll();
    }

    public User getUser(Integer id) {
        return repo.findById(id).orElse(null);
    }

    public User saveUser(User user) {

        return repo.save(user);
    }

    public Iterable<SlimSelectDTO> getUserIdAndName(String search) {
        return repo.getIdAndUsername("%" + search.trim() + "%");
    }

    public Iterable<SlimSelectDTO> getEmp(String search) {
        return repo.getEmp("%" + search.trim() + "%");
    }

    public Iterable<SlimSelectDTO> getBranch(String search) {
        return repo.getBranch("%" + search.trim() + "%");
    }

    public Iterable<SlimSelectDTO> searchAdminUsers(String search) {
        return repo.searchAdminUsers("%" + search.trim() + "%");
    }

    public User saveTicketType(User user) {

        return repo.save(user);
    }
}
