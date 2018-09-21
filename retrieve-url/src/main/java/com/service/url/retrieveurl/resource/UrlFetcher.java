package com.service.url.retrieveurl.resource;

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
import org.springframework.web.client.RestTemplate;

import com.service.url.retrieveurl.model.RequestForFetch;
import com.service.url.retrieveurl.model.ResponseForFetch;

@RestController
@RequestMapping("/fetch")
public class UrlFetcher {

	@Autowired
	RestTemplate restTemplate;

	@GetMapping("/{shortUrl}")
	public ResponseForFetch GetFullUrl(@PathVariable("shortUrl") final String shortUrl) {
		RequestForFetch req = new RequestForFetch();
		ResponseForFetch rep = new ResponseForFetch();

		req.setShortUrl(shortUrl);

		String dbfetchUrl = "http://db-service/db/" + shortUrl;

		ResponseEntity<ResponseForFetch> quoteResponse = restTemplate.getForEntity(dbfetchUrl,ResponseForFetch.class);
		
		if (!quoteResponse.getBody().privacy) {
//			System.out.println("###############################################");
//			System.out.println(quoteResponse.getBody().privacy);
//			System.out.println("###############################################");
			rep.fullUrl = quoteResponse.getBody().fullUrl;
			rep.userId = quoteResponse.getBody().userId;
			rep.privacy = quoteResponse.getBody().privacy;
		}
		else{
			//Ask for user id and do validation on user id if privacy is set on given url
		}
		return rep;

	}

}
