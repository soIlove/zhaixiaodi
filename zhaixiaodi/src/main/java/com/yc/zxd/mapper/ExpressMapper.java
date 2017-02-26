package com.yc.zxd.mapper;

import com.yc.zxd.entity.Express;
import com.yc.zxd.entity.PaginationBean;

public interface ExpressMapper {

	PaginationBean<Express> getExpressPagination(PaginationBean<Express> expressBean);

	
}
