package com.service.dbservice.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import com.service.dbservice.tables.PrivateUrls;

public interface PrivateGetAllUrl extends JpaRepository<PrivateUrls, String>{
		List<PrivateUrls> findIdByHash(@Param(value = "hash") String hash);
}
