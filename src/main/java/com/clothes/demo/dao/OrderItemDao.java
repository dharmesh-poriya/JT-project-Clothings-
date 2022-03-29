package com.clothes.demo.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import com.clothes.demo.models.orders.Order;
import com.clothes.demo.models.orders.OrderItem;
import com.clothes.demo.models.products.Product;
import com.clothes.demo.models.vendor.Vendor;

public interface OrderItemDao extends JpaRepository<OrderItem, Long>{
//	find item by orderid and product id
	@Query("from OrderItem where order_id=?1 and product_id=?2")
	List<OrderItem> findByOrder_idAndProduct_id(Order o,Product p);

//	Update product details
	@Transactional
	@Modifying
	@Query("update OrderItem oi set oi.quentity=?1 where oi.id = ?2")
	void setOrderItemByQuentity(int quentity,Long id);
	
//	finding by order id
	@Query("from OrderItem where order_id=?1")
	List<OrderItem> findAllByOrder_id(Order o);
	
//	find all products according to vendor and product id
	@Query("from OrderItem as oi where oi.product in (from Product where vendor=?1)")
	List<OrderItem> findAllByVendor(Vendor v);
	
//	find all products according to vendor and product id
	@Transactional
	void deleteAllByOrder(Order o);
	
}
