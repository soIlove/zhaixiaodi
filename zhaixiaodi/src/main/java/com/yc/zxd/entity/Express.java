package com.yc.zxd.entity;

import java.sql.Date;

public class Express {
	private Integer oid;
	private String uname;
	private Date otime;
	private String orelname;
	private String ocode;
	private String osize;
	private String odesc;
	private String zaddr;
	private String oprice;
	private String otype;
	
	public Express() {
		// TODO Auto-generated constructor stub
	}

	public Express(Integer oid, String uname, Date otime, String orelname, String ocode, String osize, String odesc,
			String zaddr, String oprice, String otype) {
		super();
		this.oid = oid;
		this.uname = uname;
		this.otime = otime;
		this.orelname = orelname;
		this.ocode = ocode;
		this.osize = osize;
		this.odesc = odesc;
		this.zaddr = zaddr;
		this.oprice = oprice;
		this.otype = otype;
	}

	public Integer getOid() {
		return oid;
	}

	public void setOid(Integer oid) {
		this.oid = oid;
	}

	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	public Date getOtime() {
		return otime;
	}

	public void setOtime(Date otime) {
		this.otime = otime;
	}

	public String getOrelname() {
		return orelname;
	}

	public void setOrelname(String orelname) {
		this.orelname = orelname;
	}

	public String getOcode() {
		return ocode;
	}

	public void setOcode(String ocode) {
		this.ocode = ocode;
	}

	public String getOsize() {
		return osize;
	}

	public void setOsize(String osize) {
		this.osize = osize;
	}

	public String getOdesc() {
		return odesc;
	}

	public void setOdesc(String odesc) {
		this.odesc = odesc;
	}

	public String getZaddr() {
		return zaddr;
	}

	public void setZaddr(String zaddr) {
		this.zaddr = zaddr;
	}

	public String getOprice() {
		return oprice;
	}

	public void setOprice(String oprice) {
		this.oprice = oprice;
	}

	public String getOtype() {
		return otype;
	}

	public void setOtype(String otype) {
		this.otype = otype;
	}

	@Override
	public String toString() {
		return "Express [oid=" + oid + ", uname=" + uname + ", otime=" + otime + ", orelname=" + orelname + ", ocode="
				+ ocode + ", osize=" + osize + ", odesc=" + odesc + ", zaddr=" + zaddr + ", oprice=" + oprice
				+ ", otype=" + otype + "]";
	}

	
	
}
