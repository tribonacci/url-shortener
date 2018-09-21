package com.service.url.retrieveurl;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;

@EnableEurekaClient
@SpringBootApplication
public class RetrieveUrlApplication {

	public static void main(String[] args) {
		SpringApplication.run(RetrieveUrlApplication.class, args);
	}
}
