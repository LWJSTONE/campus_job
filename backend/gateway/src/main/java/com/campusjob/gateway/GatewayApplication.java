package com.campusjob.gateway;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

/**
 * Gateway网关服务启动类
 * @author campus-job
 */
@EnableDiscoveryClient
@SpringBootApplication
public class GatewayApplication {
    
    public static void main(String[] args) {
        SpringApplication.run(GatewayApplication.class, args);
        System.out.println("""

                ==========================================
                   Gateway网关服务启动成功！
                   网关地址: http://localhost:10000
                ==========================================
                """);
    }
}
