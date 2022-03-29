package com.clothes.demo.dao;


import java.util.Date;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import com.clothes.demo.models.customer.Address;
import com.clothes.demo.models.customer.CustomerDetails;

public interface AddressDao extends JpaRepository<Address, Long> {
	@Query("from Address where cd_customer_id=?1")
	Address findBycd(CustomerDetails c);
	
//	Update product details
	@Transactional
	@Modifying
	@Query("update Address ad set ad.house_no=?1, ad.street=?2, ad.city=?3, ad.district=?4, ad.state=?5, ad.pincode=?6  where ad.aid = ?7")
	void setAddressById(String house_no, String street, String city, String district,  String state, String pincode,Long aid);
	
	@Transactional
	void deleteByCd(CustomerDetails cd);
}
