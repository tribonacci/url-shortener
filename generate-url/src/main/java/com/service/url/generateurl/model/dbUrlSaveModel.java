package com.service.url.generateurl.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
public class dbUrlSaveModel {
	
	@Getter
	@Setter
	public RequestModel rm;
	
	@Getter
	@Setter
	public String shortUrl;
	
	public dbUrlSaveModel(RequestModel rm,String shortUrl) {
		this.rm = rm;
		this.shortUrl = shortUrl;
	}

}
