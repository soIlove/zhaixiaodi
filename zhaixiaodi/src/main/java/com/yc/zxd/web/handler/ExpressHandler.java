package com.yc.zxd.web.handler;
import org.apache.logging.log4j.LogManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yc.zxd.entity.Express;
import com.yc.zxd.entity.PaginationBean;
import com.yc.zxd.service.ExpressService;

@Controller
@RequestMapping("/zxd")
//@SessionAttributes("loginUser")
public class ExpressHandler {
	
	@Autowired
	private ExpressService expressService;
	
	@RequestMapping("/list")
	@ResponseBody
	public PaginationBean<Express> pageList(String page,String rows){
		LogManager.getLogger().debug("请求ExpressHandler进行pageList的操作....");
		return expressService.pageList(page,rows);
	}
	
}
