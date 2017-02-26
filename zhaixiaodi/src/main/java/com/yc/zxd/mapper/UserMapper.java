package com.yc.zxd.mapper;

import org.apache.ibatis.annotations.Param;

import com.yc.zxd.entity.User;

public interface UserMapper {

	String findUser(String tel);

	String getMail(String tel);

	Integer editPwdByTel(@Param("tel") String tel, @Param("password")String password);
	
	User getUser(User user);

	boolean RegisterUser(User user);


}
