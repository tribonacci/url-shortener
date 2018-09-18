package com.service.url.generateurl;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;

@EnableEurekaClient
@SpringBootApplication
public class GenerateUrlApplication {

	public static void main(String[] args) {
		SpringApplication.run(GenerateUrlApplication.class, args);
	}
}
