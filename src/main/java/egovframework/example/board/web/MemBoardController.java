package egovframework.example.board.web;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.example.board.service.ComntFileDetailVO;
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
	
	@Resource(name = "multipartResolver")
	CommonsMultipartResolver multipartResolver;
	
	@Resource(name = "uploadPath")
	private String resourcePath;
	
	@RequestMapping(value = "/memBoardWrite.do")
	public String memBoardWrite() {
		
		return "memBoard/memBoardWrite";
	}
	
//	@RequestMapping(value = "/memBoardSave.do")
//	public String memBoardSave(MemBoardVO memBoardVo, Model model, MultipartFile[] memBoardFile) {
//		System.out.println("memBoardFile" + memBoardFile);
//		for (MultipartFile multipart : memBoardFile) {
//		    if (!multipart.isEmpty()) {
//		        String fileName = UUID.randomUUID().toString() + "_" + multipart.getOriginalFilename(); // 파일 이름을 랜덤 + 원래 파일명 조합
//		        String filePath = "C:\\data\\upload\\";
//		        
//		        try {
//		            multipart.transferTo(new File(filePath, fileName)); // 파일 저장
//		            log.info("Uploaded file: " + fileName);
//		        } catch (IOException e) {
//		            log.error("File upload error: " + e.getMessage());
//		        }
//		    }
//		}
//		for(int i =0; i <memBoardFile.length; i++) {
//			System.out.println("memBoardFile!!!!!!!!!!!!!!!!!!!!");
//			log.info("memBoardFile"+ i);
//		}
//		
//		
////for (MultipartFile multipart : memBoardFile) {
////           if (!multipart.isEmpty()) {
////               String fileName = UUID.randomUUID().toString();   //파일이름은 랜덤해야됨. 사용자가올리는 다른 파일이름이 같을 수 있음.
////               String filePath = "C:\\data\\upload\\";
////               //FileUtils.copyInputStreamToFile(multipart.getInputStream(), new File(filePath, fileName));
////               log.info("fileName : " + fileName);
////               log.info("filePath : " + filePath);
////               // 여기서 실제 파일이 저장(regist에서 실행됬다), inputStream을 file로 변환하는 메소드
////               multipart.transferTo(new File(filePath, fileName)); // 비슷한 역할
////           }
////  	}
//		 
//		
//		int res = memBoardService.insertBoard(memBoardVo);
//		if(res > 0) {
//			System.out.println("등록완료");
//		} else {
//			System.out.println("등록실패");
//		}
//		
//		model.addAttribute("memBoard", memBoardVo);
//		log.info("memBoardVo : " + memBoardVo);
//		
//		return "redirect:/board/memBoardList.do";
//	}
	
	@RequestMapping(value = "/memBoardSave.do", method = RequestMethod.POST)
	@ResponseBody
    public ResponseEntity<Map<String, String>> memBoardSave(MemBoardVO memBoardVo, MultipartFile[] memBoardFile) {
        Map<String, String> response = new HashMap<>();
        
        // 파일 업로드 처리
        if (memBoardFile != null && memBoardFile.length > 0) {
            for (MultipartFile multipart : memBoardFile) {
            	System.out.println("multipart ::" + multipart);
                if (!multipart.isEmpty()) {
                	System.out.println("######## !multipart.isEmpty() 체크!");
                    String fileName = UUID.randomUUID().toString() + "_" + multipart.getOriginalFilename(); // 파일 이름을 랜덤 + 원래 파일명 조합
                    String filePath = "C:\\data\\upload\\"; // 저장할 경로
                    
                    File file = new File(filePath);
    				if(!file.exists()) {
    					file.mkdirs();
    				}
                    
                    ComntFileDetailVO comntFileDetailVo = new ComntFileDetailVO();
                    comntFileDetailVo.setStreFileNm(fileName);
                    comntFileDetailVo.setFileStreCours(filePath);
                    comntFileDetailVo.setOrignlFileNm(multipart.getOriginalFilename());
                    comntFileDetailVo.setFileSize(multipart.getSize());
                    int index = multipart.getOriginalFilename().lastIndexOf(".");
                    
                    if (index > 0) {
                        String extension = multipart.getOriginalFilename().substring(index + 1);
                        if (extension != null && !extension.isEmpty()) {
                            comntFileDetailVo.setFileExtsn(extension);
                            log.info("extension : " + extension);
                        }
                    }
                    
                    
                    log.info("fileName : " + fileName);
                    log.info("filePath : " + filePath);
                    log.info("fileOri : " + multipart.getOriginalFilename());
                    log.info("fileSize : " + multipart.getSize());
                    
                    try {
                        // 파일 저장
                        multipart.transferTo(new File(filePath, fileName));
                        System.out.println("fileName :: " + fileName);
                        memBoardService.saveFileDetails(comntFileDetailVo);
                    } catch (IOException e) {
                        System.out.println("e.getMessage() :: " + e.getMessage());
                        response.put("message", "파일 업로드 오류: " + e.getMessage());
                        return ResponseEntity.status(500).body(response);
                    }
                }
            }
        }

        // 게시물 등록 처리
        int res = memBoardService.insertBoard(memBoardVo);
        if (res > 0) {
            response.put("message", "등록 완료");
        } else {
            response.put("message", "등록 실패");
        }

        log.info("memBoardVo : " + memBoardVo);
        return ResponseEntity.ok(response); // JSON 응답 반환
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
		log.info("totCnt : " + totCnt);
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
