package com.mkw.a.domain;

import java.io.Serializable;

public class BbsParam implements Serializable{

	private int pnum;
	private String search;
	private String title;
	private int start; 
	private int end;
	
	
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getEnd() {
		return end;
	}
	public void setEnd(int end) {
		this.end = end;
	}
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	public String getSearch() {
		return search;
	}
	public void setSearch(String search) {
		this.search = search;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	public BbsParam() {
		// TODO Auto-generated constructor stub
	}
	
	@Override
	public String toString() {
		return "BbsParam [pnum=" + pnum + ", search=" + search + ", title=" + title + ", start=" + start + ", end="
				+ end + "]";
	}
	public BbsParam(int pnum, String search, String title) {
		super();
		this.pnum = pnum;
		this.search = search;
		this.title = title;
	}
	
	
}
