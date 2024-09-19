package egovframework.example.login.service;

import java.util.List;

import egovframework.example.sample.service.SampleDefaultVO;

public interface MemberService {

	public MemberVO detail(String memId);

	public int insertMember(MemberVO memVo);

	// 중복 아이디 체크
	public MemberVO idCheck(String memId) throws Exception;

	public List<?> selectMemberBoardList(SampleDefaultVO searchVo);

	public int selectMemberListTotCnt(SampleDefaultVO searchVo);


}
