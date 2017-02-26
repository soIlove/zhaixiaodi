package com.yc.zxd.service;

import java.util.List;

import com.yc.zxd.entity.Express;
import com.yc.zxd.entity.ExpressType;
import com.yc.zxd.entity.PaginationBean;

public interface ExpressService {

	PaginationBean<Express> pageList(String page, String rows);

	List<ExpressType> typeList();

}
