package com.service.url.retrieveurl.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
public class ResponseForFetch {

	@Getter
	@Setter
	public String longUrl;
	
	@Getter
	@Setter
	public String status;
	
	@Getter
	@Setter
	public Boolean privacy;
}
