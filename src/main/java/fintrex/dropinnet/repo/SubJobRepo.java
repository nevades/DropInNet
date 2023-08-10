/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package fintrex.dropinnet.repo;

import fintrex.dropinnet.dto.SlimSelectDTO;
import fintrex.dropinnet.model.SubJobType;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author Akash
 */
public interface SubJobRepo extends CrudRepository<SubJobType, Integer> {

    @Query("SELECT `id` AS `value`,`name` AS `text` FROM `ticket_sub_type` WHERE `main_type`=1")
    Iterable<SlimSelectDTO> searchsubType(@Param("search") String search);
}
