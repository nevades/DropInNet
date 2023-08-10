package fintrex.dropinnet.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import fintrex.dropinnet.datatable.DataTableRepo;
import fintrex.dropinnet.datatable.DataTableRequest;
import fintrex.dropinnet.datatable.DataTablesResponse;
import fintrex.dropinnet.dto.CommentDataTable;
import fintrex.dropinnet.dto.IncidentDataTable;
import fintrex.dropinnet.dto.MainMenuDataDTO;
import fintrex.dropinnet.dto.SlimSelectDTO;
import fintrex.dropinnet.dto.TicketCategoryDataTable;
import fintrex.dropinnet.dto.TicketDTO;
import fintrex.dropinnet.dto.TicketDataTable;
import fintrex.dropinnet.dto.TicketTrackingDTO;
import fintrex.dropinnet.dto.UserCardDTO;
import fintrex.dropinnet.model.AccessRequests;
import fintrex.dropinnet.model.Assign;
import fintrex.dropinnet.model.RecruitmentUsers;
import fintrex.dropinnet.model.TerminationUsers;
import fintrex.dropinnet.model.Ticket;
import fintrex.dropinnet.model.Chat;
import fintrex.dropinnet.model.Comments;
import fintrex.dropinnet.model.TicketLog;
import fintrex.dropinnet.model.TicketTypeCategory;
import fintrex.dropinnet.model.TransferPromotionUsers;
import fintrex.dropinnet.repo.AccessRequestRepo;
import fintrex.dropinnet.repo.ChatRepo;
import fintrex.dropinnet.repo.CommentRepo;
import fintrex.dropinnet.repo.SubJobRepo;
import fintrex.dropinnet.repo.RecruitmentSelectRepo;
import fintrex.dropinnet.repo.RecruitmentUsersRepo;
import fintrex.dropinnet.repo.TerminationUsersRepo;
import fintrex.dropinnet.repo.TicketRepo;
import fintrex.dropinnet.repo.TicketTypeRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import fintrex.dropinnet.repo.TicketAPPRepo;
import fintrex.dropinnet.repo.TicketAssignRepo;
import fintrex.dropinnet.repo.TicketJobTypeRepo;
import fintrex.dropinnet.repo.TicketLogRepo;
import fintrex.dropinnet.repo.TransferPromotionUsersRepo;
import fintrex.dropinnet.repo.TypeCategoryRepo;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import org.springframework.data.repository.query.Param;

@Service
public class TicketService {

    @Autowired
    private TicketRepo repo;

    @Autowired
    private ChatRepo chatrepo;

    @Autowired
    private CommentRepo comrepo;

    @Autowired
    private RecruitmentUsersRepo rec;

    @Autowired
    private AccessRequestRepo arr;

    @Autowired
    private TerminationUsersRepo ter;

    @Autowired
    private TransferPromotionUsersRepo tpur;

    @Autowired
    private TicketAssignRepo repos;

    @Autowired
    TypeCategoryRepo tc_repo;

    @Autowired
    TicketTypeRepo t_repo;

    @Autowired
    TicketJobTypeRepo job_repo;

    @Autowired
    SubJobRepo sub_job_repo;

    @Autowired
    TicketAPPRepo app_repo;

    @Autowired
    RecruitmentSelectRepo rec_repo;

    @Autowired
    TicketLogRepo ticketLogRepo;

    @Autowired
    private DataTableRepo<TicketDataTable> ticketDT;
    @Autowired
    private DataTableRepo<CommentDataTable> commentDT;
    @Autowired
    private DataTableRepo<IncidentDataTable> IncidentDT;

    @Autowired
    private DataTableRepo<TicketCategoryDataTable> ticketCategoryDT;

    public DataTablesResponse<TicketDataTable> getTickets(DataTableRequest param, String uid) throws Exception {

//        String filter = "";
//        if (!(param.getData() == null || param.getData().equals(""))) {
//            ObjectMapper mapper = new ObjectMapper();
//            JsonNode obj = mapper.readTree(param.getData());
//            filter += " AND `status`='" + obj.get("status").asText() + "'";
//
//        }
//
//        if (filter.equals(" AND `status`='10'")) {
//            return ticketDT.getData(TicketDataTable.class, param, "SELECT `id`,`code`,(SELECT `type` FROM `ticket_type` WHERE `id`=t.`ticket_type`) AS `ticketType`,`priority`,`subject`,`description`,(SELECT `username` FROM `user` WHERE `id`=t.`mod_by`) AS `modBy`,`mod_on` AS `modOn`, (SELECT `id` FROM `ticket_status` WHERE `id`=t.`status`) AS `status` FROM dropinnet.ticket WHERE ent_by IN (SELECT id FROM hris_new.employee WHERE department = (SELECT department FROM hris_new.employee WHERE id =:uid))");
//
//        }
////        else {
//        System.out.println(" SELECT `id`,`code`,(SELECT `type` FROM `ticket_type` WHERE `id`=t.`ticket_type`) AS `ticketType`,`priority`,`subject`,`description`,(SELECT `username` FROM `user` WHERE `id`=t.`mod_by`) AS `modBy`,`mod_on` AS `modOn`, (SELECT `id` FROM `ticket_status` WHERE `id`=t.`status`) AS `status` FROM `ticket` t WHERE `ent_by` =" + uid + " AND " + ((param.getData().equals("10")) ? "`ent_by` IN ((SELECT id FROM hris_new.employee WHERE department = (SELECT department FROM hris_new.employee WHERE id = 3))) " : ((param.getData() == null || param.getData().equals("")) ? " TRUE " : " `status`='" + param.getData() + "'")) + " " + (param.getFilter().equals("3") ? " AND MONTH(`mod_on`) = MONTH(CURDATE()) AND YEAR(`mod_on`) = YEAR(CURDATE())" : "") + " " + (param.getFilter().equals("2") ? " AND DATE(`mod_on`) = CURDATE()" : ""));
        return ticketDT.getData(TicketDataTable.class, param, "SELECT `id`,`code`,(SELECT `type` FROM `ticket_type` WHERE `id`=t.`ticket_type`) AS `ticketType`,`priority`,`subject`,`description`,(SELECT `username` FROM `user` WHERE `id`=t.`mod_by`) AS `modBy`,`mod_on` AS `modOn`, (SELECT `id` FROM `ticket_status` WHERE `id`=t.`status`) AS `status` FROM `ticket` t WHERE `ent_by` =" + uid + " AND " + ((param.getData().equals("10")) ? "`ent_by` IN ((SELECT `id` FROM `hris_new`.`employee` WHERE `department` = (SELECT `department` FROM `hris_new`.`employee` WHERE `id` = 3))) " : ((param.getData() == null || param.getData().equals("")) ? " TRUE " : " `status`='" + param.getData() + "'")) + " " + (param.getFilter().equals("3") ? " AND MONTH(`mod_on`) = MONTH(CURDATE()) AND YEAR(`mod_on`) = YEAR(CURDATE())" : "") + " " + (param.getFilter().equals("2") ? " AND DATE(`mod_on`) = CURDATE()" : "") + " " + (param.getFilter().equals("4") ? " AND YEAR(`mod_on`) = YEAR(CURDATE()) AND WEEK(`mod_on`) = WEEK(CURDATE())" : "") + " " + (param.getFilter().equals("5") ? " AND YEAR(`mod_on`) = YEAR(CURDATE())" : ""));
//
//        }
//
//        if ((param.getData().equals("10"))) {
//            return ticketDT.getData(TicketDataTable.class, param, "SELECT `id`,`code`,(SELECT `type` FROM `ticket_type` WHERE `id`=t.`ticket_type`) AS `ticketType`,`priority`,`subject`,`description`,(SELECT `username` FROM `user` WHERE `id`=t.`mod_by`) AS `modBy`,`mod_on` AS `modOn`, (SELECT `id` FROM `ticket_status` WHERE `id`=t.`status`) AS `status` FROM dropinnet.ticket WHERE ent_by IN (SELECT id FROM hris_new.employee WHERE department = (SELECT department FROM hris_new.employee WHERE id =:uid))");
////            return ticketDT.getData(TicketDataTable.class, param, "SELECT `id`, `code`, (SELECT `type` FROM `ticket_type` WHERE `id` = t.`ticket_type`) AS `ticketType`, `priority`, `subject`, `description`, (SELECT `username` FROM `user` WHERE `id` = t.`mod_by`) AS `modBy`, `mod_on` AS `modOn`, (SELECT `id` FROM `ticket_status` WHERE `id` = t.`status`) AS `status` FROM dropinnet.ticket WHERE ent_by IN (SELECT id FROM hris_new.employee WHERE department = (SELECT department FROM hris_new.employee WHERE id = :uid));");
//        } else {
//            return ticketDT.getData(TicketDataTable.class, param, "SELECT `id`,`code`,(SELECT `type` FROM `ticket_type` WHERE `id`=t.`ticket_type`) AS `ticketType`,`priority`,`subject`,`description`,(SELECT `username` FROM `user` WHERE `id`=t.`mod_by`) AS `modBy`,`mod_on` AS `modOn`, (SELECT `id` FROM `ticket_status` WHERE `id`=t.`status`) AS `status` FROM `ticket` t WHERE `ent_by` =" + uid + " AND " + ((param.getData() == null || param.getData().equals("")) ? "TRUE" : "`status`='" + param.getData() + "'") + " " + (param.getFilter().equals("3") ? " AND MONTH(`mod_on`) = MONTH(CURDATE()) AND YEAR(`mod_on`) = YEAR(CURDATE())" : "") + " " + (param.getFilter().equals("2") ? " AND DATE(`mod_on`) = CURDATE()" : ""));
//        }

//        return ticketDT.getData(TicketDataTable.class, param, "SELECT `id`,`code`,(SELECT `type` FROM `ticket_type` WHERE `id`=t.`ticket_type`) AS `ticketType`,`priority`,`subject`,`description`,(SELECT `username` FROM `user` WHERE `id`=t.`mod_by`) AS `modBy`,`mod_on` AS `modOn`, (SELECT `id` FROM `ticket_status` WHERE `id`=t.`status`) AS `status` FROM `ticket` t WHERE `ent_by` =" + uid + " AND " + ((param.getData() == null || param.getData().equals("")) ? "TRUE" : "`status`='" + param.getData() + "'"));
//        String filter = "";
//        if (!(param.getData() == null || param.getData().equals(""))) {
//            ObjectMapper mapper = new ObjectMapper();
//            JsonNode obj = mapper.readTree(param.getData());
//            filter += " AND `status`='" + obj.get("status").asText() + "'";
//
//        }
//
//        if (filter.equals(" AND `status`='10'")) {
//
//            return ticketDT.getData(TicketDataTable.class, param, "SELECT  `id`,`code`,(SELECT `type` FROM `ticket_type` WHERE `id`=`ticket_type`) AS `ticketType`,`priority`,`subject`,`description`,(SELECT `username` FROM `user` WHERE `id`=`mod_by`) AS `modBy`,`mod_on` AS `modOn`, (SELECT `id` FROM `ticket_status` WHERE `id`=`status`) AS `status` FROM dropinnet.ticket WHERE ent_by IN (SELECT id FROM hris_new.employee WHERE department = (SELECT department FROM hris_new.employee WHERE id ="+uid+"))");
//        } else {
//            return ticketDT.getData(TicketDataTable.class, param, "SELECT `id`,`code`,(SELECT `type` FROM `ticket_type` WHERE `id`=t.`ticket_type`) AS `ticketType`,`priority`,`subject`,`description`,(SELECT `username` FROM `user` WHERE `id`=t.`mod_by`) AS `modBy`,`mod_on` AS `modOn`, (SELECT `id` FROM `ticket_status` WHERE `id`=t.`status`) AS `status` FROM `ticket` t WHERE `ent_by` =" + uid + " AND " + ((param.getData() == null || param.getData().equals("")) ? "TRUE" : "`status`='" +filter + "'") + " " + (param.getFilter().equals("3") ? " AND MONTH(`mod_on`) = MONTH(CURDATE()) AND YEAR(`mod_on`) = YEAR(CURDATE())" : "") + " " + (param.getFilter().equals("2") ? " AND DATE(`mod_on`) = CURDATE()" : ""));
//
//        }
    }

    public DataTablesResponse<CommentDataTable> getComments(DataTableRequest param) throws Exception {
        return commentDT.getData(CommentDataTable.class, param, "SELECT `id`,(SELECT `username` FROM `user` WHERE id=`user_id`) AS `user`, `comment`, `date` AS `dateandtime`, `status` FROM `comments` WHERE `ticket_id`='" + param.getData() + "'");
    }

    public DataTablesResponse<IncidentDataTable> getIncident(DataTableRequest param) throws Exception {
        return IncidentDT.getData(IncidentDataTable.class, param, "SELECT `id`,`code`,`status`,`time_of_incident`,`description` FROM `ticket` WHERE `code` LIKE 'IC%'");
    }

    public DataTablesResponse<TicketDataTable> getApplicationTickets(DataTableRequest param, @Param("uid") String uid) throws Exception {
//        return ticketDT.getData(TicketDataTable.class, param, "SELECT `id`,`code`,(SELECT `type` FROM `ticket_type` WHERE `id`=t.`ticket_type`) AS `ticketType`,(SELECT `name` FROM `category_type` WHERE `id`=t.`category`) AS `category`,`priority`,`subject`,`description`,`time_of_incident`,(SELECT `username` FROM `user` WHERE `id`=t.`ent_by`) AS `entBy`,(SELECT `username` FROM `user` WHERE `id`=t.`behalf`) AS `behalf`,`ent_on` AS `entOn`,(SELECT `name` FROM `ticket_status` WHERE `id`=t.`status`) AS `status`,(SELECT `username` FROM `user` WHERE `id`=t.`assigned_to`) AS`assignedTo`,(SELECT JSON_OBJECT('user',(SELECT `username` FROM `user` WHERE `id`=tl.`user`),'date',DATE_FORMAT(`date`,'%Y-%m-%d %h:%i:%s')) FROM `ticket_log` tl WHERE `ticket`=t.`id` ORDER BY `date` DESC LIMIT 1) AS`seenBy` FROM `ticket` t WHERE " + ((param.getData() == null || param.getData().equals("")) ? "TRUE" : "`ticket_type`='" + param.getData() + "'"));

        String type = "";
        if (!(param.getData() == null || param.getData().equals(""))) {
            ObjectMapper mapper = new ObjectMapper();
            JsonNode obj = mapper.readTree(param.getData());
            String val = obj.get("ticketType").asText();
            if (val.equals("3")) {
                type += " AND `ticket_type` in ('3','5','6')";
            } else {
                type += " AND `ticket_type`='" + val + "'";
            }

        }

        String filter = "";
        if (!(param.getData() == null || param.getData().equals(""))) {
            ObjectMapper mapper = new ObjectMapper();
            JsonNode obj = mapper.readTree(param.getData());
            filter += " AND `status`='" + obj.get("status").asText() + "'";

        }

        if (filter.equals(" AND `status`='8'")) {

            return ticketDT.getData(TicketDataTable.class, param, "SELECT t.id, t.code, (SELECT TYPE FROM ticket_type WHERE id = t.ticket_type) AS ticketType, (SELECT NAME FROM category_type WHERE id = t.category) AS category, t.priority,t.subject,t.description, t.time_of_incident,(SELECT username FROM USER WHERE id = t.ent_by) AS entBy, (SELECT username FROM USER WHERE id = t.behalf) AS behalf, t.ent_on AS entOn, t.status,(SELECT JSON_OBJECT( 'user', COALESCE((SELECT username FROM USER WHERE id = tl.user), ''), 'date', DATE_FORMAT(COALESCE(DATE, NOW()), '%Y-%m-%d %h:%i:%s')) FROM ticket_log tl WHERE ticket = t.id AND ACTION = 'seen' ORDER BY DATE DESC LIMIT 1 ) AS seenBy,(SELECT JSON_ARRAYAGG( JSON_OBJECT('user', (SELECT username FROM USER WHERE id = tl.user_id), 'ticket', tl.ticket_id, 'type', tl.type)) FROM ticket_assign tl WHERE ticket_id = t.id ) AS assignee_type,(SELECT JSON_ARRAYAGG(JSON_OBJECT('id',`id`,'fname',`fullname`,'epf',`epf`,'designation',(SELECT `name` FROM hris_new.`designation` WHERE id=r.`designation`),'nic',`nic`,'location',(SELECT `name` FROM `location` WHERE id=r.`location`),'branch',(SELECT `name` FROM hris_new.`department` WHERE id=r.`department`),'ent_by',(SELECT `username` FROM `user` WHERE `id` = t.`ent_by`),'ent_on',r.`ent_on` )) FROM `recruitment_users` r WHERE `ticket_id`=t.`id`) AS `rec_data`,(SELECT JSON_ARRAYAGG(JSON_OBJECT('lastdate', tu.`last_date`,'join-date', e.`joined_date`,'epf', e.`epf`,'phone', e.`mobile`,'nic', e.`nic`,'fullname', CONCAT_WS(' ',e.`fname`,e.`lname`,e.`surname`),'designation',(SELECT `name` FROM hris_new.`designation` WHERE id = e.`designation`),'gender',e.`sex`,'dep',(SELECT `name` FROM hris_new.`department` WHERE id = e.`department`),'address',CONCAT(e.`p_address`, '-', e.`p_address_2`),'ent_by',(SELECT `username` FROM `user` WHERE `id` = tu.`ent_by`),'location',(SELECT `name_en` FROM hris_new.`cities` WHERE id = e.`p_city`),'ent_on',tu.`ent_on`))FROM `termination_users` tu JOIN hris_new.`employee` e ON tu.`employee_id`=e.`id` WHERE tu.`ticket_id`=t.`id`)AS ter_data,(SELECT JSON_ARRAYAGG(JSON_OBJECT('epf', e.`epf`,'location',(SELECT `name_en` FROM hris_new.`cities` WHERE id = e.`p_city`),'nic', e.`nic`,'designation',(SELECT `name` FROM hris_new.`designation` WHERE id = e.`designation`),'dep',(SELECT `name` FROM hris_new.`department` WHERE id = e.`department`),'ent_by',(SELECT `username` FROM `user` WHERE `id` = tp.`ent_by`),'ent_on',tp.`ent_on`,'fullname', CONCAT_WS(' ',e.`fname`,e.`lname`,e.`surname`)))FROM `transfer_promotion_users` tp JOIN hris_new.`employee` e ON tp.`emp_id`=e.`id` WHERE tp.`ticket_id`=t.`id`)AS tp_data FROM ticket t JOIN ticket_log tl ON t.id = tl.ticket WHERE tl.`action`='finish' AND `user`='" + uid + "'" + type);
        } else if (filter.equals(" AND `status`='7'")) {

//            return ticketDT.getData(TicketDataTable.class, param, "SELECT t.id, t.code,(SELECT TYPE FROM ticket_type WHERE id = t.ticket_type) AS ticketType,(SELECT NAME FROM category_type WHERE id = t.category) AS category, t.priority, t.subject, t.description, t.time_of_incident, (SELECT username FROM USER WHERE id = t.ent_by) AS entBy, (SELECT username FROM USER WHERE id = t.behalf) AS behalf, t.ent_on AS entOn, t.status, ( SELECT JSON_OBJECT('user', COALESCE((SELECT username FROM USER WHERE id = tl.user), ''),'date', DATE_FORMAT(COALESCE(DATE, NOW()), '%Y-%m-%d %h:%i:%s') ) FROM ticket_log tl WHERE ticket = t.id AND ACTION = 'seen' ORDER BY DATE DESC LIMIT 1) AS seenBy,( SELECT JSON_ARRAYAGG( JSON_OBJECT( 'user', (SELECT username FROM USER WHERE id = tl.user_id), 'ticket', tl.ticket_id,'type', tl.type )) FROM ticket_assign tl WHERE ticket_id = t.id ) AS assignee_type,(SELECT JSON_ARRAYAGG(JSON_OBJECT('id',`id`,'fname',`fullname`,'epf',`epf`,'designation',(SELECT `name` FROM hris_new.`designation` WHERE id=r.`designation`),'nic',`nic`,'location',(SELECT `name` FROM `location` WHERE id=r.`location`),'branch',(SELECT `name` FROM hris_new.`department` WHERE id=r.`department`),'ent_by',(SELECT `username` FROM `user` WHERE `id` = t.`ent_by`),'ent_on',r.`ent_on` )) FROM `recruitment_users` r WHERE `ticket_id`=t.`id`) AS `rec_data`,(SELECT JSON_ARRAYAGG(JSON_OBJECT('lastdate', tu.`last_date`,'join-date', e.`joined_date`,'epf', e.`epf`,'phone', e.`mobile`,'nic', e.`nic`,'fullname', CONCAT_WS(' ',e.`fname`,e.`lname`,e.`surname`),'designation',(SELECT `name` FROM hris_new.`designation` WHERE id = e.`designation`),'gender',e.`sex`,'dep',(SELECT `name` FROM hris_new.`department` WHERE id = e.`department`),'address',CONCAT(e.`p_address`, '-', e.`p_address_2`),'ent_by',(SELECT `username` FROM `user` WHERE `id` = tu.`ent_by`),'location',(SELECT `name_en` FROM hris_new.`cities` WHERE id = e.`p_city`),'ent_on',tu.`ent_on`))FROM `termination_users` tu JOIN hris_new.`employee` e ON tu.`employee_id`=e.`id` WHERE tu.`ticket_id`=t.`id`)AS ter_data,(SELECT JSON_ARRAYAGG(JSON_OBJECT('epf', e.`epf`,'location',(SELECT `name_en` FROM hris_new.`cities` WHERE id = e.`p_city`),'nic', e.`nic`,'designation',(SELECT `name` FROM hris_new.`designation` WHERE id = e.`designation`),'dep',(SELECT `name` FROM hris_new.`department` WHERE id = e.`department`),'ent_by',(SELECT `username` FROM `user` WHERE `id` = tp.`ent_by`),'ent_on',tp.`ent_on`,'fullname', CONCAT_WS(' ',e.`fname`,e.`lname`,e.`surname`)))FROM `transfer_promotion_users` tp JOIN hris_new.`employee` e ON tp.`emp_id`=e.`id` WHERE tp.`ticket_id`=t.`id`)AS tp_data FROM ticket t JOIN ticket_assign ta ON t.id = ta.ticket_id WHERE ta.user_id = '" + uid + "'" + type);
//            return ticketDT.getData(TicketDataTable.class, param, "SELECT t.id, t.code,(SELECT TYPE FROM ticket_type WHERE id = t.ticket_type) AS ticketType,(SELECT NAME FROM category_type WHERE id = t.category) AS category, t.priority, t.subject, t.description, t.time_of_incident, (SELECT username FROM USER WHERE id = t.ent_by) AS entBy, (SELECT username FROM USER WHERE id = t.behalf) AS behalf, t.ent_on AS entOn, t.status, (SELECT JSON_OBJECT('user', COALESCE((SELECT username FROM USER WHERE id = tl.user), ''),'date', DATE_FORMAT(COALESCE(DATE, NOW()), '%Y-%m-%d %h:%i:%s') ) FROM ticket_log tl WHERE ticket = t.id AND ACTION = 'seen' ORDER BY DATE DESC LIMIT 1) AS seenBy,(SELECT JSON_ARRAYAGG( JSON_OBJECT( 'user', (SELECT username FROM USER WHERE id = tl.user_id), 'ticket', tl.ticket_id,'type', tl.type )) FROM ticket_assign tl WHERE ticket_id = t.id) AS assignee_type,(SELECT JSON_ARRAYAGG(JSON_OBJECT('id',`id`,'fname',`fullname`,'epf',`epf`,'designation',(SELECT `name` FROM hris_new.`designation` WHERE id=r.`designation`),'nic',`nic`,'location',(SELECT `name` FROM `location` WHERE id=r.`location`),'branch',(SELECT `name` FROM hris_new.`department` WHERE id=r.`department`),'ent_by',(SELECT `username` FROM `user` WHERE `id` = t.`ent_by`),'ent_on',r.`ent_on` )) FROM `recruitment_users` r WHERE `ticket_id`=t.`id`) AS `rec_data`,(SELECT JSON_ARRAYAGG(JSON_OBJECT('lastdate', tu.`last_date`,'join-date', e.`joined_date`,'epf', e.`epf`,'phone', e.`mobile`,'nic', e.`nic`,'fullname', CONCAT_WS(' ',e.`fname`,e.`lname`,e.`surname`),'designation',(SELECT `name` FROM hris_new.`designation` WHERE id = e.`designation`),'gender',e.`sex`,'dep',(SELECT `name` FROM hris_new.`department` WHERE id = e.`department`),'address',CONCAT(e.`p_address`, '-', e.`p_address_2`),'ent_by',(SELECT `username` FROM `user` WHERE `id` = tu.`ent_by`),'location',(SELECT `name_en` FROM hris_new.`cities` WHERE id = e.`p_city`),'ent_on',tu.`ent_on`))FROM `termination_users` tu JOIN hris_new.`employee` e ON tu.`employee_id`=e.`id` WHERE tu.`ticket_id`=t.`id`)AS ter_data,(SELECT JSON_ARRAYAGG(JSON_OBJECT('epf', e.`epf`,'location',(SELECT `name_en` FROM hris_new.`cities` WHERE id = e.`p_city`),'nic', e.`nic`,'designation',(SELECT `name` FROM hris_new.`designation` WHERE id = e.`designation`),'dep',(SELECT `name` FROM hris_new.`department` WHERE id = e.`department`),'ent_by',(SELECT `username` FROM `user` WHERE `id` = tp.`ent_by`),'ent_on',tp.`ent_on`,'fullname', CONCAT_WS(' ',e.`fname`,e.`lname`,e.`surname`)))FROM `transfer_promotion_users` tp JOIN hris_new.`employee` e ON tp.`emp_id`=e.`id` WHERE tp.`ticket_id`=t.`id`)AS tp_data FROM ticket t JOIN ticket_assign ta ON t.id = ta.ticket_id WHERE assign_user = '" + uid + "'" + type);
//            return ticketDT.getData(TicketDataTable.class, param, "SELECT t.id, t.code,(SELECT TYPE FROM ticket_type WHERE id = t.ticket_type) AS ticketType,(SELECT NAME FROM category_type WHERE id = t.category) AS category, t.priority, t.subject, t.description, t.time_of_incident, (SELECT username FROM USER WHERE id = t.ent_by) AS entBy, (SELECT username FROM USER WHERE id = t.behalf) AS behalf, t.ent_on AS entOn, t.status, (SELECT JSON_OBJECT('user', COALESCE((SELECT username FROM USER WHERE id = tl.user), ''),'date', DATE_FORMAT(COALESCE(DATE, NOW()), '%Y-%m-%d %h:%i:%s') ) FROM ticket_log tl WHERE ticket = t.id AND ACTION = 'seen' ORDER BY DATE DESC LIMIT 1) AS seenBy,(SELECT JSON_ARRAYAGG( JSON_OBJECT( 'user', (SELECT username FROM USER WHERE id = tl.user_id), 'ticket', tl.ticket_id,'type', tl.type )) FROM ticket_assign tl WHERE ticket_id = t.id) AS assignee_type,(SELECT JSON_ARRAYAGG(JSON_OBJECT('id',`id`,'fname',`fullname`,'epf',`epf`,'designation',(SELECT `name` FROM hris_new.`designation` WHERE id=r.`designation`),'nic',`nic`,'location',(SELECT `name` FROM `location` WHERE id=r.`location`),'branch',(SELECT `name` FROM hris_new.`department` WHERE id=r.`department`),'ent_by',(SELECT `username` FROM `user` WHERE `id` = t.`ent_by`),'ent_on',r.`ent_on` )) FROM `recruitment_users` r WHERE `ticket_id`=t.`id`) AS `rec_data`,(SELECT JSON_ARRAYAGG(JSON_OBJECT('lastdate', tu.`last_date`,'join-date', e.`joined_date`,'epf', e.`epf`,'phone', e.`mobile`,'nic', e.`nic`,'fullname', CONCAT_WS(' ',e.`fname`,e.`lname`,e.`surname`),'designation',(SELECT `name` FROM hris_new.`designation` WHERE id = e.`designation`),'gender',e.`sex`,'dep',(SELECT `name` FROM hris_new.`department` WHERE id = e.`department`),'address',CONCAT(e.`p_address`, '-', e.`p_address_2`),'ent_by',(SELECT `username` FROM `user` WHERE `id` = tu.`ent_by`),'location',(SELECT `name_en` FROM hris_new.`cities` WHERE id = e.`p_city`),'ent_on',tu.`ent_on`))FROM `termination_users` tu JOIN hris_new.`employee` e ON tu.`employee_id`=e.`id` WHERE tu.`ticket_id`=t.`id`)AS ter_data,(SELECT JSON_ARRAYAGG(JSON_OBJECT('epf', e.`epf`,'location',(SELECT `name_en` FROM hris_new.`cities` WHERE id = e.`p_city`),'nic', e.`nic`,'designation',(SELECT `name` FROM hris_new.`designation` WHERE id = e.`designation`),'dep',(SELECT `name` FROM hris_new.`department` WHERE id = e.`department`),'ent_by',(SELECT `username` FROM `user` WHERE `id` = tp.`ent_by`),'ent_on',tp.`ent_on`,'fullname', CONCAT_WS(' ',e.`fname`,e.`lname`,e.`surname`)))FROM `transfer_promotion_users` tp JOIN hris_new.`employee` e ON tp.`emp_id`=e.`id` WHERE tp.`ticket_id`=t.`id`)AS tp_data FROM ticket t WHERE assign_user = '" + uid + "'" + type);
            return ticketDT.getData(TicketDataTable.class, param, "SELECT `id`, `code`,(SELECT `type` FROM `ticket_type` WHERE `id` = t.`ticket_type`) AS `ticketType`, (SELECT `name` FROM `category_type` WHERE `id` = t.`category`) AS `category`, `priority`, `subject`, `description`, `time_of_incident`, (SELECT `username` FROM `user` WHERE `id` = t.`ent_by`) AS `entBy`, (SELECT `username` FROM `user` WHERE `id` = t.`behalf`) AS `behalf`, `ent_on` AS `entOn`,`status`,(SELECT JSON_OBJECT('user', COALESCE((SELECT `username` FROM `user` WHERE `id` = tl.`user`), ''), 'date', DATE_FORMAT(COALESCE(`date`, NOW()), '%Y-%m-%d %h:%i:%s')) FROM `ticket_log` tl WHERE `ticket` = t.`id` AND `action` = 'seen' ORDER BY `date` DESC LIMIT 1) AS `seenBy`,(SELECT JSON_ARRAYAGG(JSON_OBJECT ('user',(SELECT `username` FROM `user` WHERE `id`=tl.`user_id`) ,'ticket',`ticket_id`,'type',`type`)) FROM `ticket_assign` tl WHERE `ticket_id`=t.`id` )AS assignee_type FROM `ticket` t WHERE TRUE " + filter);

        } else {
            return ticketDT.getData(TicketDataTable.class, param, "SELECT `id`, `code`,(SELECT `type` FROM `ticket_type` WHERE `id` = t.`ticket_type`) AS `ticketType`, (SELECT `name` FROM `category_type` WHERE `id` = t.`category`) AS `category`, `priority`, `subject`, `description`, `time_of_incident`, (SELECT `username` FROM `user` WHERE `id` = t.`ent_by`) AS `entBy`, (SELECT `username` FROM `user` WHERE `id` = t.`behalf`) AS `behalf`, `ent_on` AS `entOn`,`status`,(SELECT JSON_OBJECT('user', COALESCE((SELECT `username` FROM `user` WHERE `id` = tl.`user`), ''), 'date', DATE_FORMAT(COALESCE(`date`, NOW()), '%Y-%m-%d %h:%i:%s')) FROM `ticket_log` tl WHERE `ticket` = t.`id` AND `action` = 'seen' ORDER BY `date` DESC LIMIT 1) AS `seenBy`,(SELECT JSON_ARRAYAGG(JSON_OBJECT ('user',(SELECT `username` FROM `user` WHERE `id`=tl.`user_id`) ,'ticket',`ticket_id`,'type',`type`)) FROM `ticket_assign` tl WHERE `ticket_id`=t.`id` )AS assignee_type, (SELECT JSON_ARRAYAGG(JSON_OBJECT('id',`id`,'fname',`fullname`,'epf',`epf`,'designation',(SELECT `name` FROM hris_new.`designation` WHERE id=r.`designation`),'nic',`nic`,'location',(SELECT `name` FROM `location` WHERE id=r.`location`),'branch',(SELECT `name` FROM hris_new.`department` WHERE id=r.`department`),'ent_by',(SELECT `username` FROM `user` WHERE `id` = t.`ent_by`),'ent_on',r.`ent_on` )) FROM `recruitment_users` r WHERE `ticket_id`=t.`id`) AS `rec_data`,(SELECT JSON_ARRAYAGG(JSON_OBJECT('lastdate', tu.`last_date`,'join-date', e.`joined_date`,'epf', e.`epf`,'phone', e.`mobile`,'nic', e.`nic`,'fullname', CONCAT_WS(' ',e.`fname`,e.`lname`,e.`surname`),'designation',(SELECT `name` FROM hris_new.`designation` WHERE id = e.`designation`),'gender',e.`sex`,'dep',(SELECT `name` FROM hris_new.`department` WHERE id = e.`department`),'address',CONCAT(e.`p_address`, '-', e.`p_address_2`),'location',(SELECT `name_en` FROM hris_new.`cities` WHERE id = e.`p_city`),'ent_by',(SELECT `username` FROM `user` WHERE `id` = tu.`ent_by`),'ent_on',tu.`ent_on`))FROM `termination_users` tu JOIN hris_new.`employee` e ON tu.`employee_id`=e.`id` WHERE tu.`ticket_id`=t.`id`)AS ter_data,(SELECT JSON_ARRAYAGG(JSON_OBJECT('epf', e.`epf`,'location',(SELECT `name_en` FROM hris_new.`cities` WHERE id = e.`p_city`),'nic', e.`nic`,'designation',(SELECT `name` FROM hris_new.`designation` WHERE id = e.`designation`),'dep',(SELECT `name` FROM hris_new.`department` WHERE id = e.`department`),'ent_by',(SELECT `username` FROM `user` WHERE `id` = tp.`ent_by`),'ent_on',tp.`ent_on`,'fullname', CONCAT_WS(' ',e.`fname`,e.`lname`,e.`surname`)))FROM `transfer_promotion_users` tp JOIN hris_new.`employee` e ON tp.`emp_id`=e.`id` WHERE tp.`ticket_id`=t.`id`)AS tp_data FROM `ticket` t WHERE TRUE" + filter + type);

        }

    }

    public DataTablesResponse<TicketCategoryDataTable> getTicketCategory(DataTableRequest param) throws Exception {
        return ticketCategoryDT.getData(TicketCategoryDataTable.class, param, "SELECT `id`,`name`,(SELECT `type` FROM `ticket_type` WHERE `id`=t.`ctype`) AS `type`,`status` FROM `category_type` t WHERE TRUE ");
    }

    public Ticket getTicket(int i) {
        return repo.findById(i).get();
    }

    public Iterable<TicketDTO> getTickets() {
        return repo.getAllTicketDTO();
    }

    public List<Ticket> saveApplication(String selected, Integer type, Integer status, Integer assign, Integer select_app, String priority, String subject, String description, Integer behalf) {
        List<Ticket> savedApplication = new ArrayList<>();

        String[] subTypes = selected.split("[^\\d]+");
        for (String subtype : subTypes) {
            if (!subtype.isEmpty()) {
                int sub = Integer.parseInt(subtype);

                Ticket ticket = new Ticket();
//                ticket.setTicketSubType(sub);
                ticket.setTicketCategoryType(sub);
                ticket.setTicketType(type);
                ticket.setApprover(assign);
                ticket.setCategory(select_app);
                ticket.setPriority(priority);
                ticket.setSubject(subject);
                ticket.setDescription(description);
                ticket.setBehalf(behalf);
                if (status != null) {
                    ticket.setStatus(status);
                } else {
                    ticket.setStatus(5);
                }
                ticket = repo.save(ticket);
                savedApplication.add(ticket);
                saveToTitketLog(ticket.getId(), "CREATED");
                if (status != null) {
                    saveToTitketLog(ticket.getId(), "Approval Assign");
                } else {
                    saveToTitketLog(ticket.getId(), "Queued");
                }
            }
        }
        return savedApplication;
    }

    public List<Ticket> saveHardware(String selected, Integer type, Integer status, Integer assign, Integer select_hard, String priority, String subject, String description, Integer behalf, Integer user) {

        List<Ticket> savedHadware = new ArrayList<>();

        String[] typeId = selected.split("[^\\d]+");
        for (String typeIds : typeId) {
            if (!typeIds.isEmpty()) {
                int subType = Integer.parseInt(typeIds);

                Ticket ticket = new Ticket();
                ticket.setTicketCategoryType(subType);
                ticket.setTicketType(type);
                ticket.setApprover(assign);
                ticket.setCategory(select_hard);
                ticket.setPriority(priority);
                ticket.setSubject(subject);
                ticket.setDescription(description);
                ticket.setBehalf(behalf);
                ticket.setEntBy(user);
                if (status != null) {
                    ticket.setStatus(status);
                } else {
                    ticket.setStatus(5);
                }
                ticket = repo.save(ticket);

                savedHadware.add(ticket);
                saveToTitketLog(ticket.getId(), "CREATED");
                if (status != null) {
                    saveToTitketLog(ticket.getId(), "Approval Assign");
                } else {
                    saveToTitketLog(ticket.getId(), "Queued");
                }

            }
        }
        return savedHadware;
    }

    public List<AccessRequests> saveRecruitment(String access, Integer type, String description, Integer behalf, String fullname, String calling, String epf, Date joindate, String address, Integer phone, String nic, String department, String designation, String gender, String location) {

        List<AccessRequests> savedAssign = new ArrayList<>();

        Ticket ticket = new Ticket();
        ticket.setTicketType(type);
        ticket.setDescription(description);
        ticket.setBehalf(behalf);
        ticket.setStatus(5);
        ticket.setPriority("Recruitment");
        ticket = repo.save(ticket);

        saveToTitketLog(ticket.getId(), "CREATED");

        RecruitmentUsers recruitmentUsers = new RecruitmentUsers();
        recruitmentUsers.setTicketId(ticket.getId());
        recruitmentUsers.setFullname(fullname);
        recruitmentUsers.setCallingName(calling);
        recruitmentUsers.setEpf(epf);
        recruitmentUsers.setJoinDate(joindate);
        recruitmentUsers.setAddress(address);
        recruitmentUsers.setPhone(phone);
        recruitmentUsers.setNic(nic);
        recruitmentUsers.setDepartment(department);
        recruitmentUsers.setDesignation(designation);
        recruitmentUsers.setGender(gender);
        recruitmentUsers.setLocation(location);
        recruitmentUsers.setDescription(description);
        recruitmentUsers = rec.save(recruitmentUsers);

        String[] accessID = access.split("[^\\d]+");
        for (String userId : accessID) {
            if (!userId.isEmpty()) {
                int number = Integer.parseInt(userId);

                AccessRequests accessRequests = new AccessRequests();
                accessRequests.setTicketId(ticket.getId());
                accessRequests.setHr(number);
//                accessRequests = arr.save(accessRequests);

                accessRequests = arr.save(accessRequests);
                savedAssign.add(accessRequests);

            }
        }

        return savedAssign;

//        return ticket;
    }

    public List<AccessRequests> updateRecruitment(Integer ticketId, String assetlist, String pc_username_input, String email_input, String system_username_input) {
        List<AccessRequests> updateReq = new ArrayList<>();

        Iterable<AccessRequests> itAccDeleted = arr.findAllByTicketId(ticketId);
        // arr.deleteAll(itAccDeleted);

        for (AccessRequests accessRequest : itAccDeleted) {
            accessRequest.setIt(null);
            arr.save(accessRequest);
        }

//        RecruitmentUsers recruitmentUsers = rec.findById(ticketId).get();
////        recruitmentUsers.setTicketId(ticketId);
//        recruitmentUsers.setPcUsername(pc_username_input);
//        recruitmentUsers.setUserEmail(email_input);
//        recruitmentUsers.setSystemUsername(system_username_input);
//        recruitmentUsers = rec.save(recruitmentUsers);
        String[] accessID = assetlist.split("[^\\d]+");
        for (String Id : accessID) {
            if (!Id.isEmpty()) {
                int number = Integer.parseInt(Id);

                AccessRequests accessRequests = new AccessRequests();
                accessRequests.setTicketId(ticketId);
                accessRequests.setIt(number);
                accessRequests = arr.save(accessRequests);
                updateReq.add(accessRequests);

            }
        }
        return updateReq;
    }

    public Ticket saveTermination(Integer type, Integer behalf, Integer employee, Date lastdate, String access) {

        Ticket ticket = new Ticket();
        ticket.setTicketType(type);
        ticket.setBehalf(behalf);
        ticket.setStatus(5);
        ticket.setPriority("Termination");
        ticket = repo.save(ticket);

        saveToTitketLog(ticket.getId(), "CREATED");

        TerminationUsers terminationUsers = new TerminationUsers();
        terminationUsers.setEmployeeId(employee);
        terminationUsers.setTicketId(ticket.getId());
        terminationUsers.setLastDate(lastdate);
        terminationUsers.setRemoveAllAccess(access);

        terminationUsers = ter.save(terminationUsers);

        return ticket;
    }

    public Ticket saveTransfer(Integer type, Integer behalf, String employee, String department, String branch, String designation) {

        Ticket ticket = new Ticket();
        ticket.setTicketType(type);
        ticket.setBehalf(behalf);
        ticket.setStatus(5);
        ticket.setPriority("Transfer/Promotion");
        ticket = repo.save(ticket);

        saveToTitketLog(ticket.getId(), "CREATED");

        TransferPromotionUsers transferPromotionUsers = new TransferPromotionUsers();
        transferPromotionUsers.setTicketId(ticket.getId().toString());
        transferPromotionUsers.setEmpId(employee);
        transferPromotionUsers.setDepartment(department);
        transferPromotionUsers.setBranch(branch);
        transferPromotionUsers.setDesignation(designation);

        transferPromotionUsers = tpur.save(transferPromotionUsers);

        return ticket;
    }

    public List<Assign> saveAssign(Integer type, String user, Integer ticketId) {

        List<Assign> savedAssign = new ArrayList<>();

        Iterable<Assign> ticketsTobeDeleted = repos.findAllByTicketId(ticketId);
        repos.deleteAll(ticketsTobeDeleted);
        //repos.deleteByTicketId(ticketId);

        String[] userIds = user.split("[^\\d]+");
        for (String userId : userIds) {
            if (!userId.isEmpty()) {
                int number = Integer.parseInt(userId);

                Assign assign = new Assign();
                assign.setTicketId(ticketId);
                assign.setType(type);
                assign.setUserId(number);

                assign = repos.save(assign);
                savedAssign.add(assign);

                if (type.equals(1)) {
                    saveToTitketLog(ticketId, "FEEDBACK PENDING");
                } else {
                    saveToTitketLog(ticketId, "APPROVAL PENDING");
                }

                saveToTitketLog(ticketId, "EDIT ASSIGNERS LIST");
            }
        }

        return savedAssign;
    }

    public List<Assign> saveAssignUser(String user, Integer ticketId) {

        List<Assign> savedAssign = new ArrayList<>();

        Iterable<Assign> ticketsTobeDeleted = repos.findAllByTicketId(ticketId);
        repos.deleteAll(ticketsTobeDeleted);

        String[] userIds = user.split("[^\\d]+");
        for (String userId : userIds) {
            if (!userId.isEmpty()) {
                int number = Integer.parseInt(userId);

                Assign assign = new Assign();
                assign.setTicketId(ticketId);
                assign.setUserId(number);

                assign = repos.save(assign);
                savedAssign.add(assign);

                saveToTitketLog(ticketId, "EDIT ASSIGNERS LIST");
            }
        }
        return savedAssign;
    }

    public Ticket saveIncident(Integer type, Integer assign, Integer status, Integer incident_type, String time_of_incident, String nature_of_incident, Integer behalf, Integer user) {
        Ticket incident = new Ticket();
        incident.setTicketType(type);
        incident.setApprover(assign);
        incident.setCategory(incident_type);
        incident.setTimeOfIncident(time_of_incident);
        incident.setDescription(nature_of_incident);
        incident.setBehalf(behalf);
        incident.setEntBy(user);
        if (status != null) {
            incident.setStatus(status);
        } else {
            incident.setStatus(5);
        }
        incident = repo.save(incident);
        return incident;
    }

    public Chat saveChat(String chat, Integer ticketId) {
        Chat chats = new Chat();
        chats.setTicketId(ticketId);
        chats.setChat(chat);
        chats = chatrepo.save(chats);
        return chats;
    }

    public Comments saveComments(Integer ticketId, String status) {
        Comments comments = new Comments();
        comments.setTicketId(ticketId);
        comments.setComment(status);
        comments = comrepo.save(comments);
        return comments;
    }

    public Comments saveCommentsText(Integer ticketId, String comment) {
        Comments comments = new Comments();
        comments.setTicketId(ticketId);
        comments.setComment(comment);
        comments = comrepo.save(comments);
        return comments;
    }

    public TicketDTO saveToTitketLog(Integer id, String action) {
        TicketLog ticketLog = new TicketLog();
        ticketLog.setTicket(id);
        ticketLog.setAction(action);
        TicketLog save = ticketLogRepo.save(ticketLog);
//         TicketJobType jtype = job_repo.findById(user.getUserType().getId()).get();
        return ticketLogRepo.getTicketInfo(id);
    }

    public TicketDTO getUserTicketData(Integer id) {
        return ticketLogRepo.getTicketInfo(id);
    }

    public TicketDTO loadEditLog(Integer id) {
        return ticketLogRepo.getEditLog(id);
    }

    public Ticket changeStatus(Integer ticketId, Integer type, Integer status) throws Exception {
        Ticket typs = repo.findById(ticketId).get();
        typs.setStatus(status);
        typs.setJobType(type);
        typs = repo.save(typs);
        return typs;
    }

    public Ticket changeCategory(Integer tctId, Integer type) throws Exception {
        Ticket tct = repo.findById(tctId).get();
        tct.setCategory(type);
        tct = repo.save(tct);
        return tct;
    }

    public Ticket closedTicket(Integer tctId) throws Exception {
        Ticket tct = repo.findById(tctId).get();
        tct.setStatus(4);
        tct = repo.save(tct);
        saveToTitketLog(tctId, "Closed");
        return tct;
    }

    public Ticket rateTicket(Integer ticketId, Integer rate) throws Exception {
        Ticket tct = repo.findById(ticketId).get();
        tct.setRate(rate);
        tct.setStatus(4);
        tct = repo.save(tct);
        saveToTitketLog(ticketId, "Closed");
        return tct;
    }

    public Ticket reOpenTicket(Integer ticketId, String comment) throws Exception {
        Ticket tct = repo.findById(ticketId).get();
        tct.setStatus(5);
        tct = repo.save(tct);

        Comments comments = new Comments();
        comments.setTicketId(ticketId);
        comments.setComment(comment);
        comments = comrepo.save(comments);

        saveToTitketLog(ticketId, "Re-Open by User");
        return tct;
    }

    public Ticket reactivateTicket(Integer id) throws Exception {
        Ticket ticket = repo.findById(id).get();
        ticket.setStatus(5);
        ticket = repo.save(ticket);
        saveToTitketLog(id, "Re-Open by user");
        return ticket;
    }

    public TicketTrackingDTO ticketTracking(Integer id) {
        return ticketLogRepo.ticketTracking(id);
    }

    public Iterable<TicketLog> loadTicketLog(Integer ticketId) {
        return ticketLogRepo.findByTicket(ticketId);
    }

    public Iterable<MainMenuDataDTO> showCount(String uid,String type) {
        
        System.out.println(type);
        if(type.equals("2")){
            return repo.getApplicationCount(uid);
        }else if (type.equals("3")){
            return repo.getHardwareCount(uid);
        }
//                    return repo.getHardwareCount(uid);

        return repo.getCount(uid);
    }

    public Iterable<SlimSelectDTO> getType(String utid) {
        return t_repo.getType(utid);
    }

    public Iterable<SlimSelectDTO> getJobType(String search) {
        return job_repo.getJobType("%" + search.trim() + "%");
    }

    public Iterable<SlimSelectDTO> searchsubType(String search) {
        return sub_job_repo.searchsubType("%" + search.trim() + "%");
    }

    public Iterable<SlimSelectDTO> searchAPP(String search) {
        return app_repo.searchAPP("%" + search.trim() + "%");
    }

    public Iterable<SlimSelectDTO> searchDep(String search) {
        return rec_repo.searchDep("%" + search.trim() + "%");
    }

    public Iterable<SlimSelectDTO> searchDes(String search) {
        return rec_repo.searchDes("%" + search.trim() + "%");
    }

    public Iterable<SlimSelectDTO> searchLoc(String search) {
        return rec_repo.searchLoc("%" + search.trim() + "%");
    }

    public Iterable<SlimSelectDTO> searchHard(String search) {
        return app_repo.searchHard("%" + search.trim() + "%");
    }

    public Iterable<SlimSelectDTO> searchIncident(String search) {
        return app_repo.searchIncident("%" + search.trim() + "%");
    }

    public TicketTypeCategory saveTicketType(TicketTypeCategory ticketTypeCategory) {
        return tc_repo.save(ticketTypeCategory);
    }

    public Iterable<UserCardDTO> getCardCount(String uid) {
        return repo.getCountByStatus(uid);
    }

}
