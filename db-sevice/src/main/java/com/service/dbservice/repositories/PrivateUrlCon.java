package com.service.dbservice.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.service.dbservice.tables.PrivateUrls;

public interface PrivateUrlCon extends JpaRepository<PrivateUrls, Integer> {

}
