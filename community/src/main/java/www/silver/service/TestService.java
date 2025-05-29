package www.silver.service;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import www.silver.mapper.ImageInfoMapper;
import www.silver.vo.ImageInfoVO;

@Service
public class TestService {

    private final S3ImageUploadService s3ImageUploadService;
    @Autowired
    private final ImageInfoMapper imageInfoMapper;

    @Autowired
    public TestService(S3ImageUploadService s3ImageUploadService, ImageInfoMapper imageInfoMapper) {
        this.s3ImageUploadService = s3ImageUploadService;
        this.imageInfoMapper = imageInfoMapper;
    }

    @Transactional
    public String uploadImageAndSavePath(MultipartFile file) throws IOException {
        // 1. S3에 이미지 업로드
        String s3FileUrl = s3ImageUploadService.uploadFile(file, "test-images"); // "test-images"는 S3 버킷 내 테스트용 디렉토리명

        // 2. DB에 이미지 정보 저장
        ImageInfoVO imageInfo = new ImageInfoVO();
        imageInfo.setS3Url(s3FileUrl);
        imageInfo.setOriginalFileName(file.getOriginalFilename());

        imageInfoMapper.saveImageInfo(imageInfo);

        return s3FileUrl; // S3에 업로드된 URL 반환
    }
}
