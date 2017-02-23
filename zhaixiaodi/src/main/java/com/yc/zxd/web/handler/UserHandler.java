package com.yc.zxd.web.handler;


import java.io.File;
import java.io.IOException;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.yc.zxd.entity.User;
import com.yc.zxd.service.UserService;

import com.yc.zxd.util.PhoneCode;
import com.yc.zxd.util.ServletUtil;

import com.yc.zxd.service.impl.UserServiceImpl;


@Controller
@RequestMapping("/zxd")
@SessionAttributes({"loginUser"})
public class UserHandler {

	@Autowired
	private UserService userService;

	@Autowired
	private JavaMailSender mailSender;

	private String code = "";

	public UserHandler() {
		userService = new UserServiceImpl();
	}

	@RequestMapping("/check") // 检查用户是否存在
	@ResponseBody
	public boolean check(String tel) {
		boolean result = false;
		LogManager.getLogger().debug("进入UserHandler 处理isExistUN,检查用户是否存在,username:" + tel);
		result = userService.isExistUN(tel);// 检查用户是否存在
		return result;
	}

	@RequestMapping("/verifyCode") // 检查用户是否存在
	@ResponseBody
	public boolean verifyCode(String code, ServletRequest request) {
		boolean result = false;
		HttpSession session = ((HttpServletRequest) request).getSession();
		String realCode = (String) session.getAttribute("rand"); // 取到原始验证码
		LogManager.getLogger().debug("进入UserHandler 处理verifyCode,检查验证码是否正确,code:" + code + "\t真的验证码:" + realCode);
		if (realCode != null && code != null) {
			if (realCode.intern() == code.intern()) {
				result = true;
			}
		}
		return result;
	}

	@RequestMapping("/editPwd") // 修改密码
	public String editPwdByTel(String tel, String password, ServletRequest request) {
		boolean result = false;
		LogManager.getLogger().debug("进入UserHandler 处理editPwd,检查验证码是否正确,tel:" + tel + "\t密码:" + password);
		if (tel.length() > 0 && password.length() > 0) {
			result = userService.editPwdByTel(tel, password);
		} else {
			result = false;
		}
		if (result) {
			return "redirect:/page/Login.jsp";
		} else {
			return "redirect:/htm/findPwd3.html?tel=" + tel;
		}

	}

	@RequestMapping("/getMail") // 得到邮箱
	@ResponseBody
	public String getUser(String tel) {
		String email = "";
		LogManager.getLogger().debug("进入UserHandler 处理getMail,根据电话得到邮箱,tel:" + tel);
		if (tel != null) {
			email = userService.getMail(tel);
		}

		return new Gson().toJson(email);
	}

	@RequestMapping("/sendMail") // 发送邮件
	@ResponseBody
	public String sendMail(String email, HttpServletRequest request) {
		LogManager.getLogger().debug("请求UserHandler 进行sendMail操作");
		LogManager.getLogger().debug("请求数据  email:" + email);
		if (email == null) {
			LogManager.getLogger().debug(" 要发送的邮件为空 ");
			return "";
		}
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");

			helper.setFrom("13237343452@163.com");
			helper.setTo(email);
			helper.setSubject("找回密码");
			code = new ImageCodeServelt().verifyCode(request);
			helper.setText("宅小递的验证码:" + code, true);
			System.out.println("真的验证码:" + code);
			 mailSender.send(message);

		} catch (MessagingException e) {
			e.printStackTrace();
			return new Gson().toJson("false");
		}

		return new Gson().toJson("true");
	}

	@RequestMapping("/login")
	public String login(User user, ModelMap map) {
		LogManager.getLogger().debug("请求UserHandler进行login的操作....");
		user = userService.login(user);
		if (user != null) {
			map.put("loginUser", user);// 存在session中
			return "redirect:/index.jsp";
		}
		map.put("errorMsg", "用户名或密码错误");// 存在request中
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
