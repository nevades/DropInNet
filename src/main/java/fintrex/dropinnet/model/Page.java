package fintrex.dropinnet.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Table("pages")
public class Page {

    @Id
    private Integer id;
    private Integer parent;
    private String name;
    private String url;
    private Integer level;

}
