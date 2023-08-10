/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fintrex.dropinnet.repo;

import fintrex.dropinnet.dto.TicketDTO;
import fintrex.dropinnet.model.TicketLog;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author Nevanjith
 */
public interface EditRepo extends CrudRepository<TicketLog, Integer> {

    Iterable<TicketLog> findByTicket(Integer ticket);

    @Query("SELECT (SELECT JSON_ARRAYAGG(JSON_OBJECT('id',`id`,'action',`action`,'data',`date`,'user',(SELECT `name` FROM `user` WHERE id=t2.`user`))) FROM `ticket_log` t2 WHERE `ticket`=t.`id`) AS `ticket_log` FROM `ticket` t WHERE t.`id`=33")
    TicketDTO getTicketInfo(@Param("id") Integer id);
    
}
