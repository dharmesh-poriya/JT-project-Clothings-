package com.clothes.demo.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import com.clothes.demo.models.vendor.Vendor;

public interface VendorDao extends JpaRepository<Vendor, Long> {
	@Query("from Vendor where vendor_email_id=?1 and vendor_password=?2")
	List<Vendor> findByvendor_email_idAndvendor_password(String vendor_email_id, String vendor_password);

//	find by email id
	@Query("from Vendor where vendor_email_id=?1")
	List<Vendor> findByvendor_email_id(String vendor_email_id);

//	find by contact number
	@Query("from Vendor where vendor_contact_number=?1")
	List<Vendor> findByvendor_contact_number(String vendor_contact_number);
	
//	Update Vendor details
	@Transactional
	@Modifying
	@Query("update Vendor v set v.image=?1, v.vendor_contact_number=?2, v.vendor_email_id=?3, v.vendor_name=?4, v.vendor_shop_name=?5 where v.vendor_id=?6")
	void setVendorById(String image,String vendor_contact_number,String vendor_email_id,String vendor_name,String vendor_shop_name,Long id);


}
