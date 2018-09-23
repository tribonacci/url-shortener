package com.service.url.retrieveurl.resource;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;

import com.service.url.retrieveurl.model.ResponseForFetch;

@RestController
@RequestMapping("/fetch")
public class UrlFetcher {

	@Autowired
	RestTemplate restTemplate;

	@GetMapping("/{shortUrl}")
	public ResponseForFetch GetFullUrl(@PathVariable("shortUrl") final String shortUrl) {
		ResponseForFetch rep = new ResponseForFetch();

		String dbfetchUrl = "http://db-service/db/" + shortUrl;

		ResponseEntity<ResponseForFetch> quoteResponse = restTemplate.getForEntity(dbfetchUrl, ResponseForFetch.class);
		if(quoteResponse.getBody()==null){
			rep.status = "NA";
			rep.fullUrl = "NA";
			rep.userId = "NA";
		}
		else if (quoteResponse.getBody()!=null && quoteResponse.getBody().privacy) {
			rep.status = "shortUrl is private,please provide your id to check for authentocation!!";
			rep.fullUrl = "NA";
			rep.userId = "NA";
			rep.privacy = quoteResponse.getBody().privacy;
		} 
		else if(quoteResponse.getBody()!=null && !quoteResponse.getBody().privacy) {
			rep.fullUrl = quoteResponse.getBody().fullUrl;
			rep.userId = quoteResponse.getBody().userId;
			rep.privacy = quoteResponse.getBody().privacy;
			rep.status = "Successfull!!";
		}
		return rep;
	}
	
	@GetMapping("/{shortUrl}/{userId}")
	public ResponseForFetch GetFullUrl(@PathVariable("shortUrl") final String shortUrl,@PathVariable("userId") final String userId) {
		ResponseForFetch rep = new ResponseForFetch();

		String dbfetchUrl = "http://db-service/db/" + shortUrl + "/" + userId;
				
		ResponseEntity<ResponseForFetch> quoteResponse = null;
		try{
			quoteResponse = restTemplate.getForEntity(dbfetchUrl, ResponseForFetch.class);
			if(quoteResponse.getBody()!=null){
				rep.fullUrl = quoteResponse.getBody().fullUrl;
				rep.userId = quoteResponse.getBody().userId;
				rep.privacy = quoteResponse.getBody().privacy;
				rep.status = "Successfull!";
			}
		
		}
		catch(HttpStatusCodeException e) {
			System.out.println("Status Code"+e.getStatusCode());
		}
		return rep;
	}

}
