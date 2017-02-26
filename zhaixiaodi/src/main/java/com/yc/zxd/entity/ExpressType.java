package com.yc.zxd.entity;

public class ExpressType {
	private String otype;
	private String num;
	
	public ExpressType() {
		// TODO Auto-generated constructor stub
	}

	public ExpressType(String otype, String num) {
		super();
		this.otype = otype;
		this.num = num;
	}

	public String getOtype() {
		return otype;
	}

	public void setOtype(String otype) {
		this.otype = otype;
	}

	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}

	@Override
	public String toString() {
		return "ExpressType [otype=" + otype + ", num=" + num + "]";
	}
	
	
}
