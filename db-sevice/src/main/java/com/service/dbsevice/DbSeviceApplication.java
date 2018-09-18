package com.service.dbsevice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@EnableEurekaClient
@EnableJpaRepositories(basePackages = {"com.service.dbservice.repositories"})
@SpringBootApplication
@EntityScan(basePackages = {"com.service.dbservice.tables"})
@ComponentScan("com.service.dbservice.resource")
//@EnableCaching
public class DbSeviceApplication {

	public static void main(String[] args) {
		SpringApplication.run(DbSeviceApplication.class, args);
	}
}
