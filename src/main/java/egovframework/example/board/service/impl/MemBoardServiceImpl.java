package egovframework.example.board.service.impl;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.board.service.ComntFileDetailVO;
import egovframework.example.board.service.MemBoardService;
import egovframework.example.board.service.MemBoardVO;
import egovframework.example.reply.service.ReplyVO;
import egovframework.example.sample.service.SampleDefaultVO;

@Service
public class MemBoardServiceImpl implements MemBoardService {

	@Autowired 
	MemBoardMapper memBoardMapper;
	
	@Override
	public int insertBoard(MemBoardVO memBoardVo) {
		return memBoardMapper.insertBoard(memBoardVo);
	}

	@Override
	public List<MemBoardVO> selectMemBoardList(SampleDefaultVO searchVo) {
		return memBoardMapper.selectMemBoardList(searchVo);
	}

	@Override
	public int selectMemBoardListTotCnt(SampleDefaultVO searchVo) {
		return memBoardMapper.selectMemBoardListTotCnt(searchVo);
	}

	@Override
	public MemBoardVO selectMemBoardDetail(int memBoardNo) {
		memBoardMapper.incrementHit(memBoardNo);
		return memBoardMapper.selectMemBoardDetail(memBoardNo);
	}

	@Override
	public int updateBoard(MemBoardVO memBoardVo) throws Exception {
		return memBoardMapper.updateBoard(memBoardVo);
	}

	@Override
	public MemBoardVO selectMemBoardModify(int memBoardNo) {
		return memBoardMapper.selectMemBoardModify(memBoardNo);
	}

	@Override
	public int memBoardDelete(int memBoardNo) throws Exception {
		return memBoardMapper.memBoardDelete(memBoardNo);
	}

	@Override
	public List<ReplyVO> selectReplyList(int memBoardNo) {
		return memBoardMapper.selectReplyList(memBoardNo);
	}

	@Override
	public void saveFileDetails(ComntFileDetailVO comntFileDetailVo) {
		memBoardMapper.saveFileDetails(comntFileDetailVo);
	}

	@Override
	public ComntFileDetailVO selectMemBoardFile(String atchFileId) {
		return memBoardMapper.selectMemBoardFile(atchFileId);
	}

	@Override
	public void deleteMemBoardFile(String atchFileId) {
		memBoardMapper.deleteMemBoardFile(atchFileId);
	}

	@Override
	public void memBoardFileDelete(int memBoardNo) {
		memBoardMapper.memBoardFileDelete(memBoardNo);
	}

	@Override
	public ComntFileDetailVO selectFileInfo(String atchFileId) {
		return memBoardMapper.selectFileInfo(atchFileId);
	}

	@Override
	public void memReplyDelete(int memBoardNo) {
		memBoardMapper.memReplyDelete(memBoardNo);
	}

	@Override
	public List<ComntFileDetailVO> getFilePaths(int memBoardNo) {
		return memBoardMapper.getFilePaths(memBoardNo);
	}

	@Override
	public int selectCountReply(int memBoardNo) {
		return memBoardMapper.selectCountReply(memBoardNo);
	}

}
