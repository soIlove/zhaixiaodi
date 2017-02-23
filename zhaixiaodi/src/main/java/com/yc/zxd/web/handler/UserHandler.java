package com.yc.zxd.web.handler;

import java.io.File;
import java.io.IOException;

import org.apache.logging.log4j.LogManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.yc.zxd.entity.User;
import com.yc.zxd.service.UserService;
import com.yc.zxd.util.PhoneCode;
import com.yc.zxd.util.ServletUtil;


@Controller
@RequestMapping("/zxd")
@SessionAttributes({"loginUser"})
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
	
	@Autowired
	PhoneCode phonecode;
	@RequestMapping("/captcha")
	@ResponseBody
	public  String  RegisterUser(String uphone){
		LogManager.getLogger().debug("注册用户请求获取短信验证码操作");
		String  IfGetCo=phonecode.getPhonemsg(uphone);
		
		if(IfGetCo!=""&IfGetCo!=null){			
			LogManager.getLogger().debug("恭喜你,验证码发送成功,您的验证码为："+IfGetCo);		
			return IfGetCo;
		}else{
			LogManager.getLogger().debug("验证码发送失败,请重新获取");
		}	
		return null;
	}
	
	@RequestMapping("/Register")
	@ResponseBody
	public boolean RegisterUser(@RequestParam(name="upicture",required=false)MultipartFile upicture,User user ){
		LogManager.getLogger().debug("用户申请注册");

		System.out.println(upicture+"upicture****************");
		if(upicture!=null && !upicture.isEmpty()){
			try {
				File file=new File(ServletUtil.UPLOAD_DIR_NAME,upicture.getOriginalFilename());
				upicture.transferTo(file);
				user.setUpicture("/"+ServletUtil.UPLOAD_DIR_NAME+"/"+upicture.getOriginalFilename());
				LogManager.getLogger().debug("头像上传成功，上传地址为:"+file);
			} catch (IllegalStateException | IOException e) {
				LogManager.getLogger().debug("头像上传失败：",e);	
			}
	
		}
	
		return userService.RegisterUser(user);
	}
	
}
