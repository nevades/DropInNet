package fintrex.dropinnet.config;

import jakarta.servlet.MultipartConfigElement;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRegistration;
import org.springframework.boot.web.servlet.MultipartConfigFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.util.unit.DataSize;
import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;

public class MainWebAppInitializer implements WebApplicationInitializer {

    @Override
    public void onStartup(ServletContext sc) throws ServletException {

        AnnotationConfigWebApplicationContext ctx
                = new AnnotationConfigWebApplicationContext();
        ctx.register(MvcWebConfig.class);
        ctx.setServletContext(sc);

        ServletRegistration.Dynamic servlet
                = sc.addServlet("springDispatcherServlet",
                        new DispatcherServlet(ctx));
        servlet.setLoadOnStartup(1);
        servlet.addMapping("/");
        //using MultipartConfigElement(location,maxFileSize,maxRequestSize,fileSizeThreshold)
        MultipartConfigElement multipartConfig = new MultipartConfigElement(
                null, 50000000, 50000000, 0);
        //new MultipartConfigElement("c:/temp") will create unlimited sizes and 0 threshold
        servlet.setMultipartConfig(multipartConfig);
    }

    @Bean
    public MultipartConfigElement multipartConfigElement() {
        MultipartConfigFactory factory = new MultipartConfigFactory();
        factory.setMaxFileSize(DataSize.ofMegabytes(10)); // set maximum file size to 10 MB
        factory.setMaxRequestSize(DataSize.ofMegabytes(10)); // set maximum request size to 10 MB
        return factory.createMultipartConfig();
    }

}
