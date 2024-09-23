package egovframework.example.board.service;

import java.util.List;

import egovframework.example.reply.service.ReplyVO;
import egovframework.example.sample.service.SampleDefaultVO;

public interface MemBoardService {

	public int insertBoard(MemBoardVO memBoardVo);

	public List<?> selectMemBoardList(SampleDefaultVO searchVo);

	public int selectMemBoardListTotCnt(SampleDefaultVO searchVo);

	public MemBoardVO selectMemBoardDetail(int memBoardNo);

	public int updateBoard(MemBoardVO memBoardVo) throws Exception;

	public MemBoardVO selectMemBoardModify(int memBoardNo);

	public int memBoardDelete(int memBoardNo) throws Exception;

	public List<ReplyVO> selectReplyList(int memBoardNo);

}
