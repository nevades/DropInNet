/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fintrex.dropinnet.service;

import fintrex.dropinnet.datatable.DataTableRepo;
import fintrex.dropinnet.datatable.DataTableRequest;
import fintrex.dropinnet.datatable.DataTablesResponse;
import fintrex.dropinnet.dto.AuditReportDataTable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author Akash
 */
@Service
public class ReportService {
    @Autowired
    private DataTableRepo<AuditReportDataTable> reportDt;
    
    public DataTablesResponse<AuditReportDataTable> getAuditReport(DataTableRequest param) throws Exception {
        return reportDt.getData(AuditReportDataTable.class, param, "SELECT `id`,`code`,`subject`,`priority`, (SELECT `username` FROM `user` WHERE `id` = t.`ent_by`) AS `EntBy`, (SELECT `username` FROM `user` WHERE `id` = t.`assign_user`) AS `AssignedTo`, (SELECT `name` FROM `ticket_status` WHERE `id` = t.`status`) AS `status` FROM `ticket` t WHERE `ticket_category_type` = 7");
    }
}
