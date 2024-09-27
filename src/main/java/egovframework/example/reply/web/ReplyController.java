package egovframework.example.reply.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.example.board.service.MemBoardService;
import egovframework.example.board.service.MemBoardVO;
import egovframework.example.login.service.MemberService;
import egovframework.example.reply.service.ReplyService;
import egovframework.example.reply.service.ReplyVO;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
@RequestMapping("/board")
public class ReplyController {

	private static final Logger log = LoggerFactory.getLogger(ReplyController.class);
	
	@Autowired
	private ReplyService replyService;
	
	@Autowired
	private MemBoardService memBoardService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	@RequestMapping(value= "/insertReply.do")
	public String insertReply(ReplyVO replyVo, int memBoardNo, Model model, HttpServletRequest request) {
		MemBoardVO memBoardVo = memBoardService.selectMemBoardDetail(memBoardNo);
		
		HttpSession session = request.getSession();
		String memId = (String)session.getAttribute("memId");
		replyVo.setReplyWriter(memId);
		
		int res = replyService.insertReply(replyVo);
		
		if(res > 0) {
			log.info("저장 완료");
		} else {
			log.info("저장 실패");
		}
		
		model.addAttribute("memBoardVo", memBoardVo);
		
		return "redirect:/board/memBoardDetail.do?memBoardNo=" + memBoardNo;
		
	}
	@ResponseBody
	@PostMapping(value = "/updateReply.do")
	public Map<String, Object> updateReply(HttpServletRequest request
			, HttpServletResponse response, @RequestBody ReplyVO replyVo) {
		log.info("replyVo ::"+ replyVo.getReplyContent());
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		int res = replyService.updateReply(replyVo);
		if(res == 0) {
			log.info("수정 실패");
			result.put("result", "fail");
			result.put("msg", "수정 실패");
			return result;
		} 
		
		result.put("result", "success");
		result.put("resultData", replyVo);
		
		return result;
	}
	
	@ResponseBody
	@PostMapping(value = "/deleteReply.do")
	public Map<String, Object> deleteReply(@RequestBody Map<String, Integer> request) {
		int replyNo = request.get("replyNo");
		log.info("replyNo : " + replyNo);
	    Map<String, Object> result = new HashMap<>();

	    int res = replyService.deleteReply(replyNo);
	    
	    if(res == 0) {
			log.info("삭제 실패");
			result.put("result", "fail");
			result.put("msg", "삭제 실패");
			return result;
		} 
		
	    result.put("result", "success");
	    result.put("resultNo", "replyNo");
		
		return result;
	}
	
}
