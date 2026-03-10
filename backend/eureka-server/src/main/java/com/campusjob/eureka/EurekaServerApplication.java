package com.campusjob.eureka;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

/**
 * Eureka服务注册中心启动类
 * @author campus-job
 */
@EnableEurekaServer
@SpringBootApplication
public class EurekaServerApplication {
    
    public static void main(String[] args) {
        SpringApplication.run(EurekaServerApplication.class, args);
        System.out.println("""

                ==========================================
                   Eureka服务注册中心启动成功！
                   访问地址: http://localhost:8761
                ==========================================
                """);
    }
}
