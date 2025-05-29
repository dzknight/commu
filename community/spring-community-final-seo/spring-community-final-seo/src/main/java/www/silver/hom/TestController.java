package www.silver.hom;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import www.silver.service.TestService;

@Controller
public class TestController {

    private final TestService testService;

    @Autowired
    public TestController(TestService testService) {
        this.testService = testService;
    }

    @GetMapping("/s3test")
    public String s3TestForm() {
        return "/s3/s3TestForm"; // s3TestForm.jsp
    }

    @PostMapping("/s3test/upload")
    public String s3Upload(@RequestParam("file") MultipartFile file, Model model) {
        if (file.isEmpty()) {
            model.addAttribute("errorMessage", "파일을 선택해주세요.");
            return "/s3/s3TestForm";
        }

        try {
            String uploadedFileUrl = testService.uploadImageAndSavePath(file);
            model.addAttribute("successMessage", "파일이 성공적으로 업로드되었습니다.");
            model.addAttribute("uploadedFileUrl", uploadedFileUrl);
            model.addAttribute("originalFileName", file.getOriginalFilename());
        } catch (IOException e) {
            model.addAttribute("errorMessage", "파일 업로드 실패: " + e.getMessage());
        }
        return "/s3/s3TestResult"; // s3TestResult.jsp
    }
}