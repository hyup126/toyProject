package egovframework.example.board.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.example.board.service.MemBoardService;
import egovframework.example.board.service.MemBoardVO;
import egovframework.example.login.service.MemberService;
import egovframework.example.login.service.MemberVO;
import egovframework.example.login.service.impl.CustomUserDetailsService;
import egovframework.example.login.service.impl.MemberMapper;
import egovframework.example.reply.service.ReplyVO;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping(value="/board")
public class MemBoardController {

	private static final Logger log = LoggerFactory.getLogger(MemBoardController.class);
	
	@Autowired
	private MemBoardService memBoardService;
	@Autowired
	private MemberService memService;
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	@RequestMapping(value = "/memBoardWrite.do")
	public String memBoardWrite() {
		
		return "memBoard/memBoardWrite";
	}
	
	@RequestMapping(value = "/memBoardSave.do")
	public String memBoardSave(MemBoardVO memBoardVo, Model model) {
		
		int res = memBoardService.insertBoard(memBoardVo);
		if(res > 0) {
			System.out.println("등록완료");
		} else {
			System.out.println("등록실패");
		}
		
		model.addAttribute("memBoard", memBoardVo);
		log.info("memBoardVo : " + memBoardVo);
		
		return "redirect:/board/memBoardList.do";
	}
	
	@RequestMapping(value = "/memBoardList.do")
	public String memBoardList(@ModelAttribute("searchVo") SampleDefaultVO searchVo, Model model, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String memId = (String)session.getAttribute("memId");
		
		if(memId == null || memId == "") {
			return "/login.do";
		}
		
		
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
		
		List<?> memBoardList = memBoardService.selectMemBoardList(searchVo);
		log.info("리스트 : " + memBoardList);
		int totCnt = memBoardService.selectMemBoardListTotCnt(searchVo);
		paginationInfo.setTotalRecordCount(totCnt);
		boolean hasNext = (paginationInfo.getTotalRecordCount() > paginationInfo.getLastRecordIndex());
		model.addAttribute("hasNext", hasNext);
		model.addAttribute("paginationInfo", paginationInfo);
		log.info("paginationInfo : " + paginationInfo);
		model.addAttribute("memBoardList", memBoardList);
		
		return "memBoard/memBoardList";
	}
	
	@RequestMapping(value = "/memBoardDetail.do")
	public String memBoardDetail(int memBoardNo, Model model) {
		
		MemBoardVO memBoardVo = memBoardService.selectMemBoardDetail(memBoardNo);
		List<ReplyVO> replyList = memBoardService.selectReplyList(memBoardNo);
		log.info("replyList : " + replyList);
		
		model.addAttribute("memBoard", memBoardVo);
		model.addAttribute("replyList", replyList);
		
		return "memBoard/memBoardDetail";
	}
	
	@RequestMapping(value = "/memBoardModify.do")
	public String memBoardModify(int memBoardNo, Model model) throws Exception {
		MemBoardVO memBoardVo = memBoardService.selectMemBoardDetail(memBoardNo);
		
		model.addAttribute("memBoard", memBoardVo);
		
		return "memBoard/memBoardModify";
	}
	
	@RequestMapping(value = "/memBoardUpdate.do", method = RequestMethod.POST)
	public String memBoardUpdate(MemBoardVO memBoardVo, Model model) throws Exception {
			System.out.println("시발롬들아");
			log.info("String");
			log.info("memBoardVo: " + memBoardVo.getMemBoardTitle());
	        int res = memBoardService.updateBoard(memBoardVo);

	        if (res > 0) {
	            log.info("수정 성공");
	        } else {
	            log.info("수정 실패");
	        }
	        
	    return "redirect:/board/memBoardDetail.do?memBoardNo=" + memBoardVo.getMemBoardNo();
	}
	
	@RequestMapping(value = "/memBoardDelete.do")
	public String memBoardDelete(int memBoardNo) throws Exception {
		
		int res = memBoardService.memBoardDelete(memBoardNo);
		
		if(res > 0) {
			log.info("삭제 성공");
		} else {
			log.info("삭제 실패");
		}
		
		return "redirect:/board/memBoardList.do";
		
	}
	
	
}
