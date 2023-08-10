package fintrex.dropinnet.repo;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import fintrex.dropinnet.model.AccessRequests;

/**
 *
 * @author Nevanjith
 */
@Repository
public interface AccessRequestRepo extends CrudRepository<AccessRequests, Integer> {
    
    Iterable<AccessRequests> findAllByTicketId(Integer ticketId);
    void deleteByTicketId(Integer ticketId);

}
