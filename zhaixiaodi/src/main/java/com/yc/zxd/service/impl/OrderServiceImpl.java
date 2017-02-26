package com.yc.zxd.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yc.zxd.entity.Order;
import com.yc.zxd.mapper.OrderMapper;
import com.yc.zxd.service.OrderService;

@Service("orderService")
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderMapper orderMapper;

	
	@Override
	public boolean order(Order ord) {
		
		return orderMapper.order(ord);
	}

}
