package com.mkw.a.domain;

public class BbsVo {

	private String title;
	private String content;
	private int readcount;
	private int del;
	private int depth;
	private int ref;
	private String filename;
	private String newfilename;
	private int hometaxbbs_seq;
	private String myid;
	private int downcount;
	
	
	public int getDowncount() {
		return downcount;
	}
	public void setDowncount(int downcount) {
		this.downcount = downcount;
	}
	public String getMyid() {
		return myid;
	}
	public void setMyid(String myid) {
		this.myid = myid;
	}
	
	
	public int getHometaxbbs_seq() {
		return hometaxbbs_seq;
	}
	public void setHometaxbbs_seq(int hometaxbbs_seq) {
		this.hometaxbbs_seq = hometaxbbs_seq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public int getDel() {
		return del;
	}
	public void setDel(int del) {
		this.del = del;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
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
	
	public BbsVo() {
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "BbsVo [title=" + title + ", content=" + content + ", readcount=" + readcount + ", del=" + del
				+ ", depth=" + depth + ", ref=" + ref + ", filename=" + filename + ", newfilename=" + newfilename + "]";
	}
	public BbsVo(String title, String content, int readcount, int del, int depth, int ref, String filename,
			String newfilename) {
		super();
		this.title = title;
		this.content = content;
		this.readcount = readcount;
		this.del = del;
		this.depth = depth;
		this.ref = ref;
		this.filename = filename;
		this.newfilename = newfilename;
	}
	
	
}
