package fintrex.dropinnet.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class IncidentDataTable {

    private Integer id;
    private String code;
    private Integer status;
    private String timeOfIncident;
    private String description;

}
