/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fintrex.dropinnet.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
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
@Table("recruitment_users")
public class RecruitmentUsers {

    @Id
    private Integer id;
    private Integer ticketId;
    private String fullname;
    private String callingName;
    private String epf;
    private Date joinDate;
    private String address;
    private Integer phone;
    private String nic;
    private String department;
    private String designation;
    private String gender;
    private String location;
    private String description;
    private String pcUsername;
    private String userEmail;
    private String systemUsername;
    @CreatedBy
    private Integer entBy;
    @CreatedDate
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd hh:mm:ss")
    private java.util.Date entOn;

}
