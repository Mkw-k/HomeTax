package com.mkw.a.domain;

import java.io.Serializable;

public class MemberVo implements Serializable{

	private String name; 
	private String classify; 
	private String email;
	private int phone;
	private String pwd;
	private String issale;
	private String myid;
	private int auth;
	private String filename;
	private String newfilename;
	
	
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getNewfilename() {
		return newfilename;
	}
	public void setNewfilename(String newfilename) {
		this.newfilename = newfilename;
	}
	public int getAuth() {
		return auth;
	}
	public void setAuth(int auth) {
		this.auth = auth;
	}
	public String getMyid() {
		return myid;
	}
	public void setMyid(String myid) {
		this.myid = myid;
	}
	public String getIssale() {
		return issale;
	}
	public void setIssale(String issale) {
		this.issale = issale;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getClassify() {
		return classify;
	}
	public void setClassify(String classify) {
		this.classify = classify;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getPhone() {
		return phone;
	}
	public void setPhone(int phone) {
		this.phone = phone;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	
	
	public MemberVo(String name, String classify, String email, int phone, String pwd, String issale, String myid) {
		super();
		this.name = name;
		this.classify = classify;
		this.email = email;
		this.phone = phone;
		this.pwd = pwd;
		this.issale = issale;
		this.myid = myid;
	}
	
	
	
	@Override
	public String toString() {
		return "MemberVo [name=" + name + ", classify=" + classify + ", email=" + email + ", phone=" + phone + ", pwd="
				+ pwd + ", issale=" + issale + ", myid=" + myid + ", auth=" + auth + ", filename=" + filename
				+ ", newfilename=" + newfilename + "]";
	}
	public MemberVo() {
		// TODO Auto-generated constructor stub
	}
}
