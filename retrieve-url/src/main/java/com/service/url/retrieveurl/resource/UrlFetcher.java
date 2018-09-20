package com.service.url.retrieveurl.resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.service.url.retrieveurl.model.RequestForFetch;
import com.service.url.retrieveurl.model.ResponseForFetch;

@RestController
@RequestMapping("/fetch")
public class UrlFetcher {
	
	@Autowired
	RestTemplate restTemplate;
	
	@GetMapping("/{shortUrl}")
	public ResponseForFetch GetFullUrl(@PathVariable("shortUrl")final String shortUrl) {
		RequestForFetch req = new RequestForFetch();
		ResponseForFetch rep = new ResponseForFetch();
		
		req.setShortUrl(shortUrl);
		
		String dbfetchUrl = "http://db-service/db/";
		
		HttpEntity<RequestForFetch> requestEntity = new HttpEntity<>(req);
		
		try {
			
			ResponseEntity<RequestForFetch> quoteResponse = restTemplate.exchange(dbfetchUrl, HttpMethod.GET, requestEntity, RequestForFetch.class);
			
			//rep.longUrl=quoteResponse.getBody().;
			
			return rep;
		}
		catch(Exception ex){
			System.out.println(ex.getMessage());
		}
		return rep;
	}

}
