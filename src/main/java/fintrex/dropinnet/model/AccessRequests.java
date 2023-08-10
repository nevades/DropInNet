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
 * @author Nevanjith
 */
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Table("access_requests")
public class AccessRequests {

    @Id
    private Integer id;
    private Integer ticketId;
    private Integer hr;
    private Integer it;

}
