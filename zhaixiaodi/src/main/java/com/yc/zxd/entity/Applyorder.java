package com.yc.zxd.entity;


public class Applyorder {
	  private Integer oid;
	  private String adesc;
	  private int did;
	  
	public Applyorder(Integer oid, String adesc, int did) {
		super();
		this.oid = oid;
		this.adesc = adesc;
		this.did = did;
	}

	public Integer getOid() {
		return oid;
	}

	public void setOid(Integer oid) {
		this.oid = oid;
	}

	public String getAdesc() {
		return adesc;
	}

	public void setAdesc(String adesc) {
		this.adesc = adesc;
	}

	public int getDid() {
		return did;
	}

	public void setDid(int did) {
		this.did = did;
	}

	public Applyorder() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public String toString() {
		return "Applyorder [oid=" + oid + ", adesc=" + adesc + ", did=" + did
				+ "]";
	}

	
	  
	  
}
