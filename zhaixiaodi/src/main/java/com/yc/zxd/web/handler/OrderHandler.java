package com.yc.zxd.web.handler;

import org.apache.logging.log4j.LogManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yc.zxd.entity.Applyorder;
import com.yc.zxd.entity.Order;
import com.yc.zxd.service.OrderService;

@Controller
@RequestMapping("/order")
public class OrderHandler {

	@Autowired
	private OrderService orderService;

	// public OrderHandler() {
	// orderService = new OrderServiceImpl();
	// }

	@RequestMapping("/submit") // 提交投单
	@ResponseBody
	public boolean submit(@RequestParam(name = "uid", required = false) Integer uuid, Order order) {
		boolean result = false;
		LogManager.getLogger().debug("进入UserHandler 处理order,检查用户的投单,order:" + order.toString());
		order.setUuid(1);
		result = orderService.order(order);// 检查用户是否存在
		return result;
	}
	
	@RequestMapping("/addzaccept")
	@ResponseBody
	public boolean addzaccept(Applyorder applyorder){
		System.out.println(applyorder+"能获取对象吗");	
		return orderService.addzaccept(applyorder);
		
	}

}
