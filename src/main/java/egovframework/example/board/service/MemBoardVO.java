package egovframework.example.board.service;

import java.util.Date;

public class MemBoardVO {

	private int memBoardNo;
	private String memBoardTitle;
	private String memBoardWriter;
	private String memBoardContent;
	private Date regDate;
	private Date updateDate;
	private char delYn;
	private int memBoardHit;
	
	public int getMemBoardNo() {
		return memBoardNo;
	}
	public void setMemBoardNo(int memBoardNo) {
		this.memBoardNo = memBoardNo;
	}
	public String getMemBoardTitle() {
		return memBoardTitle;
	}
	public void setMemBoardTitle(String memBoardTitle) {
		this.memBoardTitle = memBoardTitle;
	}
	public String getMemBoardWriter() {
		return memBoardWriter;
	}
	public void setMemBoardWriter(String memBoardWriter) {
		this.memBoardWriter = memBoardWriter;
	}
	public String getMemBoardContent() {
		return memBoardContent;
	}
	public void setMemBoardContent(String memBoardContent) {
		this.memBoardContent = memBoardContent;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	public char getDelYn() {
		return delYn;
	}
	public void setDelYn(char delYn) {
		this.delYn = delYn;
	}
	public int getMemBoardHit() {
		return memBoardHit;
	}
	public void setMemBoardHit(int memBoardHit) {
		this.memBoardHit = memBoardHit;
	}
	
}
