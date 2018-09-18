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
	public String hash;
	
	public dbUrlSaveModel(RequestModel rm,String hash) {
		this.rm = rm;
		this.hash = hash;
	}

}
