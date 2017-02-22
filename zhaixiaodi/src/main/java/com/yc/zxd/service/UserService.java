package com.yc.zxd.service;

<<<<<<< HEAD
public interface UserService {

	boolean isExistUN(String username);

	String getMail(String tel);

	boolean editPwdByTel(String tel, String password);
=======
import com.yc.zxd.entity.User;

public interface UserService {

	User login(User user);
>>>>>>> branch 'master' of https://github.com/soIlove/zhaixiaodi.git

}
