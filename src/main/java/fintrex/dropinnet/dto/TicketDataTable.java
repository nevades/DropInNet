package fintrex.dropinnet.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class TicketDataTable {

    public Integer id;
    public String code;
    public String ticketType;
    public String category;
    public String priority;
    public String subject;
    public String description;
    public String timeOfIncident;
    public String entBy;
    public String behalf;
    public String entOn;
    public String modBy;
    public String modOn;
    public String status;
    public String seenBy;
    public String assigneeType;
    public String recData;
    public String terData;
    public String tpData;
   
}
