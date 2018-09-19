package com.service.dbservice.resource;

import org.apache.http.HttpException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.service.dbservice.models.PrivateUrlSaveModel;
import com.service.dbservice.repositories.PrivateUrlCon;
import com.service.dbservice.repositories.UrlRepository;
import com.service.dbservice.tables.AllUrls;
import com.service.dbservice.tables.PrivateUrls;

@RestController
@RequestMapping("/db")
public class DbServices {
	
	@Autowired
	private UrlRepository urlRepository;
	
	@Autowired
	private PrivateUrlCon puc;

	@GetMapping("/{shortUrl}")
	public AllUrls getActualUrl(@PathVariable("shortUrl")final String shortUrl)throws HttpException {
		
		AllUrls au = urlRepository.findUrlByHash(shortUrl);		
		return au;
		
	}
	
	
	@PostMapping("/save")
	public AllUrls insertUrl(@RequestBody final AllUrls aul) throws HttpException{
//		System.out.println("###############################################");
//		System.out.println(aul.getFullUrl());
//		System.out.println(aul.getHash());
//		System.out.println("###############################################");
//		
		try {
			AllUrls returnObj = urlRepository.save(aul);
			return returnObj;
		
		}
		catch(Exception ex){
			throw new HttpException("save to Database failed");
		}
		
	}
	
	@PostMapping("/mark-private")
	public void insertPrivate(@RequestBody final PrivateUrlSaveModel psv) {
		psv.getUserId().stream().map(userId ->  new PrivateUrls(psv.shortUrl,userId)).forEach(privateUrl -> {
			puc.save(privateUrl);
		});
	}
	
	
	
	@DeleteMapping("/{shortUrl}")
	public void DeleteUrl(@PathVariable("shortUrl")final String shortUrl) {
		//AllUrls au = urlRepository.findUrlByHash(shortUrl);		
	}

}
