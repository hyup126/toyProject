package egovframework.example.reply.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.reply.service.ReplyService;
import egovframework.example.reply.service.ReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyMapper replyMapper;

	@Override
	public int insertReply(ReplyVO replyVo) {
		return replyMapper.insertReply(replyVo);
	}

	@Override
	public int updateReply(ReplyVO replyVo) {
		return replyMapper.updateReply(replyVo);
	}

	@Override
	public int deleteReply(int replyNo) {
		return replyMapper.deleteReply(replyNo);
	}
	

	
	
}
