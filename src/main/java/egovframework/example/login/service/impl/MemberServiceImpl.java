package egovframework.example.login.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.login.service.MemberService;
import egovframework.example.login.service.MemberVO;
import egovframework.example.sample.service.SampleDefaultVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired 
	MemberMapper memberMapper;
	
	@Override
	public MemberVO detail(String memId) {
		
		return this.memberMapper.detail(memId);
	}

	@Override
	public int insertMember(MemberVO memVo) {
		return memberMapper.insertMember(memVo);
		
	}

	@Override
	public MemberVO idCheck(String memId) throws Exception {
		return memberMapper.idCheck(memId);
	}

	@Override
	public List<?> selectMemberBoardList(SampleDefaultVO searchVo) {
		return memberMapper.selectMemberBoardList(searchVo);
	}

	@Override
	public int selectMemberListTotCnt(SampleDefaultVO searchVo) {
		return memberMapper.selectMemberListTotCnt(searchVo);
	}

	
}
