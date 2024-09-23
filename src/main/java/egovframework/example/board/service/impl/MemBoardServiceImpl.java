package egovframework.example.board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public List<?> selectMemBoardList(SampleDefaultVO searchVo) {
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



}
