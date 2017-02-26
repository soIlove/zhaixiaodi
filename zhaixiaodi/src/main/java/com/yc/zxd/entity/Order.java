package com.yc.zxd.entity;

import java.util.Date;

public class Order {
	private Integer oid;
	private Integer uuid;
	private Integer zid;
	private Date otime;
	private String orelname;
	private String ocode;
	private String osize;
	private String odesc;
	private String oaddr;
	private String oprice;
	private String otype;
	
	public Integer getOid() {
		return oid;
	}
	public void setOid(Integer oid) {
		this.oid = oid;
	}
	public Integer getUuid() {
		return uuid;
	}
	public void setUuid(Integer uuid) {
		this.uuid = uuid;
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
	public String getOdesc() {
		return odesc;
	}
	public void setOdesc(String odesc) {
		this.odesc = odesc;
	}
	public String getOtype() {
		return otype;
	}
	public void setOtype(String otype) {
		this.otype = otype;
	}
	public Order() {
	}
	public String getOsize() {
		return osize;
	}
	public void setOsize(String osize) {
		this.osize = osize;
	}
	public String getOprice() {
		return oprice;
	}
	public void setOprice(String oprice) {
		this.oprice = oprice;
	}
	public String getOaddr() {
		return oaddr;
	}
	public void setOaddr(String oaddr) {
		this.oaddr = oaddr;
	}
	
	public Integer getZid() {
		return zid;
	}
	public void setZid(Integer zid) {
		this.zid = zid;
	}
	@Override
	public String toString() {
		return "Order [oid=" + oid + ", uuid=" + uuid + ", zid=" + zid + ", otime=" + otime + ", orelname=" + orelname
				+ ", ocode=" + ocode + ", osize=" + osize + ", odesc=" + odesc + ", oaddr=" + oaddr + ", oprice="
				+ oprice + ", otype=" + otype + "]";
	}
	public Order(Integer oid, Integer uuid, Integer zid, Date otime, String orelname, String ocode, String osize,
			String odesc, String oaddr, String oprice, String otype) {
		super();
		this.oid = oid;
		this.uuid = uuid;
		this.zid = zid;
		this.otime = otime;
		this.orelname = orelname;
		this.ocode = ocode;
		this.osize = osize;
		this.odesc = odesc;
		this.oaddr = oaddr;
		this.oprice = oprice;
		this.otype = otype;
	}
	 
	 
	 
	 
	
}
