package egovframework.example.board.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

public class MemBoardVO {

	private int memBoardNo;
	private String memBoardTitle;
	private String memBoardWriter;
	private String memBoardContent;
	private Date regDate;
	private Date updateDate;
	private char delYn;
	private int memBoardHit;
	// 이미지 저장
	private MultipartFile picture;
	private MultipartFile[] memBoardFile;
	private List<ComntFileDetailVO> memBoardFileList;
	
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
	public MultipartFile getPicture() {
		return picture;
	}
	public void setPicture(MultipartFile picture) {
		this.picture = picture;
	}
	public MultipartFile[] getMemBoardFile() {
		return memBoardFile;
	}
	public void setMemBoardFile(MultipartFile[] memBoardFile) {
		this.memBoardFile = memBoardFile;
	}
	public List<ComntFileDetailVO> getMemBoardFileList() {
		return memBoardFileList;
	}
	public void setMemBoardFileList(List<ComntFileDetailVO> memBoardFileList) {
		this.memBoardFileList = memBoardFileList;
	}
	
//	public void memBoardFile(MultipartFile[] memBoardFile) {
//		this.memBoardFile = memBoardFile;
//		if(memBoardFile != null) {
//			List<ComntFileDetailVO> memBoardFileList = new ArrayList<ComntFileDetailVO>();
//			for(MultipartFile item : memBoardFile) {
//				if(StringUtils.isBlank(item.getOriginalFilename())) {
//					continue;
//				}
//				ComntFileDetailVO comntFileDetailVO = new ComntFileDetailVO(item);
//				memBoardFileList.add(comntFileDetailVO);
//			}
//			this.memBoardFileList = memBoardFileList;
//		}
//	}
	
}
