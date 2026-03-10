package com.campusjob.application;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;

/**
 * 申请服务启动类
 * @author campus-job
 */
@EnableDiscoveryClient
@EnableFeignClients
@SpringBootApplication
public class ApplicationServiceApplication {
    
    public static void main(String[] args) {
        SpringApplication.run(ApplicationServiceApplication.class, args);
        System.out.println("""

                ==========================================
                   申请服务启动成功！
                   服务地址: http://localhost:8004
                ==========================================
                """);
    }
}
