package com.clothes.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.ComponentScan;

import com.clothes.demo.bean.Mail;
import com.clothes.demo.services.MailService;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {
	    "com.clothes.demo"
	})
public class ClothingsApplication {

	public static void main(String[] args) {
		ApplicationContext ctx = SpringApplication.run(ClothingsApplication.class, args);
//		Mail mail = new Mail();
//        mail.setMailFrom("d.poriya05@gmail.com");
//        mail.setMailTo("dharmeshkporiya@gmail.com");
//        mail.setMailSubject("Spring Boot - Email Example");
//        mail.setMailContent("Learn How to send Email using Spring Boot!!!\n\nThanks\nwww.technicalkeeda.com");
// 
//        
//        MailService mailService = (MailService) ctx.getBean("mailService");
//        mailService.sendEmail(mail);
	}

}
