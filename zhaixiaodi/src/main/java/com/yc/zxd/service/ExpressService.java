package com.yc.zxd.service;

import com.yc.zxd.entity.Express;
import com.yc.zxd.entity.PaginationBean;

public interface ExpressService {

	PaginationBean<Express> pageList(String page, String rows);

}
