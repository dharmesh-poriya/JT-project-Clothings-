package com.clothes.demo.models.vendor;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@SuppressWarnings("serial")
@Entity
public class BillingAddress implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long aid;
	private String house_no;
	private String street;
	private String city;
	private String district;
	private String state;
	private String pincode;

	public Long getAid() {
		return aid;
	}

	public void setAid(Long aid) {
		this.aid = aid;
	}

	public String getHouse_no() {
		return house_no;
	}

	public void setHouse_no(String house_no) {
		this.house_no = house_no;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getPincode() {
		return pincode;
	}

	public void setPincode(String pincode) {
		this.pincode = pincode;
	}

	@Override
	public String toString() {
		return "BillingAddress [aid=" + aid + ", house_no=" + house_no + ", street=" + street + ", city=" + city
				+ ", district=" + district + ", state=" + state + ", pincode=" + pincode + "]";
	}

}
