/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fintrex.dropinnet.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.annotation.Id;

/**
 *
 * @author Akash
 */
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class TicketCategoryDataTable {
    
    private Integer id;
    private String name;
    private String type;
    private String status;
    
}
