package www.silver.hom;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import www.silver.service.FileService;
import www.silver.util.PassportPhotoValidator;
import www.silver.vo.FileAttachVO;

@Controller
public class FileController {
    
	@Autowired
    private PassportPhotoValidator photoValidator;
	
    @Autowired
    private FileService fileService;
    
    @Autowired
    private ServletContext servletContext;
    
    @RequestMapping(value = "/upload", method = RequestMethod.GET)
    public String uploadForm() {
        return "/common/upload";
    }
    
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    public String uploadFile(@RequestParam("files") MultipartFile[] files,
                           RedirectAttributes rttr) {
        
        // 업로드 경로 설정
        String realPath = servletContext.getRealPath("/resources/upload");
        File uploadPath = new File(realPath, getDateFolder());
        
        if (!uploadPath.exists()) {
            uploadPath.mkdirs();
        }
        
        try {
            for (MultipartFile file : files) {
                if (file.isEmpty()) {
                    continue;
                }
                
                String originalFilename = file.getOriginalFilename();
                String uuid = UUID.randomUUID().toString();
                String uploadFilename = uuid + "_" + originalFilename;
                
                // 파일 저장
                file.transferTo(new File(uploadPath, uploadFilename));
                
                // DB에 파일 정보 저장
                FileAttachVO attachVO = new FileAttachVO();
                attachVO.setUuid(uuid);
                attachVO.setUploadPath(getDateFolder());
                attachVO.setFilename(originalFilename);
                attachVO.setFiletype(file.getContentType());
                attachVO.setFileSize(file.getSize());
                
                fileService.insertFile(attachVO);
            }
            
            rttr.addFlashAttribute("message", "파일 업로드가 완료되었습니다.");
            
        } catch (Exception e) {
            e.printStackTrace();
            rttr.addFlashAttribute("message", "파일 업로드 중 오류가 발생했습니다.");
        }
        
        return "redirect:/files";
    }
    
    @RequestMapping(value = "/files", method = RequestMethod.GET)
    public String fileList(Model model) {
        List<FileAttachVO> files = fileService.getFileList();
        model.addAttribute("files", files);
        return "/common/fileList";
    }
    

    
    private String getDateFolder() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
        Date date = new Date();
        return sdf.format(date);
    }
}
