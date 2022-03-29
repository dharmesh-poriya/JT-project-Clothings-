package com.clothes.demo.models.vendor;

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
import javax.persistence.OneToOne;

import org.springframework.format.annotation.DateTimeFormat;

import com.clothes.demo.models.products.Product;

@SuppressWarnings("serial")
@Entity
public class Vendor implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long vendor_id;
	private String vendor_name;
	@Column(name = "vendor_contact_number", unique = true)
	private String vendor_contact_number;
	@Column(name = "vendor_email_id", unique = true)
	private String vendor_email_id;
	private String image;
	private String vendor_password;
	private String vendor_shop_name;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date vendor_joiningdate;
	@OneToOne
	private BillingAddress billing_address;
	@OneToMany(mappedBy = "vendor",fetch = FetchType.EAGER)
	private List<Product> product;

	public Long getVendor_id() {
		return vendor_id;
	}

	public void setVendor_id(Long vendor_id) {
		this.vendor_id = vendor_id;
	}

	public String getVendor_name() {
		return vendor_name;
	}

	public void setVendor_name(String vendor_name) {
		this.vendor_name = vendor_name;
	}

	public String getVendor_contact_number() {
		return vendor_contact_number;
	}

	public void setVendor_contact_number(String vendor_contact_number) {
		this.vendor_contact_number = vendor_contact_number;
	}

	public String getVendor_email_id() {
		return vendor_email_id;
	}

	public void setVendor_email_id(String vendor_email_id) {
		this.vendor_email_id = vendor_email_id;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getVendor_password() {
		return vendor_password;
	}

	public void setVendor_password(String vendor_password) {
		this.vendor_password = vendor_password;
	}

	public String getVendor_shop_name() {
		return vendor_shop_name;
	}

	public void setVendor_shop_name(String vendor_shop_name) {
		this.vendor_shop_name = vendor_shop_name;
	}

	public Date getVendor_joiningdate() {
		return vendor_joiningdate;
	}

	public void setVendor_joiningdate(Date vendor_joiningdate) {
		this.vendor_joiningdate = vendor_joiningdate;
	}

	public BillingAddress getBilling_address() {
		return billing_address;
	}

	public void setBilling_address(BillingAddress billing_address) {
		this.billing_address = billing_address;
	}

	public List<Product> getProduct() {
		return product;
	}

	public void setProduct(List<Product> product) {
		this.product = product;
	}

	@Override
	public String toString() {
		return "Vendor [vendor_id=" + vendor_id + ", vendor_name=" + vendor_name + ", vendor_contact_number="
				+ vendor_contact_number + ", vendor_email_id=" + vendor_email_id + ", vendor_password="
				+ vendor_password + ", vendor_shop_name=" + vendor_shop_name + ", vendor_joiningdate="
				+ vendor_joiningdate + ", billing_address=" + billing_address + "]";
	}

}
