package com.yc.zxd.service;

public interface UserService {

	boolean isExistUN(String username);

	String getMail(String tel);

	boolean editPwdByTel(String tel, String password);

}
