package com.service.dbservice.resource;

import java.util.List;

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
import com.service.dbservice.repositories.PrivateGetAllUrl;
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
	
	@Autowired
	private PrivateGetAllUrl allprivateUrl;
	

	@GetMapping("/{shortUrl}")
	public AllUrls getActualUrl(@PathVariable("shortUrl")final String shortUrl)throws HttpException {
		AllUrls au = urlRepository.findUrlByHash(shortUrl);	
		AllUrls result = null;
		if(au!=null){
			result = au;
		}
		//use logstash
		return result;	
	}
	
	@GetMapping("/{shortUrl}/{userId}")
	public AllUrls getPrivateUrl(@PathVariable("shortUrl")final String shortUrl,@PathVariable("userId")final String userId)throws HttpException {
		List <PrivateUrls> pau = allprivateUrl.findIdByHash(shortUrl);
		
		AllUrls result = null;
		for(PrivateUrls row : pau) {
			  if(row.getUserId().equals(userId)){
				  //Now get full url for given short Url as authentication is successfull
				  AllUrls au = urlRepository.findUrlByHash(shortUrl);
				  result = au;
				  break;
			  }
		}
		
		return result;	
	}

//	public AllUrls insertUrl(@RequestBody final String jsn) throws HttpException, JSONException, ParseException{
//		System.out.println("###############################################");
//		System.out.println(aul.getFullUrl());
//		System.out.println("vik req body = " + jsn);
//		System.out.println("###############################################");
//		JSONObject jObject = new JSONObject(jsn);
//		
//		SimpleDateFormat dateFormat = new SimpleDateFormat(
//	            "yyyy-MM-dd hh:mm:ss:SSS");
//		
//		AllUrls aul = new AllUrls();
//		
//		aul.setFullUrl(jObject.getString("fullUrl"));
//		aul.setHash(jObject.getString("hash"));
//		aul.setLifeSpan( new Timestamp(dateFormat.parse(jObject.getString("lifeSpan")).getTime()));
//		aul.setUserId(jObject.getString("userId"));
//		aul.setPrivacy(Boolean.valueOf(jObject.getString("privacy")));
	@PostMapping("/save")
	public AllUrls insertUrl(@RequestBody final AllUrls aul) throws HttpException{
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
