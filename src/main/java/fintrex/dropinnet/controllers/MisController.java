/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fintrex.dropinnet.controllers;

import fintrex.dropinnet.dto.MisDTO;
import fintrex.dropinnet.dto.MisTicketDTO;
import fintrex.dropinnet.service.MisService;
import fintrex.dropinnet.service.TicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/mis")
public class MisController {

    @Autowired
    private MisService mis;

    @GetMapping("/report")
    public Iterable<MisDTO> getMis() throws Exception {
        return mis.getMis();
    }

    @GetMapping("/branch-report")
    public Iterable<MisDTO> getBranch() throws Exception {
        return mis.getBranch();
    }

//    @PostMapping("/view-data")
//    public Iterable<MisTicketDTO> loadData() throws Exception {
//        return mis.loadData1();
//    }

    @PostMapping("/view-data")
    public Iterable<MisTicketDTO> loadData1(@RequestParam String department, @RequestParam String category, @RequestParam String frquency, @RequestParam String status) throws Exception {
        return mis.loadData(department, category, frquency, status);
    }
    @PostMapping("/view-category-data")
    public Iterable<MisTicketDTO> loadcategoryData(@RequestParam String type, @RequestParam String category, @RequestParam String frquency, @RequestParam String status) throws Exception {
        return mis.loadcategoryData(type, category, frquency, status);
    }

}
