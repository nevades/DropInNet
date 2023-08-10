package fintrex.dropinnet.controllers;

import fintrex.dropinnet.model.User;
import fintrex.dropinnet.service.LoginService;
import jakarta.servlet.http.HttpSession;
import java.util.Hashtable;
import javax.naming.Context;
import javax.naming.NamingException;
import javax.naming.ldap.InitialLdapContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class LoginController {

    @Autowired
    LoginService servr;

    @PostMapping("/login")
    public String checkLogin(@RequestParam String username, @RequestParam String password, HttpSession session) {

        User user = servr.checkLogin(username);

        if (user == null) {
            return "error";
        } else {

            InitialLdapContext context = ldapCheck(username, password);

            if (context != null) {

                session.setAttribute("uid", user.getId());
                session.setAttribute("username", username);
                session.setAttribute("type", user.getUserType().getId());
                String dashboard = servr.getDashboard(user.getUserType().getId());
                session.setAttribute("dashboard", dashboard);

                return "ok";
            } else {
                return "error";
            }
        }

    }

    private InitialLdapContext ldapCheck(String username, String password) {
        Hashtable props = new Hashtable();
        props.put(Context.SECURITY_PRINCIPAL, username + "@regalfinance.com");
        props.put(Context.SECURITY_CREDENTIALS, password);
        props.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
        props.put(Context.PROVIDER_URL, "ldap://ad1.fintrex.lk:389");

        try {
            InitialLdapContext c = new InitialLdapContext(props, null);
            return c;
        } catch (javax.naming.CommunicationException e) {
            e.printStackTrace();
            return null;
        } catch (NamingException e) {
            e.printStackTrace();
            return null;
        }

    }

}
