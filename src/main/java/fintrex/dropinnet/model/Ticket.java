package fintrex.dropinnet.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.relational.core.mapping.Table;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Table("ticket")

public class Ticket {

    @Id
    private Integer id;
    private Integer ticketType;
//    private Integer ticketSubType;
    private Integer ticketCategoryType;
    private Integer category;
    private String priority;
    private String subject;
    private String description;
    private Integer behalf;
    private Integer status;
    private Integer approver;
    private Integer rate;
    private String comment;
    private String timeOfIncident;
//    private Integer seenBy;
    private Integer jobType;
    @CreatedBy
    private Integer entBy;
    @CreatedDate
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd hh:mm:ss")
    private Date entOn;
    @LastModifiedBy
    private Integer modBy;
    @LastModifiedDate
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd hh:mm:ss")
    private Date modOn;

}
