/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fintrex.dropinnet.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 *
 * @author Akash
 */
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class AuditReportDataTable {

    public Integer id;
    public String subject;
    public String priority;
    public String entBy;
    public String status;
    public String code;
    public String assignedTo;
 
}
