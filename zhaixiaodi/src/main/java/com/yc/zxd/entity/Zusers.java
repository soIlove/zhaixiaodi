package com.yc.zxd.entity;

import org.springframework.stereotype.Component;

@Component("zusers")
public class Zusers {
	private Integer uuid;
	private String upwd;
	private String uname;
	private Integer uphone;
	private String uemail;
	private String usex;
	private String upicture;
	private String uaddr;
	private Integer utype;

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

	public Integer getUphone() {
		return uphone;
	}

	public void setUphone(Integer uphone) {
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

	public Zusers(Integer uuid, String upwd, String uname, Integer uphone, String uemail, String usex, String upicture,
			String uaddr, Integer utype) {
		super();
		this.uuid = uuid;
		this.upwd = upwd;
		this.uname = uname;
		this.uphone = uphone;
		this.uemail = uemail;
		this.usex = usex;
		this.upicture = upicture;
		this.uaddr = uaddr;
		this.utype = utype;
	}

	public Zusers() {
	}

	@Override
	public String toString() {
		return "Zusers [uuid=" + uuid + ", upwd=" + upwd + ", uname=" + uname + ", uphone=" + uphone + ", uemail="
				+ uemail + ", usex=" + usex + ", upicture=" + upicture + ", uaddr=" + uaddr + ", utype=" + utype + "]";
	}

}
