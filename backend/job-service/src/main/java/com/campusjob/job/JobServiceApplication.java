package com.campusjob.job;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;

/**
 * 兼职服务启动类
 * @author campus-job
 */
@EnableDiscoveryClient
@EnableFeignClients
@SpringBootApplication
public class JobServiceApplication {
    
    public static void main(String[] args) {
        SpringApplication.run(JobServiceApplication.class, args);
        System.out.println("""

                ==========================================
                   兼职服务启动成功！
                   服务地址: http://localhost:8003
                ==========================================
                """);
    }
}
