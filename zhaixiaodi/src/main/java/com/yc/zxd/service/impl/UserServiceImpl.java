package com.yc.zxd.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yc.zxd.entity.User;
import com.yc.zxd.mapper.UserMapper;
import com.yc.zxd.service.UserService;

@Service("userService")
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userMapper;

	
	@Override
	public boolean isExistUN(String tel) {
		return userMapper.findUser(tel)!=null;
	}


	@Override
	public String getMail(String tel) {
		String temp_mail=userMapper.getMail(tel);
//		char[] mail=temp_mail.toCharArray();
//		int index=temp_mail.indexOf("@");
//		for (int i = 0; i < mail.length; i++) {
//			if(i >=2 && i<index){
//				mail[i]= '*';
//			}
//		}
		return new String (temp_mail);
	}


	@Override
	public boolean editPwdByTel(String tel, String password) {
		Integer result=userMapper.editPwdByTel(tel,password);
		System.out.println("返回值:"+result);
		if(result == null){
			return false;
		}
		return true;
	}	
	
	@Override
	public User login(User user) {
		//user.setPassword(Encrypt.md5AndSha(user.getPassword()));
		return userMapper.getUser(user);	
	}

	@Override
	public boolean RegisterUser(User user) {
		return userMapper.RegisterUser(user);
	}



	

}


	
