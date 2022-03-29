package com.clothes.demo.models.orders;

import java.io.Serializable;
import java.sql.Time;
import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

import com.clothes.demo.models.customer.CustomerDetails;

@SuppressWarnings("serial")
@Entity
@Table(name = "myorder")
public class Order implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;
	@ManyToOne
	private CustomerDetails customer;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date order_date;
	@DateTimeFormat(pattern = "hh:mm:ss")
	private Time order_time;
	@OneToMany(mappedBy = "order", fetch = FetchType.EAGER)
	private List<OrderItem> order_items;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public CustomerDetails getCustomer() {
		return customer;
	}

	public void setCustomer(CustomerDetails customer) {
		this.customer = customer;
	}

	public Date getOrder_date() {
		return order_date;
	}

	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}

	public Time getOrder_time() {
		return order_time;
	}

	public void setOrder_time(Time order_time) {
		this.order_time = order_time;
	}

	public List<OrderItem> getOrder_items() {
		return order_items;
	}

	public void setOrder_items(List<OrderItem> order_items) {
		this.order_items = order_items;
	}

	@Override
	public String toString() {
		return "Order [id=" + id + ", customer=" + customer + ", order_date=" + order_date + ", order_time="
				+ order_time + ", order_items=" + order_items + "]";
	}
	
	
}
