package com.service.dbservice.tables;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "privateUrl", catalog = "url")
@NoArgsConstructor
@AllArgsConstructor
public class PrivateUrls {
	
	@Id
	@Getter
	@Setter
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id")
	public Integer id;
	
	@Getter
	@Setter
	@Column(name = "short_url")
	public String hash;
	
	@Getter
	@Setter
	@Column(name = "user_id")
	public String userId;

	public PrivateUrls(String shortUrl, String userId) {
		// TODO Auto-generated constructor stub
		this.hash = shortUrl;
		this.userId = userId;
	}

}
