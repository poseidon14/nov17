package com.poseidon.dto;

public class CommentDTO {
	private int c_no, mno, board_no;
	private String c_comment, c_date, mid;//서브쿼리로 mno알아오게...
	
	public String getC_comment() {
		return c_comment;
	}
	public void setC_comment(String c_comment) {
		this.c_comment = c_comment;
	}
	public String getC_date() {
		return c_date;
	}
	public void setC_date(String c_date) {
		this.c_date = c_date;
	}
	public int getC_no() {
		return c_no;
	}
	public void setC_no(int c_no) {
		this.c_no = c_no;
	}
	public int getMno() {
		return mno;
	}
	public void setMno(int mno) {
		this.mno = mno;
	}
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	
	
}
