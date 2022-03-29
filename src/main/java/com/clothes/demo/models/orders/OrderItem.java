package com.clothes.demo.models.orders;

import java.io.Serializable;
import java.sql.Time;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

import org.springframework.format.annotation.DateTimeFormat;

import com.clothes.demo.models.products.Product;

@SuppressWarnings("serial")
@Entity
public class OrderItem implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;
	private int quentity;
	private Double item_price;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date order_item_date;
	@DateTimeFormat(pattern = "hh:mm:ss")
	private Time order_item_time;
	@OneToOne
	private Product product;
	@ManyToOne
	private Order order;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public int getQuentity() {
		return quentity;
	}

	public void setQuentity(int quentity) {
		this.quentity = quentity;
	}

	public Double getItem_price() {
		return item_price;
	}

	public void setItem_price(Double item_price) {
		this.item_price = item_price;
	}

	public Date getOrder_item_date() {
		return order_item_date;
	}

	public void setOrder_item_date(Date order_item_date) {
		this.order_item_date = order_item_date;
	}

	public Time getOrder_item_time() {
		return order_item_time;
	}

	public void setOrder_item_time(Time order_item_time) {
		this.order_item_time = order_item_time;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	@Override
	public String toString() {
		return "OrderItem [id=" + id + ", quentity=" + quentity + ", item_price=" + item_price + ", order_item_date="
				+ order_item_date + ", order_item_time=" + order_item_time + ", order=" + order + "]";
	}
	
	

}
