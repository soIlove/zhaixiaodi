package com.yc.zxd.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yc.zxd.entity.Admin;
import com.yc.zxd.entity.PaginationBean;
import com.yc.zxd.entity.User;
import com.yc.zxd.mapper.AdminMapper;
import com.yc.zxd.service.AdminService;

@Service("adminService")
public class AdminServiceImpl implements AdminService {
	

	@Autowired
	private AdminMapper AdminMapper;

	 
	
	@Override
	public Admin login(Admin admin) {
		
		return AdminMapper.getAdmin(admin);	
	}



	@Override
	public PaginationBean<User> getAllUser(String currPage, String pageSize) {
		PaginationBean<User> userBean=new PaginationBean<User>();
		if(currPage!=null){
			userBean.setCurrPage(Integer.parseInt(currPage));
		}
		if(pageSize!=null){
			userBean.setPageSize(Integer.parseInt(pageSize));
		}
		userBean=AdminMapper.getUserPagination(userBean);
		return userBean;
	}



	@Override
	public boolean modifyPwd(String newPwd, String adid) {
		
		return AdminMapper.modifyPwd(newPwd,adid) >0;	
	}

}
