/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fintrex.dropinnet.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

/**
 *
 * @author Akash
 */
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Table("ticket_sub_type")
public class SubJobType {
    
    @Id
    private Integer id;
    private String name;
    private Integer mainType;
}
