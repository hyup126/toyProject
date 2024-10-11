package egovframework.example.login.service.impl;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.request;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import egovframework.example.login.service.MemberVO;
import egovframework.example.login.web.LoginController;
import egovframework.rte.fdl.cryptography.EgovEnvCryptoService;
import sun.rmi.runtime.Log;

@Service
public class CustomUserDetailsService implements UserDetailsService{
	
	private static final Logger log = LoggerFactory.getLogger(LoginController.class);
	@Autowired
	private EgovEnvCryptoService cryptoService;
	@Autowired
	private MemberMapper memberMapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		System.out.println(username);
		
        MemberVO memVO = memberMapper.detail(username);
        String pass = cryptoService.decrypt(memVO.getMemPass());
        memVO.setMemPass(pass);
		log.info("제발 해주세요 : " + pass);
        log.info("memVO :", memVO);
        log.info("memVO : "+ memVO);

        if (memVO == null) {
            throw new UsernameNotFoundException("사용자를 찾을 수 없습니다: " + username);
        }

        
        
        
        // CustomUser로 리턴
        return new CustomUser(memVO);
    }
    
    
    
}
	

	
	


