/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fintrex.dropinnet.repo;

import fintrex.dropinnet.dto.MisDTO;
import fintrex.dropinnet.dto.MisTicketDTO;
import fintrex.dropinnet.model.Ticket;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface MisRepo extends CrudRepository<Ticket, Integer> {

    @Query("SELECT IFNULL((SELECT `type` FROM `ticket_type` WHERE `id`= t.`ticket_type`),'Total') AS `t_type`,IFNULL((SELECT `name` FROM `category_type` WHERE `id`=t.`category`),'Sub Total') AS cat, SUM(IF(t.`ent_on` LIKE CONCAT(DATE_FORMAT(CURDATE(),'%Y-%m'),'%'),1,0)) AS `monthly_reported`, SUM(IF(t.`ent_on` LIKE CONCAT(DATE_FORMAT(CURDATE(),'%Y-%m'),'%') AND t.`status`=3,1,0)) AS `monthly_in_progress`, SUM(IF(t.`ent_on` LIKE CONCAT(DATE_FORMAT(CURDATE(),'%Y-%m'),'%') AND t.`status`=4,1,0)) AS `monthly_closed`, SUM(IF(t.`ent_on` BETWEEN CONCAT(DATE_FORMAT(CURDATE(),'%Y'),'-01-01') AND CURDATE(),1,0)) AS `yearly_reported`, SUM(IF(t.`ent_on` BETWEEN CONCAT(DATE_FORMAT(CURDATE(),'%Y'),'-01-01') AND CURDATE() AND t.`status`=3,1,0)) AS `yearly_in_progress`, SUM(IF(t.`ent_on` BETWEEN CONCAT(DATE_FORMAT(CURDATE(),'%Y'),'-01-01') AND CURDATE() AND t.`status`=4,1,0)) AS `yearly_closed`, SUM(IF(TRUE,1,0)) AS `all_reported`, SUM(IF(t.`status`=3,1,0)) AS `all_in_progress`, SUM(IF(t.`status`=4,1,0)) AS `all_closed` FROM `ticket` t GROUP BY t.`ticket_type`,t.`category` WITH ROLLUP")
    Iterable<MisDTO> getDatae();

    @Query("SELECT IF(e.department IS NOT NULL,(SELECT d.name FROM hris_new.department d WHERE d.id = e.department),'Total') AS branch,  IF(t.`ticket_type` IS NOT NULL,(SELECT `type` FROM `ticket_type` WHERE `id` = t.`ticket_type`), 'Sub Total') AS `t_type`,SUM(IF(t.`ent_on` LIKE CONCAT(DATE_FORMAT(CURDATE(),'%Y-%m'),'%'),1,0)) AS `monthly_reported`,SUM(IF(t.`ent_on` LIKE CONCAT(DATE_FORMAT(CURDATE(),'%Y-%m'),'%') AND t.`status`=3,1,0)) AS `monthly_in_progress`, SUM(IF(t.`ent_on` LIKE CONCAT(DATE_FORMAT(CURDATE(),'%Y-%m'),'%') AND t.`status`=4,1,0)) AS `monthly_closed`, SUM(IF(t.`ent_on` BETWEEN CONCAT(DATE_FORMAT(CURDATE(),'%Y'),'-01-01') AND CURDATE(),1,0)) AS `yearly_reported`, SUM(IF(t.`ent_on` BETWEEN CONCAT(DATE_FORMAT(CURDATE(),'%Y'),'-01-01') AND CURDATE() AND t.`status`=3,1,0)) AS `yearly_in_progress`, SUM(IF(t.`ent_on` BETWEEN CONCAT(DATE_FORMAT(CURDATE(),'%Y'),'-01-01') AND CURDATE() AND t.`status`=4,1,0)) AS `yearly_closed`, SUM(IF(TRUE,1,0)) AS `all_reported`, SUM(IF(t.`status`=3,1,0)) AS `all_in_progress`, SUM(IF(t.`status`=4,1,0)) AS `all_closed` FROM dropinnet.ticket t JOIN hris_new.`employee` e ON e.id = t.ent_by WHERE t.`ticket_type` IN (1,2) GROUP BY department,t.`ticket_type` WITH ROLLUP")
    Iterable<MisDTO> getBranchData();

    @Query("SELECT t.`id`,t.`code`, t.`subject`, t.`priority`,(SELECT `username` FROM `user`  WHERE `id` = t.`ent_by`) AS `ent_by`, (SELECT `username` FROM `user`  WHERE `id` = t.`assign_user`) AS`assign_user`, (SELECT `name` FROM `ticket_status`  WHERE `id` = t.`status`) AS `status` FROM dropinnet.`ticket` t JOIN hris_new.`employee` e ON e.`id` = t.`ent_by` LEFT JOIN hris_new.`department` d ON d.`id` = e.`department` WHERE e.`department` = (SELECT d.id FROM hris_new.`department` d WHERE d.name = :dep) AND t.`ticket_type` = (SELECT `id` FROM `ticket_type` WHERE `type` =:cat) AND (CASE :time WHEN 'monthly' THEN t.`ent_on` LIKE CONCAT(DATE_FORMAT(CURDATE(),'%Y-%m'),'%')WHEN 'ytd' THEN t.`ent_on` BETWEEN CONCAT(DATE_FORMAT(CURDATE(),'%Y'),'-01-01') AND CURDATE() ELSE TRUE END) AND (CASE :sts WHEN 'in-progress' THEN t.`status`= 3 WHEN 'closed' THEN t.`status`= 4 ELSE TRUE END)")
    Iterable<MisTicketDTO> getselectedData(@Param("dep") String department, @Param("cat") String category, @Param("time") String frquency, @Param("sts") String status);
   
    @Query("SELECT t.`id`,t.`code`, (SELECT `name` FROM `category_type`  WHERE `id` = t.`category`) AS`cat`, t.`subject`, t.`priority`,(SELECT `username` FROM `user`  WHERE `id` = t.`ent_by`) AS `ent_by`,(SELECT `username` FROM `user`  WHERE `id` = t.`assign_user`) AS`assign_user`, (SELECT `name` FROM `ticket_status`  WHERE `id` = t.`status`) AS `status`FROM dropinnet.`ticket` t  WHERE t.`ticket_type` = (SELECT `id` FROM `ticket_type` WHERE `type` =:type)AND t.`category` = (SELECT `id` FROM `category_type` WHERE `name` =:cat)AND (CASE :time WHEN 'monthly' THEN t.`ent_on` LIKE CONCAT(DATE_FORMAT(CURDATE(),'%Y-%m'),'%')WHEN 'ytd' THEN t.`ent_on` BETWEEN CONCAT(DATE_FORMAT(CURDATE(),'%Y'),'-01-01') AND CURDATE() ELSE TRUE END) AND (CASE :sts WHEN 'in-progress' THEN t.`status`= 3 WHEN 'closed' THEN t.`status`= 4 ELSE TRUE END)")
    Iterable<MisTicketDTO> getcategoryData(@Param("type") String type, @Param("cat") String category, @Param("time") String frquency, @Param("sts") String status);

}
