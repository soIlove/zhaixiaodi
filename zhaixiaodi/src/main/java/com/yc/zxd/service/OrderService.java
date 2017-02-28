package com.yc.zxd.service;

import com.yc.zxd.entity.Applyorder;
import com.yc.zxd.entity.Order;

public interface OrderService {

	boolean order(Order ord);

	boolean addzaccept(Applyorder applyorder);

}
