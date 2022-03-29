package com.clothes.demo.models.customer;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import org.hibernate.annotations.ColumnDefault;
import org.springframework.format.annotation.DateTimeFormat;

import com.clothes.demo.models.orders.Order;

@SuppressWarnings("serial")
@Entity
public class CustomerDetails implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long customer_id;
	private String customer_name;
	@Column(name="profile_image",columnDefinition = "varchar(500) default 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyDgkPQavzX7KwcLzeAsf0fgOx_-D51F3fag&usqp=CAU'")
	private String profile_image;
	@Column(name = "customer_contact_number", unique = true)
	private String customer_contact_number;
	@Column(name = "customer_email_id", unique = true)
	private String customer_email_id;
	private String customer_password;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date customer_dob;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date customer_joiningdate;
	@OneToMany(mappedBy = "customer", fetch = FetchType.EAGER)
	private List<Order> orders;
//	@OneToOne
//	private Address customer_shipping_add;

	public Long getCustomer_id() {
		return customer_id;
	}

	public void setCustomer_id(Long customer_id) {
		this.customer_id = customer_id;
	}

	public String getCustomer_name() {
		return customer_name;
	}

	public void setCustomer_name(String customer_name) {
		this.customer_name = customer_name;
	}

	public String getProfile_image() {
		return profile_image;
	}

	public void setProfile_image(String profile_image) {
		this.profile_image = profile_image;
	}

	public String getCustomer_contact_number() {
		return customer_contact_number;
	}

	public void setCustomer_contact_number(String customer_contact_number) {
		this.customer_contact_number = customer_contact_number;
	}

	public String getCustomer_email_id() {
		return customer_email_id;
	}

	public void setCustomer_email_id(String customer_email_id) {
		this.customer_email_id = customer_email_id;
	}

	public String getCustomer_password() {
		return customer_password;
	}

	public void setCustomer_password(String customer_password) {
		this.customer_password = customer_password;
	}

	public Date getCustomer_dob() {
		return customer_dob;
	}

	public void setCustomer_dob(Date customer_dob) {
		this.customer_dob = customer_dob;
	}

	public Date getCustomer_joiningdate() {
		return customer_joiningdate;
	}

	public void setCustomer_joiningdate(Date customer_joiningdate) {
		this.customer_joiningdate = customer_joiningdate;
	}

	public List<Order> getOrders() {
		return orders;
	}

	public void setOrders(List<Order> orders) {
		this.orders = orders;
	}

	@Override
	public String toString() {
		return "CustomerDetails [customer_id=" + customer_id + ", customer_name=" + customer_name
				+ ", customer_contact_number=" + customer_contact_number + ", customer_email_id=" + customer_email_id
				+ ", customer_password=" + customer_password + ", customer_dob=" + customer_dob
				+ ", customer_joiningdate=" + customer_joiningdate + "]";
	}

//	public Address getCustomer_shipping_add() {
//		return customer_shipping_add;
//	}
//
//	public void setCustomer_shipping_add(Address customer_shipping_add) {
//		this.customer_shipping_add = customer_shipping_add;
//	}

}
