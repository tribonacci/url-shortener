package com.service.url.generateurl.model;

import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
public class RequestModel {
	
	@Getter
	@Setter
	public String fullUrl;
	
	@Getter
	@Setter
	public String hash;
	
	
	@Getter
	@Setter
	public String userId;
	
	@Getter
	@Setter
	public Boolean privacy;
	
	@Getter
	@Setter
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss.SSS")
	public Timestamp lifeSpan;
	
}
