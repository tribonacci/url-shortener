package com.service.dbservice.models;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@AllArgsConstructor
public class PrivateUrlSaveModel {
	
	@Getter
	@Setter
	public String shortUrl;
	
	@Getter
	@Setter
	public List<String> userId;
}
