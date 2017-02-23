package com.yc.zxd.web.handler;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.yc.zxd.util.PhoneCode;

@Controller
@RequestMapping("/zxduser")

public class ZxdUserHandler {
	
	@Autowired
	PhoneCode phonecode;
	
	@RequestMapping("/captcha")
	@ResponseBody
	public  String  RegisterUser(String vphone){
		String  IfGetCo=phonecode.getPhonemsg(vphone);
		
		if(IfGetCo!=""&IfGetCo!=null){			
			LogManager.getLogger().debug("恭喜你,验证码发送成功,您的验证码为："+IfGetCo);		
			return IfGetCo;
		}else{
			LogManager.getLogger().debug("验证码发送失败,请重新获取");
		}	
		return null;
	}
	
}
