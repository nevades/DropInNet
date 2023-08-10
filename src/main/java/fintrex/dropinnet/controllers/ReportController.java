/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fintrex.dropinnet.controllers;

import fintrex.dropinnet.datatable.DataTableRequest;
import fintrex.dropinnet.datatable.DataTablesResponse;
import fintrex.dropinnet.dto.AuditReportDataTable;
import fintrex.dropinnet.service.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author Akash
 */
@RestController
@RequestMapping("/reports")
public class ReportController {

    @Autowired
    ReportService rep;

    @PostMapping("/audit")
    public DataTablesResponse<AuditReportDataTable> getAuditReport(@RequestBody DataTableRequest param) throws Exception {
        return rep.getAuditReport(param);
    }
}
