package com.service.url.retrieveurl.resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
@RequestMapping("/fetch")
public class UrlFetcher {
	
	@Autowired
	RestTemplate restTemplate;
	
	@GetMapping("/{shortUrl}")
	public void GetFullUrl(@PathVariable("shortUrl")final String shortUrl) {
		
	}

}
