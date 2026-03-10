package com.campusjob.user;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;

/**
 * 用户服务启动类
 * @author campus-job
 */
@EnableDiscoveryClient
@EnableFeignClients
@SpringBootApplication
public class UserServiceApplication {
    
    public static void main(String[] args) {
        SpringApplication.run(UserServiceApplication.class, args);
        System.out.println("""

                ==========================================
                   用户服务启动成功！
                   服务地址: http://localhost:8002
                ==========================================
                """);
    }
}
