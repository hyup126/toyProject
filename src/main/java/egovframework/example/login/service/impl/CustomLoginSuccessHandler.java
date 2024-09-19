package egovframework.example.login.service.impl;


import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import egovframework.example.login.web.LoginController;

public class CustomLoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {
	
	private static final Logger log = LoggerFactory.getLogger(LoginController.class);
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication auth) throws ServletException, IOException {

		
		//auth.getPrincipal() : 사용자 정보를 가져옴
	    //시큐리티에서 사용자 정보는 User 클래스의 객체로 저장됨(CustomUser.java를 참고)
		User customUser = (User)auth.getPrincipal();
		
		log.info("username : " + customUser.getUsername());
		
		//auth.getAuthorities -> 권한들(ROLE_MEMBER, ROLE_ADMIN)
		//authority.getAuthority() : ROLE_MEMBER
 		List<String> roleNames = new ArrayList<String>();
		auth.getAuthorities().forEach(authority -> {
			roleNames.add(authority.getAuthority());
		});
		
		log.warn("ROLE_NAMES : " + roleNames);
			
//		if(roleNames.contains("ROLE_MEMBER")) {
//			response.sendRedirect("dashboard");
//			return;
//		}
		
		super.onAuthenticationSuccess(request, response, auth);
	}

}
