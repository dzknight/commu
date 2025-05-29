package www.silver.hom;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MyController {
	
	@Resource(name="cname")  // 컨테이너에서 name 값을 주입받는다.
	String name;  // name은 null이 아닌 컨테이너 객체의 주소 < DI 주입
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		System.out.println("Name : "+name);
		return "index";
	}	

}
