package com.service.dbservice.tables;

import java.sql.Time;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "user", catalog = "url")
@NoArgsConstructor
@AllArgsConstructor
public class Users {
	
	@Id
	@Getter
	@Setter
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id")
	public Integer id;
	
	
	@Getter
	@Setter
	@Column(name = "user_id")
	public Integer UserId;
	
	@Getter
	@Setter
	@Column(name = "password")
	public String pass;
	
	@Getter
	@Setter
	@Column(name = "login_time")
	public Time lastLogin;
	
	@Getter
	@Setter
	@Column(name = "created_time")
	public Time creationDate;

}
