/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package fintrex.dropinnet.repo;

import fintrex.dropinnet.model.Assign;
import fintrex.dropinnet.model.Ticket;
import org.springframework.data.repository.CrudRepository;

/**
 *
 * @author Akash
 */
public interface TicketAssignRepo extends CrudRepository<Assign, Integer> {

    Iterable<Assign> findAllByTicketId(Integer ticketId);
    void deleteByTicketId(Integer ticketId);
}
