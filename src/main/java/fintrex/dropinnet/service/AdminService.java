package fintrex.dropinnet.service;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.ObjectMapper;
import fintrex.dropinnet.datatable.DataTableRepo;
import fintrex.dropinnet.datatable.DataTableRequest;
import fintrex.dropinnet.datatable.DataTablesResponse;
import fintrex.dropinnet.dto.GetPagesDTO;
import fintrex.dropinnet.dto.SlimSelectDTO;
import fintrex.dropinnet.dto.UserDataTable;
import fintrex.dropinnet.dto.UserTypeDataTable;
import fintrex.dropinnet.model.Page;
import fintrex.dropinnet.model.Ticket;
import fintrex.dropinnet.model.TicketType;
import fintrex.dropinnet.model.TicketTypeCategory;
import fintrex.dropinnet.model.User;
import fintrex.dropinnet.model.UserType;
import fintrex.dropinnet.repo.AdminTypeRepo;
import fintrex.dropinnet.repo.PageRepo;
import fintrex.dropinnet.repo.TicketRepo;
import fintrex.dropinnet.repo.TicketTypeRepo;
import fintrex.dropinnet.repo.TypeCategoryRepo;
import fintrex.dropinnet.repo.UserRepo;
import fintrex.dropinnet.repo.UserTypeRepo;
import jakarta.json.Json;
import jakarta.json.JsonArray;
import jakarta.json.JsonObject;
import jakarta.json.JsonValue;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jdbc.core.mapping.AggregateReference;
import org.springframework.stereotype.Service;

@Service
public class AdminService {

    @Autowired
    UserRepo userRepo;

    @Autowired
    TicketRepo ticketRepo;

    @Autowired
    PageRepo pageRepo;

    @Autowired
    UserTypeRepo userTypeRepo;

    @Autowired
    AdminTypeRepo adminTypeRepo;

    @Autowired
    TicketTypeRepo ticketTypeRepo;

    @Autowired
    TypeCategoryRepo typeCategory;

    @Autowired
    private DataTableRepo<UserDataTable> userDt;
    @Autowired
    private DataTableRepo<UserTypeDataTable> userTypeDt;

    public DataTablesResponse<UserDataTable> getUsers(DataTableRequest param) throws Exception {
        return userDt.getData(UserDataTable.class, param, "select `id`,`username`,`name`,(select `name` from `user_type` where `id`=u.`user_type`) as `userType`,(select `username` from `user` where `id`=u.`mod_by`) as `ModBy`,`mod_on`,`status` FROM `user` u WHERE true ");
    }

    public DataTablesResponse<UserTypeDataTable> getUserType(DataTableRequest param) throws Exception {
        return userTypeDt.getData(UserTypeDataTable.class, param, "SELECT `id`,`name`,(SELECT `name` FROM `dashboard` WHERE `id`=u.`dashboard`) AS `dashboard`,(SELECT `username` FROM `user` WHERE `id`=u.`mod_by`) AS `mod_by`,`mod_on`,`status` FROM `user_type` u WHERE TRUE ");
    }

    public User getUser(Integer id) throws Exception {
        User user = userRepo.findById(id).get();
        UserType utype = userTypeRepo.findById(user.getUserType().getId()).get();
        user.setUserTypeName(utype.getName());
        return user;
    }

    public TicketTypeCategory getTicketType(Integer id) throws Exception {
        TicketTypeCategory category = typeCategory.findById(id).get();
        TicketType cttype = ticketTypeRepo.findById(category.getCtype().getId()).get();
        category.setCategoryTypeName(cttype.getType());
        return category;
    }

    public UserType saveUserType(String name, String dashboard, String pages) throws Exception {

        List<Integer> pageNumbers = Arrays.asList(new ObjectMapper().readValue(pages, Integer[].class));

        String pagesJson = new ObjectMapper().writeValueAsString(pageNumbers);

        UserType page = new UserType();
        page.setDashboard(dashboard);
        page.setName(name);
        page.setPages(pagesJson);
        page.setStatus("active");

        page = userTypeRepo.save(page);

        return page;

    }

    public UserType updateUserType(Integer id, String name, String dashboard, String pages) throws Exception {

        List<Integer> pageNumbers = Arrays.asList(new ObjectMapper().readValue(pages, Integer[].class));

        String pagesJson = new ObjectMapper().writeValueAsString(pageNumbers);

        UserType page = userTypeRepo.findById(id).get();
        page.setDashboard(dashboard);
        page.setName(name);
        page.setPages(pagesJson);
        page.setStatus("active");

        page = userTypeRepo.save(page);

        return page;

    }

    public User saveUser(String name, String username, Integer userType) throws Exception {
        User user = new User();
        user.setUsername(username);
        user.setName(name);
        user.setUserType(AggregateReference.to(userType));
        user.setStatus("active");
        user = userRepo.save(user);
        return user;
    }

    public User updateUser(Integer id, String name, String username, Integer userType) throws Exception {
        User user = userRepo.findById(id).get();
        user.setUsername(username);
        user.setName(name);
        user.setUserType(AggregateReference.to(userType));
        user = userRepo.save(user);
        return user;
    }

    public UserType deactivateUserType(Integer id) throws Exception {
        UserType utype = userTypeRepo.findById(id).get();
        utype.setStatus("deactivated");
        utype = userTypeRepo.save(utype);
        return utype;
    }

    public UserType reactivateUserType(Integer id) throws Exception {
        UserType utype = userTypeRepo.findById(id).get();
        utype.setStatus("active");
        utype = userTypeRepo.save(utype);
        return utype;
    }

    public User deactivateUser(Integer id) throws Exception {
        User user = userRepo.findById(id).get();
        user.setStatus("deactivated");
        user = userRepo.save(user);
        return user;
    }

    public User reactivateUser(Integer id) throws Exception {
        User user = userRepo.findById(id).get();
        user.setStatus("active");
        user = userRepo.save(user);
        return user;
    }

    public Iterable<SlimSelectDTO> getUserTypeIdAndName(String search) {
        return userTypeRepo.getIdAndName("%" + search.trim() + "%");
    }

    public Iterable<SlimSelectDTO> getAdminTypeIdAndName(String search) {
        return adminTypeRepo.getAdminTypeIdAndName("%" + search.trim() + "%");
    }

    public TicketTypeCategory saveTicketType(String name, Integer categoryname) throws Exception {
        TicketTypeCategory category = new TicketTypeCategory();
        category.setName(name);
        category.setCtype(AggregateReference.to(categoryname));
        category.setStatus("active");
        category = typeCategory.save(category);
        return category;
    }

    public TicketTypeCategory updateTicketType(Integer id, String name, Integer categoryname) throws Exception {
        TicketTypeCategory category = typeCategory.findById(id).get();
        category.setName(name);
        category.setCtype(AggregateReference.to(categoryname));
        category = typeCategory.save(category);
        return category;
    }

    public TicketTypeCategory deactivateTicketCategory(Integer id) throws Exception {
        TicketTypeCategory category = typeCategory.findById(id).get();
        category.setStatus("deactive");
        category = typeCategory.save(category);
        return category;
    }

    public TicketTypeCategory reactivateTicketCategory(Integer id) throws Exception {
        TicketTypeCategory category = typeCategory.findById(id).get();
        category.setStatus("active");
        category = typeCategory.save(category);
        return category;
    }

    public Iterable<SlimSelectDTO> getCategoryTypeIdAndName(String search) {
        return ticketTypeRepo.getAllType("%" + search.trim() + "%");
    }

    public Iterable<SlimSelectDTO> getDashboard(String search) {
        return userTypeRepo.getDashboard("%" + search.trim() + "%");
    }

    public GetPagesDTO getPage() {
//    public Iterable<Page> getPage() {
        return pageRepo.getPage();
    }

    public GetPagesDTO getSelectedPage(Integer id) {
//    public Iterable<Page> getPage() {
        return pageRepo.getSelectedPage(id);
    }
}
