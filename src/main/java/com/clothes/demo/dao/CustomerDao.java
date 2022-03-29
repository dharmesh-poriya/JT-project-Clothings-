package com.clothes.demo.dao;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import com.clothes.demo.models.customer.CustomerDetails;

public interface CustomerDao extends JpaRepository<CustomerDetails, Long> {
	@Query("from CustomerDetails where customer_email_id=?1 and customer_password=?2")
	List<CustomerDetails> findBycustomer_email_idAndcustomer_password(String customer_email_id,String customer_password);

//	find by emailid
	@Query("from CustomerDetails where customer_email_id=?1")
	List<CustomerDetails> findBycustomer_email_id(String customer_email_id);
	
//	find by contact number
	@Query("from CustomerDetails where customer_contact_number=?1")
	List<CustomerDetails> findBycustomer_contact_number(String 	customer_contact_number);
	
//	Update Customer details
	@Transactional
	@Modifying
	@Query("update CustomerDetails cd set cd.customer_name=?1, cd.profile_image=?2, cd.	customer_email_id=?3, cd.customer_contact_number=?4, cd.customer_dob=?5 where cd.customer_id = ?6")
	void setCustomerDetailsById(String customer_name,String profile_image,String customer_email_id,String customer_contact_number,Date customer_dob,Long id);

	@Transactional
	void deleteById(Long id);
}
