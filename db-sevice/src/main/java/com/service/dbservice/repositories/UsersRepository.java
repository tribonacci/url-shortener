package com.service.dbservice.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.service.dbservice.tables.Users;

public interface UsersRepository extends JpaRepository<Users, Integer> {

}
