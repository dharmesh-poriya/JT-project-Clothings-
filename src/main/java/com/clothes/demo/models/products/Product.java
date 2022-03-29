package com.clothes.demo.models.products;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

import org.springframework.format.annotation.DateTimeFormat;

import com.clothes.demo.models.vendor.Vendor;

@SuppressWarnings("serial")
@Entity
public class Product implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;
	@Column(name = "product_code", unique = true)
	private String product_code;
	private String product_image;
	private String product_name;
	private String product_description;
	private Double product_price;
	private String product_category;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date product_added_date;
	@Column(columnDefinition = "long default 0")
	private Long sold_quantity;
	@ManyToOne
	private Vendor vendor;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getProduct_code() {
		return product_code;
	}

	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}

	public String getProduct_image() {
		return product_image;
	}

	public void setProduct_image(String fileName) {
		this.product_image = fileName;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public String getProduct_description() {
		return product_description;
	}

	public void setProduct_description(String product_description) {
		this.product_description = product_description;
	}

	public Double getProduct_price() {
		return product_price;
	}

	public void setProduct_price(Double product_price) {
		this.product_price = product_price;
	}

	public String getProduct_category() {
		return product_category;
	}

	public void setProduct_category(String product_category) {
		this.product_category = product_category;
	}

	public Date getProduct_added_date() {
		return product_added_date;
	}

	public void setProduct_added_date(Date product_added_date) {
		this.product_added_date = product_added_date;
	}

	public Long getSold_quantity() {
		return sold_quantity;
	}

	public void setSold_quantity(Long sold_quantity) {
		this.sold_quantity = sold_quantity;
	}

	public Vendor getVendor() {
		return vendor;
	}

	public void setVendor(Vendor vendor) {
		this.vendor = vendor;
	}

	@Override
	public String toString() {
		return "Product [id=" + id + ", product_code=" + product_code + ", product_image=" + product_image
				+ ", product_name=" + product_name + ", product_description=" + product_description + ", product_price="
				+ product_price + ", product_category=" + product_category + ", product_added_date="
				+ product_added_date + ", vendor=" + vendor + "]";
	}

}
