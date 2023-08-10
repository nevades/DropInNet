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
public class GetPagesDTO {

    private Integer id;
    private Integer dashboard;
    private String name;
    private String dashboard_name;
    private String allPage;
}
