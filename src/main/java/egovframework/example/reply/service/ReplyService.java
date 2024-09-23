package egovframework.example.reply.service;

import java.util.List;

public interface ReplyService {

	public int insertReply(ReplyVO replyVo);

	public int updateReply(ReplyVO replyVo);

	public int deleteReply(int replyNo);

}
