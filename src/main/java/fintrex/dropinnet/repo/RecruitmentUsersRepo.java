package fintrex.dropinnet.repo;


import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import fintrex.dropinnet.model.RecruitmentUsers;
/**
 *
 * @author Nevanjith
 */
@Repository
public interface RecruitmentUsersRepo extends CrudRepository<RecruitmentUsers, Integer> {


}
