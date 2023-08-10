package fintrex.dropinnet.datatable;

import java.util.List;
import java.util.StringJoiner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

@Component
public class DataTableRepo<T> {

    @Autowired
    JdbcTemplate jdbc;

    public DataTablesResponse<T> getData(Class cls, DataTableRequest param, String qry, Object... args) throws Exception {

        Pattern allcols = Pattern.compile("(?<=select)(.*)(?=from)+(?![^(]*\\))", Pattern.CASE_INSENSITIVE);
        Matcher allcolsMatcher = allcols.matcher(qry);

        Pattern removeAs = Pattern.compile("AS\\s*[`'](\\w+)[`']", Pattern.CASE_INSENSITIVE);

        String cols = "";
        if (allcolsMatcher.find()) {
            cols = allcolsMatcher.group(0);
        } else {
            throw new Exception("No Columns to Select");
        }
        String tableAndConditions = qry.split(Pattern.quote(cols))[1];

        DataTablesResponse<T> resp = new DataTablesResponse<>();
        resp.setDraw(param.getDraw());

        String countQry = "SELECT COUNT(1) FROM (SELECT 1 " + tableAndConditions + " )tbl";
        int totalCount = jdbc.queryForObject(countQry, Integer.class, args);
        resp.setRecordsTotal(totalCount);

        int to = param.getLength();
        if (to == -1) {
            to = totalCount;
        }

        List<DataTableRequest.Order> orders = param.getOrder();
        StringJoiner orderJoiner = new StringJoiner(",");
        for (int i = 0; i < orders.size(); i++) {
            DataTableRequest.Order order = orders.get(i);
            orderJoiner.add((order.getColumn() + 1) + " " + order.getDir());
        }
        String OrderBy = "";
        String orderJoinerString = orderJoiner.toString();
        if (orderJoinerString.length() > 0) {
            OrderBy = " ORDER BY " + orderJoinerString;
        }

        String search = "";
        DataTableRequest.Search searchval = param.getSearch();
        if (searchval != null && searchval.getValue().length() > 0) {
            search = " AND CONCAT_WS(''," + removeAs.matcher(cols).replaceAll("") + ") REGEXP '" + searchval.getValue() + "'";
        }

        String mainQry = "SELECT " + cols + tableAndConditions + search + OrderBy + " LIMIT " + param.getStart() + "," + to;
        List<T> data = jdbc.query(mainQry, new BeanPropertyRowMapper<T>(cls), args);

        resp.setData(data);

        if (param.getSearch().getValue().length() > 0) {

            int filtered = jdbc.queryForObject("SELECT count(1) FROM (SELECT 1 " + tableAndConditions + search + ")tb", Integer.class, args);

            resp.setRecordsFiltered(filtered);
        } else {
            resp.setRecordsFiltered(totalCount);
        }

        return resp;
    }

}
