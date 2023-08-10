package fintrex.dropinnet.service;

import fintrex.dropinnet.dto.TicketCategoryDataTable;
import fintrex.dropinnet.model.User;
import fintrex.dropinnet.repo.PageRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PageService {

    @Autowired
    PageRepo repo;

    public String getPagesForUser(String userId) {
        return repo.getAllPages(userId);
    }

}
