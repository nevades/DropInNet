/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fintrex.dropinnet.repo;

import fintrex.dropinnet.dto.SlimSelectDTO;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import fintrex.dropinnet.model.Recruitment;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author Nevanjith
 */
@Repository
public interface RecruitmentSelectRepo extends CrudRepository<Recruitment, Integer> {

    @Query("SELECT `id` AS `value`,`name` AS `text` FROM `hris_new`.`department` WHERE `status`='active'")
    Iterable<SlimSelectDTO> searchDep(@Param("search") String search);

    @Query("SELECT `id` AS `value`,`name` AS `text` FROM `hris_new`.`designation` WHERE `status`='active'")
    Iterable<SlimSelectDTO> searchDes(@Param("search") String search);

    @Query("SELECT `id` AS `value`,`name` AS `text` FROM `location` WHERE status='active'")
    Iterable<SlimSelectDTO> searchLoc(@Param("search") String search);

}
