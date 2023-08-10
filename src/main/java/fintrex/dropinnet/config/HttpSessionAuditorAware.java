package fintrex.dropinnet.config;

import jakarta.servlet.http.HttpSession;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.AuditorAware;
import org.springframework.stereotype.Component;

@Component
public class HttpSessionAuditorAware implements AuditorAware<Integer> {

    private final HttpSession httpSession;

    @Autowired
    public HttpSessionAuditorAware(HttpSession httpSession) {
        this.httpSession = httpSession;
    }

    @Override
    public Optional<Integer> getCurrentAuditor() {
        Integer currentUser = (Integer) httpSession.getAttribute("uid");
        return Optional.ofNullable(currentUser);
    }
}
