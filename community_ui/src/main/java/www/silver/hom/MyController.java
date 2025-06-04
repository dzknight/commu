package www.silver.hom;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MyController {
	@Resource(name = "cname") // 컨테이너로부터 주입 받는다
	String name; //값이 null이 아닌 주입받은 객체의 주소 < DI개념
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	//@ResponseBody // 메서드의 반환값을 HTTP 응답 본문에 직접 작성 (뷰를 렌더링하지 않음)
	public String home() {
		System.out.println("Name: " + name);
		// @ResponseBody가 적용되었으므로 "index"가 뷰 이름이 아니라 응답 본문에 직접 출력됨
		// 만약 @ResponseBody가 없고 ViewResolver가 설정되어 있다면, "index"는 "index.jsp" 같은 뷰 파일을 가리킴
		return "index"; // ResponseBody가 있을 때 HTTP 응답 본문에 "index" 문자열이 반환됨, 일반적으로 return 다음에 오는 것은 뷰의 이름을 의미
	}
}
