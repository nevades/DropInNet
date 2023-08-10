/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fintrex.dropinnet.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class MisDTO {

    private String tType;
    private String branch;
    private String cat;
    private Integer monthlyReported;
    private Integer monthlyInProgress;
    private Integer monthlyClosed;
    private Integer yearlyReported;
    private Integer yearlyInProgress;
    private Integer yearlyClosed;
    private Integer allReported;
    private Integer allInProgress;
    private Integer allClosed;

}
