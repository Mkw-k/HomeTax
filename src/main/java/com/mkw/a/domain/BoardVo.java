package com.mkw.a.domain;

import java.util.Date;

public class BoardVo {
	
	int seq, cnt;
	String title, writer, content;
	Date regdate;
	
	public BoardVo() {
		// TODO Auto-generated constructor stub
	}
	
	
	
	public BoardVo(int seq, int cnt, String title, String writer, String content, Date regdate) {
		super();
		this.seq = seq;
		this.cnt = cnt;
		this.title = title;
		this.writer = writer;
		this.content = content;
		this.regdate = regdate;
	}



	@Override
	public String toString() {
		return "BoardVo [seq=" + seq + ", cnt=" + cnt + ", title=" + title + ", writer=" + writer + ", content="
				+ content + ", regdate=" + regdate + "]";
	}



	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
}
