/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package fintrex.dropinnet.repo;

import fintrex.dropinnet.dto.SlimSelectDTO;
import fintrex.dropinnet.model.TicketJobType;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author Akash
 */
public interface TicketJobTypeRepo extends CrudRepository<TicketJobType, Integer> {

    @Query("SELECT `id` AS `value`,`name` AS `text` FROM `ticket_job_type`")
    Iterable<SlimSelectDTO> getJobType(@Param("search") String search);
}
