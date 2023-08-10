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
public class MisTicketDTO {

    private Integer id;
    private String code;
    private String subject;
    private String priority;
    private String entBy;
    private String status;
    private String assignUser;
}
