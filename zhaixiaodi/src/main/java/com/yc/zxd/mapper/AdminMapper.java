package com.yc.zxd.mapper;

import com.yc.zxd.entity.Admin;
import com.yc.zxd.entity.PaginationBean;
import com.yc.zxd.entity.User;

public interface AdminMapper {

	public Admin getAdmin(Admin admin);

	public PaginationBean<User> getUserPagination(PaginationBean<User> userBean);

}
