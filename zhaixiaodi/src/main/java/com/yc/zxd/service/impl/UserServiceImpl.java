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
	public User login(User user) {
		//user.setPassword(Encrypt.md5AndSha(user.getPassword()));
		return userMapper.getUser(user);
	}

	@Override
	public boolean RegisterUser(User user) {
		// TODO Auto-generated method stub
		return userMapper.RegisterUser(user);
	}

}
