package www.silver.util;

import java.time.Duration;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Component;


@Component
public class RedisUtil {
    
    @Autowired
    private RedisTemplate<String, String> redisTemplate;
    
    // 데이터 저장 (만료시간 설정)
    public void setDataExpire(String key, String value, long duration) {
        ValueOperations<String, String> valueOperations = redisTemplate.opsForValue();
        Duration expireDuration = Duration.ofSeconds(duration);
        valueOperations.set(key, value, expireDuration);
    }
    
    // 데이터 조회
    public String getData(String key) {
        ValueOperations<String, String> valueOperations = redisTemplate.opsForValue();
        return valueOperations.get(key);
    }
    
    // 데이터 삭제
    public void deleteData(String key) {
        redisTemplate.delete(key);
    }
    
    // 키 존재 여부 확인
    public boolean existData(String key) {
        return redisTemplate.hasKey(key);
    }
    
    // 인증번호 생성
    public String createCertifyNum() {
        Random random = new Random();
        StringBuilder certifyNum = new StringBuilder();
        
        for (int i = 0; i < 6; i++) {
            certifyNum.append(random.nextInt(10));
        }
        
        return certifyNum.toString();
    }
}