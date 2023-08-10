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
 * @author asus
 */
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class TicketTrackingDTO {

    private Integer id;
    private String action;
    private String date;
    private String user;
}
