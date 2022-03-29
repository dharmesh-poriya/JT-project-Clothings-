package com.clothes.demo.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.clothes.demo.models.customer.CustomerDetails;
import com.clothes.demo.models.orders.Order;

public interface OrderDao extends JpaRepository<Order, Long> {
	@Query("from Order where customer_customer_id=?1 order by order_date desc")
	List<Order> findByCustomerSorted(CustomerDetails customer);
}
