package com.yc.zxd.service;

import com.yc.zxd.entity.User;
public interface UserService {

	boolean isExistUN(String username);

	String getMail(String tel);
	
	User login(User user);

	boolean RegisterUser(User user);

	boolean editPwdByTel(String tel, String password);



}
