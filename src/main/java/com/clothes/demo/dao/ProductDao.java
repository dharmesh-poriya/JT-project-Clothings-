package com.clothes.demo.dao;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import com.clothes.demo.models.products.Product;
import com.clothes.demo.models.vendor.Vendor;

public interface ProductDao extends JpaRepository<Product, Long> {
//	find product by vendor id
	@Query("from Product where vendor_vendor_id=?1 order by product_added_date desc")
	List<Product> findByVendor(Vendor vendor);

//	Find by product code
	@Query("from Product where product_code=?1")
	List<Product> findByProduct_code(String product_code);
	
//	Update product details
	@Transactional
	@Modifying
	@Query("update Product p set p.product_code=?1, p.product_image=?2, p.product_name=?3, p.product_description=?4, p.product_price=?5, p.product_category=?6 where p.id = ?7")
	void setProductDetailsById(String product_code, String product_image, String product_name, String product_description,  Double product_price, String product_category,Long id);
	
//	find all product by category
	@Query("from Product where product_category=?1 order by product_added_date")
	List<Product> findByProduct_category(String product_category);
	
//	set sold items by using id
	@Transactional
	@Modifying
	@Query("update Product p set p.sold_quantity=?1 where p.id = ?2")
	void setSold_QuantityById(Long quentity,Long id);
}
