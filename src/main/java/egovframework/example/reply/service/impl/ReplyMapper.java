package egovframework.example.reply.service.impl;

import java.util.List;

import egovframework.example.reply.service.ReplyVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("replyMapper")
public interface ReplyMapper {

	public int insertReply(ReplyVO replyVo);

	public int updateReply(ReplyVO replyVo);

	public int deleteReply(int replyNo);

	public int selectCountReply(int memBoardNo);

}
