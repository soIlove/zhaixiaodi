package com.yc.zxd.entity;

public class User {
	private Integer uuid;
	private String upwd;
	private String uname;
	private String uphone;
	private String uemail;
	private String usex;
	private String upicture;
	private String uaddr;
	private Integer utype;
	
	public User() {
		// TODO Auto-generated constructor stub
	}
	
	public User(String upwd, String uphone) {
		super();
		this.upwd = upwd;
		this.uphone = uphone;
	}
	


	public User(String upwd, String uname, String uphone, String uemail,
			String usex,  String uaddr) {
		super();
		this.upwd = upwd;
		this.uname = uname;
		this.uphone = uphone;
		this.uemail = uemail;
		this.usex = usex;
		this.uaddr = uaddr;
	}

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public String getUpwd() {
		return upwd;
	}

	public void setUpwd(String upwd) {
		this.upwd = upwd;
	}

	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	public String getUphone() {
		return uphone;
	}

	public void setUphone(String uphone) {
		this.uphone = uphone;
	}

	public String getUemail() {
		return uemail;
	}

	public void setUemail(String uemail) {
		this.uemail = uemail;
	}

	public String getUsex() {
		return usex;
	}

	public void setUsex(String usex) {
		this.usex = usex;
	}

	public String getUpicture() {
		return upicture;
	}

	public void setUpicture(String upicture) {
		this.upicture = upicture;
	}

	public String getUaddr() {
		return uaddr;
	}

	public void setUaddr(String uaddr) {
		this.uaddr = uaddr;
	}

	public Integer getUtype() {
		return utype;
	}

	public void setUtype(Integer utype) {
		this.utype = utype;
	}
	
	
	
}
