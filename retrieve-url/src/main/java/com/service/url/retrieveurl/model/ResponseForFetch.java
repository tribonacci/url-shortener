package com.service.url.retrieveurl.model;

import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
public class ResponseForFetch {

	@Getter
	@Setter
	public String fullUrl;
	
	@Getter
	@Setter
	public String userId;
	
	@Getter
	@Setter
	public Boolean privacy;
	
	
	
}
