package com.clothes.demo.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.clothes.demo.models.authenticate.Admin;

public interface AdminDao extends JpaRepository<Admin, Long> {
	@Query("from Admin where admin_email_id=?1 and admin_password=?2")
	List<Admin> findByadmin_email_idAndadmin_password(String admin_email_id,String admin_password);
}
