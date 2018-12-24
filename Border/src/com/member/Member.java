package com.member;

public class Member {
	private String name;
	private String userid;
	private String pwd;
	private String email;
	private String phone;
	private String zipcode;
	private String addr;
	
	
	public String getZipcode() {
		return zipcode == null ? "" : zipcode.trim();
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddr() {
		return addr == null ? "" : addr.trim();
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	private int admin;
	public String getName() {
		return name == null ? "" : name.trim();
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUserid() {
		return userid == null ? "" : userid.trim();
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPwd() {
		return pwd == null ? "" : pwd.trim();
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getEmail() {
		return email == null ? "" : email.trim();
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone == null ? "" : phone.trim();
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public int getAdmin() {
		return admin;
	}
	public void setAdmin(int admin) {
		this.admin = admin;
	}

}
