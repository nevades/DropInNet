/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fintrex.dropinnet.service;

import fintrex.dropinnet.dto.MisDTO;
import fintrex.dropinnet.dto.MisTicketDTO;
import fintrex.dropinnet.repo.MisRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MisService {

    @Autowired
    private MisRepo misrepo;

    public Iterable<MisDTO> getMis() throws Exception {
        return misrepo.getDatae();
    }

    public Iterable<MisDTO> getBranch() throws Exception {
        return misrepo.getBranchData();
    }
//    public Iterable<MisTicketDTO> loadData1() throws Exception {
//        return misrepo.getselectedData();
//    }

    public Iterable<MisTicketDTO> loadData(String department, String category, String frquency, String status) {
        return misrepo.getselectedData(department,category,frquency,status);
    }

    public Iterable<MisTicketDTO> loadcategoryData(String type, String category, String frquency, String status) {
        return misrepo.getcategoryData(type,category,frquency,status);
    }

}
