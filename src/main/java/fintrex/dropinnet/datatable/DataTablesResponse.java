package fintrex.dropinnet.datatable;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString
public class DataTablesResponse<T> {

    private int draw;
    private long recordsTotal;
    private long recordsFiltered;
    private List<T> data;

}
