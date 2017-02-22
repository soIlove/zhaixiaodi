package com.yc.zxd.mapper;

<<<<<<< HEAD
import org.apache.ibatis.annotations.Param;

public interface UserMapper {

	String findUser(String tel);

	String getMail(String tel);

	Integer editPwdByTel(@Param("tel") String tel, @Param("password")String password);
=======
import com.yc.zxd.entity.User;

public interface UserMapper {

	User getUser(User user);
>>>>>>> branch 'master' of https://github.com/soIlove/zhaixiaodi.git

}
