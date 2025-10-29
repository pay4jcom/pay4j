package com.pay4j;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.metrics.buffering.BufferingApplicationStartup;

/**
 * 启动程序
 *
 * @author Pay4j
 */

@SpringBootApplication
public class Pay4jAdminApplication {

    public static void main(String[] args) {
        SpringApplication application = new SpringApplication(Pay4jAdminApplication.class);
        application.setApplicationStartup(new BufferingApplicationStartup(2048));
        application.run(args);
        System.out.println("(♥◠‿◠)ﾉﾞ  Pay4jAdmin启动成功   ლ(´ڡ`ლ)ﾞ");
    }

}
