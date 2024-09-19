package egovframework.example.reply.service;

import java.util.Date;

public class ReplyVO {

	private int replyNo;
	private int memBoardNo;
	private String replyWriter;
	private String replyContent;
	private Date replyRegDate;
	
	public int getReplyNo() {
		return replyNo;
	}
	public void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
	}
	public int getMemBoardNo() {
		return memBoardNo;
	}
	public void setMemBoardNo(int memBoardNo) {
		this.memBoardNo = memBoardNo;
	}
	public String getReplyWriter() {
		return replyWriter;
	}
	public void setReplyWriter(String replyWriter) {
		this.replyWriter = replyWriter;
	}
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	public Date getReplyRegDate() {
		return replyRegDate;
	}
	public void setReplyRegDate(Date replyRegDate) {
		this.replyRegDate = replyRegDate;
	}
	
	
	
}
