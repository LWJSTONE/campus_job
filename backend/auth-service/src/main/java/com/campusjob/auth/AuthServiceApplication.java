package com.campusjob.auth;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

/**
 * 认证服务启动类
 * @author campus-job
 */
@EnableDiscoveryClient
@SpringBootApplication
public class AuthServiceApplication {
    
    public static void main(String[] args) {
        SpringApplication.run(AuthServiceApplication.class, args);
        System.out.println("""

                ==========================================
                   认证服务启动成功！
                   服务地址: http://localhost:8001
                ==========================================
                """);
    }
}
