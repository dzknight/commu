package www.silver.mapper;

import www.silver.vo.ImageInfoVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

@Component
@Mapper
public interface ImageInfoMapper {
    void saveImageInfo(ImageInfoVO imageInfo);
}