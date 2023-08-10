package fintrex.dropinnet.repo;

import fintrex.dropinnet.dto.SlimSelectDTO;
import fintrex.dropinnet.model.TicketType;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface TicketTypeRepo extends CrudRepository<TicketType, Integer> {

    @Query("SELECT `id` AS `value`,`type` AS `text` FROM `ticket_type` WHERE FIND_IN_SET(:uid,REPLACE(REPLACE(REPLACE(`user_types`,'[',''),']',''),' ','')) ")
    Iterable<SlimSelectDTO> getType(@Param("uid") String uid);
    
    @Query("SELECT `id` AS `value`,`type` AS `text` FROM `ticket_type` WHERE `type` like :search ORDER BY `type` LIMIT 20")
    Iterable<SlimSelectDTO> getAllType(@Param("search") String search);
    
}
