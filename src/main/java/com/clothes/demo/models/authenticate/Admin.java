package com.clothes.demo.models.authenticate;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@SuppressWarnings("serial")
@Entity
public class Admin implements Serializable{
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long admin_id;
	private String admin_name;
	@Column(name = "admin_email_id",unique=true)
	private String admin_email_id;
	private String admin_password;
	
	public Long getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(Long admin_id) {
		this.admin_id = admin_id;
	}
	public String getAdmin_name() {
		return admin_name;
	}
	public void setAdmin_name(String admin_name) {
		this.admin_name = admin_name;
	}
	public String getAdmin_email_id() {
		return admin_email_id;
	}
	public void setAdmin_email_id(String admin_email_id) {
		this.admin_email_id = admin_email_id;
	}
	public String getAdmin_password() {
		return admin_password;
	}
	public void setAdmin_password(String admin_password) {
		this.admin_password = admin_password;
	}
	@Override
	public String toString() {
		return "Admin [admin_id=" + admin_id + ", admin_name=" + admin_name + ", admin_email_id=" + admin_email_id
				+ ", admin_password=" + admin_password + "]";
	}
	
	
	
	
}
