package com.service.url.retrieveurl.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
public class RequestForFetch {
	@Getter
	@Setter
	public String shortUrl;
	
	@Getter
	@Setter
	public String userId;

}
