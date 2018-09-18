package com.service.url.generateurl.resource;

import org.apache.http.HttpException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.service.url.generateurl.model.RequestModel;
import com.service.url.generateurl.model.ResponseEntityForGenerate;
import com.service.url.generateurl.model.dbUrlSaveModel;

import java.util.*;
import java.security.*;
import java.sql.Date;
import java.sql.Timestamp;
import java.io.UnsupportedEncodingException;

@RestController
@RequestMapping("/gen")
public class UrlGenerator {
	
	@Autowired
	RestTemplate restTemplate;
	
	@PostMapping("/generate")
	public ResponseEntityForGenerate saveUrl(@RequestBody final RequestModel srv) throws HttpException {
		
		ResponseEntityForGenerate reg = new ResponseEntityForGenerate();
		if(srv.userId == null || srv.privacy == null) {
			reg.shortUrl = "Null";
			reg.status = "Cannot created private Url without userID, Please Login";
			return reg;
		}
		
		if(srv.expiry == null) {
			System.out.println("vik exp null");
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.YEAR, 1);
			Date nextYear = new Date(cal.getTimeInMillis());
			srv.expiry = new Timestamp(nextYear.getTime());
		}
		
		String hash = generateShortUrl(new StringBuilder(srv.fullUrl));
		
		String dbSaveUrl = "http://db-service/db/save";
		//String dbSaveUrl = "http://192.168.0.100:8300/db/save";
		
		HttpEntity<dbUrlSaveModel> requestEntity = new HttpEntity<>(new dbUrlSaveModel(srv,hash));
		try {
			ResponseEntity<dbUrlSaveModel> quoteResponse = restTemplate.exchange(dbSaveUrl, HttpMethod.POST, requestEntity, dbUrlSaveModel.class);
			reg.shortUrl=quoteResponse.getBody().hash;
			reg.status = "created successfully";
			
			
			if(srv.privacy) {
				//push in private db with current userID 
			}
			return reg;
		}
		catch(Exception ex){
			System.out.println("vik ex = "+ ex.getMessage());
			throw new HttpException("try again");
		}
		
	}
	
	public String generateShortUrl(StringBuilder fullUrl) {
		
		while(true) {
			
			String shortUrl = getHash(fullUrl);
			System.out.println("short url = " + shortUrl);
			
			if(isAvailable(shortUrl)) {
				return shortUrl;
			}
			
			fullUrl = fullUrl.append(Double.toString(Math.random()));
		}
		
	}
	
	private boolean isAvailable(String shortUrl) {
		//return true is can insert or is already present and accessible
		return true;
	}

	public String getHash(StringBuilder fullUrl) {
		try {
			
			MessageDigest m=MessageDigest.getInstance("MD5");
			byte[] thedigest = m.digest(fullUrl.toString().getBytes("UTF-8"));
			
//			StringBuffer sb = new StringBuffer();
//	        for (int i = 0; i < thedigest.length; ++i) {
//	          sb.append(Integer.toHexString((thedigest[i] & 0xFF) | 0x100).substring(1,3));
//	        }
			
	        return Base64.getUrlEncoder().encodeToString(thedigest).substring(0, 6);
			
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return fullUrl.toString();
		
	}
	
	
	/*
	 * For private Urls
	 */

}
