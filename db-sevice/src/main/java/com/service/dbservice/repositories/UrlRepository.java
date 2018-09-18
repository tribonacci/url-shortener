package com.service.dbservice.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import com.service.dbservice.tables.AllUrls;

public interface UrlRepository extends JpaRepository<AllUrls, String> {
	
	AllUrls findUrlByHash(@Param(value = "hash") String hash);
}