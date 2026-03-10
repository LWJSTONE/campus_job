package com.campusjob.message;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;

/**
 * 消息服务启动类
 * @author campus-job
 */
@EnableDiscoveryClient
@EnableFeignClients
@SpringBootApplication
public class MessageServiceApplication {
    
    public static void main(String[] args) {
        SpringApplication.run(MessageServiceApplication.class, args);
        System.out.println("""

                ==========================================
                   消息服务启动成功！
                   服务地址: http://localhost:8005
                ==========================================
                """);
    }
}
