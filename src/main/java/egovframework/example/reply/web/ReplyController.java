package egovframework.example.reply.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.example.board.service.MemBoardService;
import egovframework.example.login.service.MemberService;
import egovframework.example.reply.service.ReplyService;
import egovframework.example.reply.service.ReplyVO;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
@RequestMapping("/board")
public class ReplyController {

	@Autowired
	private ReplyService replyService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	
}
