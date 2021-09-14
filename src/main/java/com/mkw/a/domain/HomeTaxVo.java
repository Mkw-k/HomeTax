package com.mkw.a.domain;

import java.io.Serializable;

public class HomeTaxVo implements Serializable{

	private String myid;
	private String day; 
	private int water; 
	private int elec; 
	private int gas;
	private int inter;
	private int managerfee;
	private int monthfee; 
	private int totalfee;
	private int restfee;
	private int inputfee;
	private int del;
	private String name;
	private int seq;
	private int overfee;
	private String htcustome;
	
	
	public String getHtcustome() {
		return htcustome;
	}
	public void setHtcustome(String htcustome) {
		this.htcustome = htcustome;
	}
	public int getSEQ() {
		return seq;
	}
	public void setSEQ(int sEQ) {
		seq = sEQ;
	}
	public int getOVERFEE() {
		return overfee;
	}
	public void setOVERFEE(int oVERFEE) {
		overfee = oVERFEE;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getDel() {
		return del;
	}
	public void setDel(int del) {
		this.del = del;
	}
	public String getMyid() {
		return myid;
	}
	public void setMyid(String myid) {
		this.myid = myid;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public int getWater() {
		return water;
	}
	public void setWater(int water) {
		this.water = water;
	}
	public int getElec() {
		return elec;
	}
	public void setElec(int elec) {
		this.elec = elec;
	}
	public int getGas() {
		return gas;
	}
	public void setGas(int gas) {
		this.gas = gas;
	}
	public int getInter() {
		return inter;
	}
	public void setInter(int inter) {
		this.inter = inter;
	}
	public int getManagerfee() {
		return managerfee;
	}
	public void setManagerfee(int managerfee) {
		this.managerfee = managerfee;
	}
	public int getMonthfee() {
		return monthfee;
	}
	public void setMonthfee(int monthfee) {
		this.monthfee = monthfee;
	}
	public int getTotalfee() {
		return totalfee;
	}
	public void setTotalfee(int totalfee) {
		this.totalfee = totalfee;
	}
	public int getRestfee() {
		return restfee;
	}
	public void setRestfee(int restfee) {
		this.restfee = restfee;
	}
	public int getInputfee() {
		return inputfee;
	}
	public void setInputfee(int inputfee) {
		this.inputfee = inputfee;
	}
	
	public HomeTaxVo() {
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "HomeTaxVo [myid=" + myid + ", day=" + day + ", water=" + water + ", elec=" + elec + ", gas=" + gas
				+ ", inter=" + inter + ", managerfee=" + managerfee + ", monthfee=" + monthfee + ", totalfee="
				+ totalfee + ", restfee=" + restfee + ", inputfee=" + inputfee + "]";
	}
	public HomeTaxVo(String myid, String day, int water, int elec, int gas, int inter, int managerfee, int monthfee,
			int totalfee, int restfee, int inputfee) {
		super();
		this.myid = myid;
		this.day = day;
		this.water = water;
		this.elec = elec;
		this.gas = gas;
		this.inter = inter;
		this.managerfee = managerfee;
		this.monthfee = monthfee;
		this.totalfee = totalfee;
		this.restfee = restfee;
		this.inputfee = inputfee;
	}
	
	
	
}
