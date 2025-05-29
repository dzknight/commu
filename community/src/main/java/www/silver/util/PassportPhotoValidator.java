package www.silver.util;

import java.awt.image.BufferedImage;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class PassportPhotoValidator {
    
    // 여권 사진 규격 상수
    private static final int MIN_WIDTH = 395;
    private static final int MAX_WIDTH = 431;
    private static final int MIN_HEIGHT = 507;
    private static final int MAX_HEIGHT = 550;
    private static final int RECOMMENDED_WIDTH = 413;
    private static final int RECOMMENDED_HEIGHT = 531;
    private static final long MAX_FILE_SIZE = 500 * 1024; // 500KB
    
    public ValidationResult validatePassportPhoto(MultipartFile file) {
        ValidationResult result = new ValidationResult();
        
        try {
            // 파일 크기 검증
            if (file.getSize() > MAX_FILE_SIZE) {
                result.setValid(false);
                result.setMessage("파일 크기는 500KB 이하여야 합니다. 현재 크기: " + 
                    Math.round(file.getSize() / 1024.0) + "KB");
                return result;
            }
            
            // 파일 형식 검증
            String contentType = file.getContentType();
            if (!isValidImageType(contentType)) {
                result.setValid(false);
                result.setMessage("JPG/JPEG 형식만 업로드 가능합니다.");
                return result;
            }
            
            // 이미지 크기 검증
            BufferedImage image = ImageIO.read(file.getInputStream());
            if (image == null) {
                result.setValid(false);
                result.setMessage("올바른 이미지 파일이 아닙니다.");
                return result;
            }
            
            int width = image.getWidth();
            int height = image.getHeight();
            
            if (width < MIN_WIDTH || width > MAX_WIDTH || 
                height < MIN_HEIGHT || height > MAX_HEIGHT) {
                result.setValid(false);
                result.setMessage(String.format(
                    "이미지 크기가 여권 규격에 맞지 않습니다. " +
                    "권장 크기: %dx%d픽셀, " +
                    "허용 범위: %d~%d x %d~%d픽셀, " +
                    "현재 크기: %dx%d픽셀",
                    RECOMMENDED_WIDTH, RECOMMENDED_HEIGHT,
                    MIN_WIDTH, MAX_WIDTH, MIN_HEIGHT, MAX_HEIGHT,
                    width, height
                ));
                return result;
            }
            
            // 해상도 권장사항 체크 (경고만)
            if (width != RECOMMENDED_WIDTH || height != RECOMMENDED_HEIGHT) {
                result.setWarning("권장 크기(" + RECOMMENDED_WIDTH + "x" + RECOMMENDED_HEIGHT + 
                    "픽셀)와 다릅니다. 여권 발급 시 문제가 될 수 있습니다.");
            }
            
            result.setValid(true);
            result.setMessage("여권 규격에 적합한 사진입니다.");
            
        } catch (IOException e) {
            result.setValid(false);
            result.setMessage("이미지 파일을 읽을 수 없습니다.");
        }
        
        return result;
    }
    
    private boolean isValidImageType(String contentType) {
        return contentType != null && 
               (contentType.equals("image/jpeg") || contentType.equals("image/jpg"));
    }
    
    // 검증 결과 클래스
    public static class ValidationResult {
        private boolean valid;
        private String message;
        private String warning;
        
        // getters and setters
        public boolean isValid() { return valid; }
        public void setValid(boolean valid) { this.valid = valid; }
        
        public String getMessage() { return message; }
        public void setMessage(String message) { this.message = message; }
        
        public String getWarning() { return warning; }
        public void setWarning(String warning) { this.warning = warning; }
    }
}