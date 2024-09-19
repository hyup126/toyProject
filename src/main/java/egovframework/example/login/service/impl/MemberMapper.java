package egovframework.example.login.service.impl;

import java.util.List;

import egovframework.example.login.service.MemberVO;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("memberMapper")
public interface MemberMapper {

	public MemberVO detail(String memId);

	public int insertMember(MemberVO memVo);

	public MemberVO idCheck(String memId) throws Exception;

	public List<?> selectMemberBoardList(SampleDefaultVO searchVo);

	public int selectMemberListTotCnt(SampleDefaultVO searchVo);
}
