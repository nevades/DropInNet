/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fintrex.dropinnet.controllers;

import fintrex.dropinnet.service.LogoutService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author Akash
 */
@Controller
public class LogoutController {
    
     @Autowired
    LogoutService logout;
    
     @RequestMapping("/logout")
    @ResponseBody
    public void logout(HttpSession session,HttpServletResponse resp) {
         logout.logout(session,resp);

    }
}
