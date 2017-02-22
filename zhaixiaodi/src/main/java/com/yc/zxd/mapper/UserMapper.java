package com.yc.zxd.mapper;

import org.apache.ibatis.annotations.Param;

public interface UserMapper {

	String findUser(String tel);

	String getMail(String tel);

	Integer editPwdByTel(@Param("tel") String tel, @Param("password")String password);

}
