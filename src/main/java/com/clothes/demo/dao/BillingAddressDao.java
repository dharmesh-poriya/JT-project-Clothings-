package com.clothes.demo.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import com.clothes.demo.models.vendor.BillingAddress;

public interface BillingAddressDao extends JpaRepository<BillingAddress, Long> {
//	Update Billing Address details
	@Transactional
	@Modifying
	@Query("update BillingAddress ba set ba.house_no=?1, ba.street=?2, ba.city=?3, ba.district=?4, ba.state=?5, ba.pincode=?6 where ba.aid=?7")
	void setBillingAdressById(String house_no,String street,String city,String district,String state,String pincode,Long aid);

}
