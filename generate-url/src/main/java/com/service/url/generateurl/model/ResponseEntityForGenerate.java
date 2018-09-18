package com.service.url.generateurl.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
public class ResponseEntityForGenerate {

	@Getter
	@Setter
	public String shortUrl;
	
	@Getter
	@Setter
	public String status;
}
