package com.yc.zxd.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yc.zxd.entity.Express;
import com.yc.zxd.entity.PaginationBean;
import com.yc.zxd.mapper.ExpressMapper;
import com.yc.zxd.service.ExpressService;

@Service("expressService")
public class ExpressServiceImpl implements ExpressService {

	@Autowired
	private ExpressMapper expressMapper;
	
	@Override
	public PaginationBean<Express> pageList(String currPage, String pageSize) {
		PaginationBean<Express> expressBean=new PaginationBean<Express>();
		if(currPage!=null){
			expressBean.setCurrPage(Integer.parseInt(currPage));
		}
		if(pageSize!=null){
			expressBean.setPageSize(Integer.parseInt(pageSize));
		}
		expressBean=expressMapper.getExpressPagination(expressBean);
		return expressBean;
	}

}
