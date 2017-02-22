package com.yc.zxd.web.handler;

import org.apache.logging.log4j.LogManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.yc.zxd.entity.User;
import com.yc.zxd.service.UserService;


@Controller
@RequestMapping("/zxd")
@SessionAttributes("loginUser")
public class UserHandler {

	@Autowired
	private UserService userService;
	
	@RequestMapping("/login")
	public String login(User user, ModelMap map){
		LogManager.getLogger().debug("请求UserHandler进行login的操作....");
		user = userService.login(user);
		if(user != null){
			map.put("loginUser", user);//存在session中
			return "redirect:/index.jsp";
		}
		map.put("errorMsg", "用户名或密码错误");//存在request中
		return "forward:/page/Login.jsp";
	}
}
