package www.silver.hom;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import www.silver.service.IF_signUpService;
import www.silver.util.HttpConnection;
import www.silver.vo.MemberVO;

@Controller
public class KakaoController {
    
	@Inject
	IF_signUpService memberservice;
    
    private HttpConnection conn = HttpConnection.getInstance();
    
//    @RequestMapping(value = "/get-auth-code", method = RequestMethod.GET)
//    public String kakaoCallback1(@RequestParam String code, HttpSession session) throws Exception {
//        // 1. 인가코드로 액세스 토큰 요청
//        Map<String, String> tokenParams = new HashMap<>();
//        tokenParams.put("grant_type", "authorization_code");
//        tokenParams.put("client_id", "REST_API_KEY"); // 카카오 REST API 키
//        tokenParams.put("redirect_uri", "http://localhost:8090/hom2/");
//        tokenParams.put("code", code);
//        
//        String tokenResponse = conn.HttpPostConnection("https://kauth.kakao.com/oauth/token", tokenParams).toString();
//        
//        // JSON 파싱하여 access_token 추출
//        ObjectMapper mapper = new ObjectMapper();
//        JsonNode tokenJson = mapper.readTree(tokenResponse);
//        String accessToken = tokenJson.get("access_token").asText();
//        
//        // 2. 액세스 토큰으로 사용자 정보 요청
//        Map<String, String> userParams = new HashMap<>();
//        userParams.put("Authorization", "Bearer " + accessToken);
//        
//        String userResponse = conn.HttpPostConnection("https://kapi.kakao.com/v2/user/me", userParams).toString();
//        JsonNode userJson = mapper.readTree(userResponse);
//        
//        // 3. 사용자 정보 추출
//        String snsId = userJson.get("id").asText();
//        String userName = userJson.get("properties").get("nickname").asText();
//        String email = userJson.has("kakao_account") && userJson.get("kakao_account").has("email") 
//                      ? userJson.get("kakao_account").get("email").asText() : "";
//        
//        // 4. 회원가입 또는 로그인 처리
//        return processKakaoLogin(snsId, userName, email, session);
//    }
    
    
  
}