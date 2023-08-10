package fintrex.dropinnet.repo;

import fintrex.dropinnet.dto.SlimSelectDTO;
import fintrex.dropinnet.model.APP;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface TicketAPPRepo extends CrudRepository<APP, Integer> {

    @Query("SELECT `id` AS `value`,`name` AS `text` FROM `category_type` WHERE CTYPE=1 AND status='active'")
    Iterable<SlimSelectDTO> searchAPP(@Param("search") String search);

    @Query("SELECT `id` AS `value`,`name` AS `text` FROM `category_type` WHERE CTYPE=2 AND status='active'")
    Iterable<SlimSelectDTO> searchHard(@Param("search") String search);

    @Query("SELECT `id` AS `value`,`name` AS `text` FROM `category_type` WHERE CTYPE=4 AND status='active'")
    Iterable<SlimSelectDTO> searchIncident(@Param("search") String search);
}
