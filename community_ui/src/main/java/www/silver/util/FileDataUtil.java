package www.silver.util;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


@Controller
public class FileDataUtil {
	
	private ArrayList<String> extNameArray = new ArrayList<String>() 
	{
		{
			add("gif");
			add("jpg");
			add("png");
		}
	};     
	
	
	//dependency injection
	// 컨테이너에 있는 객체의 이름 중에 uploadPath라는 주소를 주입받는다.
	@Resource(name="uploadPath")
	private String uploadPath;
	
	public String getUploadPath() {
		return uploadPath;
	}

	public void setUploadPath(String uploadPath) {
		this.uploadPath = uploadPath;
	}

	
	@RequestMapping(value="/download", method=RequestMethod.GET) //mapping
	@ResponseBody  // return type이 view가 아닌 return type 그 자체로 응답 return type이 파일 시스템(바이너리 파일)
	public FileSystemResource fileDownload(@RequestParam("filename") String fileName, HttpServletResponse response) {
		File file = new File(uploadPath + "/" + fileName);
		response.setContentType("application/download; utf-8");
		response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
		return new FileSystemResource(file);
	}
	
	// 메서드를 분석할 때는 매개변수와 리턴값만 이해하면 사용 가능
	public List<String> fileUpload(MultipartFile[] file) throws IOException {
		List<String> files = new ArrayList<>();
		for(int i=0; i < file.length; i++) {
			if(file[i].getOriginalFilename()!="") {  
				String originalName = file[i].getOriginalFilename();
				UUID uid = UUID.randomUUID();
				String saveName = uid.toString() + "." + originalName.split("\\.")[1];
				// 
//			String[] files = new String[] {saveName};
				byte[] fileData = file[i].getBytes();
				
				File target = new File(uploadPath, saveName);
				FileCopyUtils.copy(fileData, target);
				files.add(saveName);
			}			
		}		
		return files;
	}

	public ArrayList<String> getExtNameArray() {
		return extNameArray;
	}

	public void setExtNameArray(ArrayList<String> extNameArray) {
		this.extNameArray = extNameArray;
	}
}
