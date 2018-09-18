package com.service.dbservice.tables;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
//import javax.persistence.NamedNativeQueries;
//import javax.persistence.NamedNativeQuery;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "allUrl", catalog = "url")
@NoArgsConstructor
@AllArgsConstructor
@NamedQueries(  
	    {  
	        @NamedQuery(  
	        name = "AllUrls.findUrlByHash",  
	        query = "from AllUrls e where e.hash = :hash"  
	        ),  
	    }

	)  
public class AllUrls implements java.io.Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Getter
	@Setter
	@GeneratedValue(strategy=GenerationType.IDENTITY)
//	@Column(name = "id")
	public long id;
	
	@Getter
	@Setter
	@Column(name = "short_url")
	public String hash;
	
	@Getter
	@Setter
	@Column(name = "user_id")
	public String UserId;
	
	@Getter
	@Setter
	@Column(name = "full_url")
	public String fullUrl;
	
	@Getter
	@Setter
	@Column(name = "privacy")
	public Boolean privacy;
	
	@Getter
	@Setter
	@Column(name = "life_span")
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss.SSS")
	public Timestamp lifeSpan;
}
