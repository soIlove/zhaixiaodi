package com.yc.zxd.mapper;

import com.yc.zxd.entity.Applyorder;
import com.yc.zxd.entity.Order;

public interface OrderMapper {

	public boolean order(Order ord);

	public Integer getIdByAddr(String addr);

	public boolean addzaccept(Applyorder applyorder);

}
