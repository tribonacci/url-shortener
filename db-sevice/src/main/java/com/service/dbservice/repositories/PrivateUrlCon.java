package com.service.dbservice.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import com.service.dbservice.tables.AllUrls;
import com.service.dbservice.tables.PrivateUrls;

public interface PrivateUrlCon extends JpaRepository<PrivateUrls, Integer> {
	PrivateUrls findIdByHash(@Param(value = "hash") String hash);
}
