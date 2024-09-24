package egovframework.example.reply.web;

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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
		log.info("쓰레기같은놈들아");
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
	
	@RequestMapping(value = "/updateReply.do")
	public Map<String, Object> updateReply(ReplyVO replyVo, int memBoardNo) {
		Map<String, Object> response = new HashMap<String, Object>();
		
		int res = replyService.updateReply(replyVo);
		if(res > 0) {
			log.info("수정 성공");
			response.put("status", "success");
	        response.put("message", "댓글이 성공적으로 삭제되었습니다.");
	        response.put("redirectUrl", "/board/memBoardDetail.do?memBoardNo=" + memBoardNo);
		} else {
			log.info("수정 실패");
			response.put("status", "success");
	        response.put("message", "댓글이 성공적으로 삭제되었습니다.");
	        response.put("redirectUrl", "/board/memBoardDetail.do?memBoardNo=" + memBoardNo);
		}
		
		response.put("memBoardNo", memBoardNo); // memBoardNo를 응답에 추가
		
		return response;
	}
	
	@RequestMapping(value = "/deleteReply.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteReply(int replyNo, int memBoardNo) {
	    Map<String, Object> response = new HashMap<>();

	    int res = replyService.deleteReply(replyNo);
	    
	    if (res > 0) {
	        log.info("삭제 성공");
	        response.put("status", "success");
	        response.put("message", "댓글이 성공적으로 삭제되었습니다.");
	        response.put("redirectUrl", "/board/memBoardDetail.do?memBoardNo=" + memBoardNo);
	    } else {
	        log.info("삭제 실패");
	        response.put("status", "fail");
	        response.put("message", "댓글 삭제에 실패하였습니다.");
	    }

	    response.put("memBoardNo", memBoardNo); // memBoardNo를 응답에 추가
	    return response;
	}
	
}
