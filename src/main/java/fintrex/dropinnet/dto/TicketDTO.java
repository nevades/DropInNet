package fintrex.dropinnet.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class TicketDTO {

    private Integer id;
    private String code;
    private String priority;
    private String subject;
    private String description;
    private Integer rate;
    private String comments;
    private String timeOfIncident;
    private String reporter;
    private Integer status;
    private String ticketType;
    private String category;
    private String ticketLog;
    private String lastSeen;
    private String assigneeDetail;
    private Integer jobTypeId;
    private String jobType;
    private String recData;
    private String assignee;
    private String accessReq;
    private String chat;
    private String checked;
    private String terData;
    private String tpData;
    private String entOn;
    private String closed;
    private String assigneeDate;
}
