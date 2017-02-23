package com.yc.zxd.service;

import com.yc.zxd.entity.User;
public interface UserService {

	boolean isExistUN(String username);

	String getMail(String tel);
	
	User login(User user);

<<<<<<< HEAD
	boolean RegisterUser(User user);
=======
	boolean editPwdByTel(String tel, String password);

>>>>>>> branch 'master' of git@github.com:soIlove/zhaixiaodi.git

}
