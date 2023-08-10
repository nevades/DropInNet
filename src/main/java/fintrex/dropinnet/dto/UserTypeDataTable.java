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
public class UserTypeDataTable {

    public Integer id;
    public String name;
    public String dashboard;
    public String modBy;
    public String modOn;
    public String status;
}
