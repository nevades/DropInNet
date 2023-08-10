package fintrex.dropinnet.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class UserDataTable {
    
    public Integer id;
    public String username;
    public String name;
    public String userType;
    public String modBy;
    public String modOn;
    public String status;
    
}
