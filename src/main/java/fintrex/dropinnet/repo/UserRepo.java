package fintrex.dropinnet.repo;

import fintrex.dropinnet.dto.SlimSelectDTO;
import fintrex.dropinnet.model.User;
import java.util.Optional;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepo extends CrudRepository<User, Integer> {

    @Query("SELECT `id` AS `value`,`username` AS `text` FROM `user` WHERE status='active'")
    Iterable<SlimSelectDTO> getIdAndUsername(@Param("search") String search);

    @Query("SELECT `id` AS `value`,`callname` AS `text` FROM `hris_new`.`employee` WHERE STATUS='active'")
    Iterable<SlimSelectDTO> getEmp(@Param("search") String search);

    @Query("SELECT `id` AS `value`,`name` AS `text` FROM `hris_new`.`branch` WHERE STATUS='active'")
    Iterable<SlimSelectDTO> getBranch(@Param("search") String search);

    @Query("SELECT `id` AS `value`,`username` AS `text` FROM `user` WHERE user_type=1 AND status='active'")
    Iterable<SlimSelectDTO> searchAdminUsers(@Param("search") String search);

    @Query("SELECT `id` FROM `user` WHERE `username`=:username")
    Integer getUserDetailsByUsername(@Param("username") String username);

    Optional<User> findByUsername(String username);

}
