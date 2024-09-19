package egovframework.example.login.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.example.login.service.MemberService;
import egovframework.example.login.service.MemberVO;
import egovframework.example.login.service.impl.CustomUserDetailsService;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.rte.fdl.cryptography.EgovEnvCryptoService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class LoginController {

	private static final Logger log = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	private CustomUserDetailsService userService;
	@Autowired
	private EgovEnvCryptoService cryptoService;
	@Autowired
	private MemberService memService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	@GetMapping("/login.do")
	public String login() {
		
		return "join/login";
	}
	
	@RequestMapping(value = "/loginSave.do")
	public String loginSave(MemberVO memVo) {
		
		userService.loadUserByUsername(memVo.getUsername());
		
		log.info("아이디 : " + memVo.getMemId());
		
		return "memBoard/memBoardList";
	}
	
	@RequestMapping(value = "/join.do")
	public String join() {
		
		return "join/join";
	}
	
	@RequestMapping(value = "/joinSave.do")
	public String joinSave(MemberVO memVo, Model model) throws Exception {
		log.info("memberVo : " + memVo.getMemEmail());
		log.info("memberVo : " + memVo);
		
		// 암호화
		
		String pass = cryptoService.encrypt(memVo.getMemPass());
		System.out.println("pass :: " +pass);
		memVo.setMemPass(pass);
		log.info("제발 돼주세요 : " + pass);
		int res = memService.insertMember(memVo);
		
		if(res > 0) {
			System.out.println("등록성공");
		} else {
			System.out.println("등록실패");
		}
		
		model.addAttribute("memVo", memVo);
		
		return "memBoard/memBoardList";
		
	}
	
	@RequestMapping("/boardList.do")
	public String boardList(@ModelAttribute("searchVo") SampleDefaultVO searchVo, Model model) {
		
		searchVo.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVo.setPageSize(propertiesService.getInt("pageSize"));
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVo.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVo.getPageUnit());
		paginationInfo.setPageSize(searchVo.getPageSize());

		searchVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVo.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<?> memBoardList = memService.selectMemberBoardList(searchVo);
		log.info("리스트 : " + memBoardList);
		int totCnt = memService.selectMemberListTotCnt(searchVo);
		paginationInfo.setTotalRecordCount(totCnt);
		boolean hasNext = (paginationInfo.getTotalRecordCount() > paginationInfo.getLastRecordIndex());
		model.addAttribute("hasNext", hasNext);
		model.addAttribute("paginationInfo", paginationInfo);
		log.info("paginationInfo : " + paginationInfo);
		model.addAttribute("memBoardList", memBoardList);
		
		return "board/boardList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/idCheck.do", method = RequestMethod.POST)
	public String idCheck(@RequestParam("memId") String memId) throws Exception {
		String message = "";
		
		MemberVO result = memService.idCheck(memId);
		log.info("result : " + result);
		log.info("memId : " + memId);
		
		if(result == null) {
			message = "ok";
		} else {
			message = "fail";
		}
		
		log.info("message : " + message);
		
		return message;
	}
	
	@RequestMapping(value = "/logout")
	public String logout() {
		return "join/logout";
	}
	
}
