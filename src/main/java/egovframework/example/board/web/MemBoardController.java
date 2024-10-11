package egovframework.example.board.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
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
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.logging.log4j.core.pattern.IntegerPatternConverter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Assert;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
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
import egovframework.example.board.service.impl.MemBoardMapper;
import egovframework.example.board.util.MediaUtils;
import egovframework.example.login.service.MemberService;
import egovframework.example.login.service.MemberVO;
import egovframework.example.login.service.impl.CustomUserDetailsService;
import egovframework.example.login.service.impl.MemberMapper;
import egovframework.example.reply.service.ReplyService;
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
	@Autowired
	private ReplyService replyService;
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
	
	@Resource(name = "memBoardMapper")
	private MemBoardMapper memBoardMapper;
	
	@RequestMapping(value = "/memBoardWrite.do")
	public String memBoardWrite(Model model, @ModelAttribute("searchVo") SampleDefaultVO searchVo) {
		
		model.addAttribute("searchKeyword", searchVo.getSearchKeyword());
		model.addAttribute("searchCondition", searchVo.getSearchCondition());
		
		return "memBoard/memBoardWrite";
	}
	@RequestMapping(value = "/memBoardSave.do", method = RequestMethod.POST)
	@ResponseBody
    public ResponseEntity<Map<String, String>> memBoardSave(MemBoardVO memBoardVo, MultipartFile[] memBoardFile) {
        Map<String, String> response = new HashMap<>();
        // 게시물 등록 처리
        int res = memBoardService.insertBoard(memBoardVo);
        if (res > 0) {
            response.put("message", "등록 완료");
        } else {
            response.put("message", "등록 실패");
        }

        log.info("memBoardVo : " + memBoardVo);
        int memBoardNo = memBoardVo.getMemBoardNo();
        log.info("memboardNo : " + memBoardNo);
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
                    comntFileDetailVo.setMemBoardNo(memBoardNo);
                    
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
                    
                    //List<ComntFileDetailVO> memBoardFileList = memBoardVo.getMemBoardFileList();
                    try {
                        // 파일 저장
                        multipart.transferTo(new File(filePath, fileName));
                        System.out.println("fileName :: " + fileName);
                        memBoardService.saveFileDetails(comntFileDetailVo);
                        
                        //memBoardFileUpload(memBoardFileList, memBoardVo.getMemBoardNo(), req);
                    } catch (IOException e) {
                        System.out.println("e.getMessage() :: " + e.getMessage());
                        response.put("message", "파일 업로드 오류: " + e.getMessage());
                        return ResponseEntity.status(500).body(response);
                    }
                }
            }
        }

        return ResponseEntity.ok(response); // JSON 응답 반환
    }
	
	@RequestMapping(value = "/memBoardList.do")
	public String memBoardList(@ModelAttribute("searchVo") SampleDefaultVO searchVo, Model model, @ModelAttribute("replyVo") ReplyVO replyVo, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String memId = (String)session.getAttribute("memId");
		
		if(memId == null || memId == "") {
			return "/login.do";
		}
		
		model.addAttribute("searchCondition", searchVo.getSearchCondition());
	    model.addAttribute("searchKeyword", searchVo.getSearchKeyword());
		
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
		
		
		
		List<MemBoardVO> memBoardList = memBoardService.selectMemBoardList(searchVo);
		int replyCnt = 0;
		for(MemBoardVO memList : memBoardList) {
			replyCnt = memBoardService.selectCountReply(memList.getMemBoardNo());
		}
		
		model.addAttribute("replyCnt", replyCnt);
		log.info("리스트 : " + memBoardList);
		int totCnt = memBoardService.selectMemBoardListTotCnt(searchVo);
		log.info("totCnt : " + totCnt);
		paginationInfo.setTotalRecordCount(totCnt);
		boolean hasNext = (paginationInfo.getTotalRecordCount() > paginationInfo.getLastRecordIndex());
		model.addAttribute("hasNext", hasNext);
		model.addAttribute("paginationInfo", paginationInfo);
		log.info("paginationInfo : " + paginationInfo);
		model.addAttribute("memBoardList", memBoardList);
		model.addAttribute("totCnt", totCnt);
		
		return "memBoard/memBoardList";
	}
	
	@RequestMapping(value = "/memBoardDetail.do")
	public String memBoardDetail(int memBoardNo, Model model, @ModelAttribute("searchVo") SampleDefaultVO searchVo) {
		
		MemBoardVO memBoardVo = memBoardService.selectMemBoardDetail(memBoardNo);
		List<ReplyVO> replyList = memBoardService.selectReplyList(memBoardNo);
		int replyCnt = replyService.selectCountReply(memBoardNo);
		log.info("replyList : " + replyList);
		
		model.addAttribute("memBoard", memBoardVo);
		model.addAttribute("replyList", replyList);
		model.addAttribute("replyCnt", replyCnt);
		model.addAttribute("searchKeyword", searchVo.getSearchKeyword());
		model.addAttribute("searchCondition", searchVo.getSearchCondition());
		
		return "memBoard/memBoardDetail";
	}
	
	@RequestMapping("/showImg.do")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(@RequestParam String fileName, @RequestParam String filePath) {
	    // 파일 이름과 경로 검증
	    if (fileName == null || fileName.isEmpty() || filePath == null || filePath.isEmpty()) {
	        return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	    }

	    // 안전한 파일 경로 설정
	    String safeFilePath = "C:\\data\\upload\\"; // 기본 경로 설정
	    File file = new File(safeFilePath, fileName);

	    // 파일 존재 여부 확인
	    if (!file.exists() || !file.isFile()) {
	        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	    }

	    try {
	        HttpHeaders headers = new HttpHeaders();
	        headers.add("Content-Type", Files.probeContentType(file.toPath()));
	        byte[] fileContent = FileCopyUtils.copyToByteArray(file);
	        return new ResponseEntity<>(fileContent, headers, HttpStatus.OK);
	    } catch (IOException e) {
	        log.error("파일 읽기 오류: " + e.getMessage(), e);
	        return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}
	
//	@GetMapping("/showImg.do")
//	@ResponseBody
//	public ResponseEntity<byte[]> getFile(String fileName,String filePath){	
//		
//		File file = new File(filePath, fileName); // File.separator 사용하지 않음
//		String filePath = "C:" + File.separator + "data" + File.separator + "upload";
//		File file = new File(filePath, fileName);
//	    File file=new File(File.separatorChar +filePath,fileName);
//	    ResponseEntity<byte[]> result=null;
//	    try {
//	        HttpHeaders headers=new HttpHeaders();
//	        headers.add("Content-Type", Files.probeContentType(file.toPath()));
//	        result=new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),headers,HttpStatus.OK );
//	    }catch (IOException e) {
//	        e.printStackTrace();
//	    }
//	    return result;
//	}
	
	@RequestMapping(value = "/memBoardModify.do")
	public String memBoardModify(int memBoardNo, Model model, @ModelAttribute("searchVo") SampleDefaultVO searchVo) throws Exception {
		MemBoardVO memBoardVo = memBoardService.selectMemBoardDetail(memBoardNo);
		
		model.addAttribute("memBoard", memBoardVo);
		model.addAttribute("searchKeyword", searchVo.getSearchKeyword());
		model.addAttribute("searchCondition", searchVo.getSearchCondition());
		
		return "memBoard/memBoardModify";
	}
	
	@RequestMapping(value = "/memBoardUpdate.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Map<String, String>> memBoardUpdate(MemBoardVO memBoardVo, MultipartFile[] memBoardFile) throws Exception {
	    Map<String, String> response = new HashMap<>();
	    
	    log.info("memBoardVo : " + memBoardVo);
	    int memBoardNo = memBoardVo.getMemBoardNo();
	    log.info("memBoardNo : " + memBoardNo);
	    
	    
	    // 파일 업로드 처리
	    if (memBoardFile != null && memBoardFile.length > 0) {
	        for (MultipartFile multipart : memBoardFile) {
	            System.out.println("multipart ::" + multipart);
	            if (!multipart.isEmpty()) {
	                System.out.println("######## !multipart.isEmpty() 체크!");
	                String fileName = UUID.randomUUID().toString() + "_" + multipart.getOriginalFilename(); // 파일 이름을 랜덤 + 원래 파일명 조합
	                String filePath = "C:/data/upload/"; // 저장할 경로
	                
	                File file = new File(filePath);
	                if (!file.exists()) {
	                    file.mkdirs();
	                }
	                
	                ComntFileDetailVO comntFileDetailVo = new ComntFileDetailVO();
	                comntFileDetailVo.setStreFileNm(fileName);
	                comntFileDetailVo.setFileStreCours(filePath);
	                comntFileDetailVo.setOrignlFileNm(multipart.getOriginalFilename());
	                comntFileDetailVo.setFileSize(multipart.getSize());
	                comntFileDetailVo.setMemBoardNo(memBoardNo);
	                
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
	            // 게시물 수정 처리
	        }
	    }
	    int res = memBoardService.updateBoard(memBoardVo);
	    if (res > 0) {
	    	response.put("message", "수정 완료");
	    } else {
	    	response.put("message", "수정 실패");
	    }

	    return ResponseEntity.ok(response); // JSON 응답 반환
	}
	
	@RequestMapping(value = "/memBoardFileDelete.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Map<String, String>> deleteFile(String atchFileId) {
	    Map<String, String> response = new HashMap<>();
	    
	    if (atchFileId == null || atchFileId.isEmpty()) {
	        response.put("message", "파일 ID가 전달되지 않았습니다.");
	        return ResponseEntity.badRequest().body(response);
	    }
	    
	    try {
	        // 파일 정보를 조회
	        ComntFileDetailVO fileDetail = memBoardService.selectMemBoardFile(atchFileId); // atchFileId로 조회
	        if (fileDetail != null) {
	            // 파일 삭제를 위한 경로 생성
	            String filePath = fileDetail.getFileStreCours() + fileDetail.getStreFileNm();
	            File fileToDelete = new File(filePath);
	            
	            // 파일 삭제 시도
	            if (fileToDelete.exists() && fileToDelete.delete()) {
	                // DB에서 파일 정보 삭제
	                memBoardService.deleteMemBoardFile(atchFileId); // atchFileId로 삭제
	                response.put("atchFileId", atchFileId);
	                response.put("message", "파일 삭제 완료");
	            } else {
	                response.put("message", "파일 삭제 실패: 파일이 존재하지 않거나 접근할 수 없습니다.");
	            }
	        } else {
	            response.put("message", "파일이 존재하지 않습니다.");
	        }
	    } catch (Exception e) {
	        response.put("message", "오류 발생: " + e.getMessage());
	        log.error("오류 발생: " + e.getMessage(), e); // 오류 발생 시 로그 레벨을 error로 변경
	    }

	    return ResponseEntity.ok(response);
	}
	
//	@RequestMapping(value = "/memBoardUpdate.do", method = RequestMethod.POST)
//	public String memBoardUpdate(MemBoardVO memBoardVo, Model model) throws Exception {
//			log.info("String");
//			log.info("memBoardVo: " + memBoardVo.getMemBoardTitle());
//	        int res = memBoardService.updateBoard(memBoardVo);
//
//	        if (res > 0) {
//	            log.info("수정 성공");
//	        } else {
//	            log.info("수정 실패");
//	        }
//	        
//	    return "redirect:/board/memBoardDetail.do?memBoardNo=" + memBoardVo.getMemBoardNo();
//	}
	
	@ResponseBody
	@RequestMapping(value = "/memBoardDelete.do")
	public ResponseEntity<Map<String, String>> memBoardDelete(int memBoardNo) throws Exception { // int 대신 Integer 사용
	    System.out.println("memBoardNo : " + memBoardNo);
	    
	    Map<String, String> response = new HashMap<String, String>();
	    
	    // memBoardNo가 null인지 체크
	    if (memBoardNo == 0) {
	        return ResponseEntity.badRequest().body(response);
	    }
	    
	    // 게시글의 파일 경로를 가져온다.
	    List<ComntFileDetailVO> fileDetails = memBoardService.getFilePaths(memBoardNo);
	    
	    memBoardService.memReplyDelete(memBoardNo);
	    
	    // 게시글 관련 파일 삭제
	    for (ComntFileDetailVO fileDetail : fileDetails) {
	        String filePath = fileDetail.getFileStreCours() + fileDetail.getStreFileNm(); // 파일 경로 가져오기
	        log.info(filePath);
	        File file = new File(filePath);
	        if (file.exists()) {
	            file.delete(); // 파일 삭제
	        }
	    }
	    
	    memBoardService.memBoardFileDelete(memBoardNo);
	    
	    int res = memBoardService.memBoardDelete(memBoardNo);
	    
	    if (res > 0) {
	        response.put("message", "삭제 성공");
	    } else {
	        response.put("message", "삭제 실패");
	    }
	    
	    return ResponseEntity.ok(response); // JSON 응답 반환
	}
	
	@RequestMapping(value="/download.do") //글 리스트 페이지
	public void fileDown(@RequestParam("orignlFileNm")String orignlFileNm, @RequestParam("streFileNm")String streFileNm, HttpServletRequest request, HttpServletResponse response) throws Exception {
	  ComntFileDetailVO fileVO = new ComntFileDetailVO();
	  fileVO.setOrignlFileNm(orignlFileNm);;
	  fileVO.setStreFileNm(streFileNm);;
	  MediaUtils.fileDownload(fileVO, request, response);
	}
	
//	@RequestMapping(value= "/download.do")
//	public ResponseEntity<byte[]> fileDownload(@RequestParam("fileId") String atchFileId) throws Exception {
//		InputStream in = null;
//		ResponseEntity<byte[]> entity = null;
//		
//		String fileName = null;
//		ComntFileDetailVO comntFileVo = memBoardService.selectFileInfo(atchFileId);
//		
//		if(comntFileVo != null) {
//			fileName = comntFileVo.getStreFileNm();
//			
//			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
//			MediaType mType = MediaUtils.getMediaType(formatName);
//			HttpHeaders headers = new HttpHeaders();
//			
//			String filePath = comntFileVo.getFileStreCours().replace("/", "\\"); // 모든 슬래시를 백슬래시로 변환
//			in = new FileInputStream(filePath);
//			
//			fileName = fileName.substring(fileName.indexOf("_"));
//			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
//			headers.add("Content-Disposition", "attachment; filename=\""+ new String(fileName.getBytes("UTF-8"), "ISO-8859-1") + "\"");
//			
//			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
//		} else {
//			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
//		}
//		return entity;
//	}
	
	
}
