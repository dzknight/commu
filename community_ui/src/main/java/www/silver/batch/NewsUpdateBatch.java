package www.silver.batch;

// Spring Batch 작업 구성을 위해서 필요한 클래스 및 어노테이션 임포트
import javax.inject.Inject;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.configuration.annotation.EnableBatchProcessing;
import org.springframework.batch.core.configuration.annotation.JobBuilderFactory;
import org.springframework.batch.core.configuration.annotation.StepBuilderFactory;
import org.springframework.batch.core.launch.support.RunIdIncrementer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * 뉴스 업데이트 배치 작업 설정 클래스
 * Spring Batch를 사용하여 IT 뉴스 데이터를 자동으로 수집하고 업데이트하는 배치 작업을 정의
 */
@Configuration // Spring 설정 클래스임을 나타냄
@EnableBatchProcessing // Spring Batch 기능을 활성화
public class NewsUpdateBatch {

    // Spring Batch Job 생성을 위한 팩토리 클래스 주입
    @Inject
    private JobBuilderFactory jobBuilderFactory;

    // Spring Batch Step 생성을 위한 팩토리 클래스 주입
    @Inject
    private StepBuilderFactory stepBuilderFactory;

    // 실제 뉴스 업데이트 로직을 담당하는 Tasklet 주입
    @Inject
    private NewsUpdateTasklet ITnewsUpdateTasklet;

    /**
     * IT 뉴스 업데이트 Job 정의
     * @return Job 객체 - Spring Batch에서 실행할 작업 단위
     */
    @Bean
    public Job ITnewsUpdateJob() {
        // "ITnewsUpdateJob"이라는 작업 생성
        // RunIdIncrementer: 중복 실행 방지 위해 각 작업 실행시마다 고유한 ID를 부여
        // newsUpdateStep을 시작 스텝으로 설정
        return jobBuilderFactory.get("ITnewsUpdateJob")
                .incrementer(new RunIdIncrementer()) // 매 실행마다 고유 파라미터 생성
                .start(ITnewsUpdateStep()) // 첫 번째 실행할 Step 지정
                .build();
    }

    /**
     * IT 뉴스 업데이트 Step 정의
     * @return Step 객체 - Job 내에서 실행되는 개별 작업 단위
     */
    @Bean
    public Step ITnewsUpdateStep() {
        // "ITnewsUpdateStep"이라는 이름의 스텝을 생성
        // ITnewsUpdateTasklet을 사용하여 실제로 뉴스 데이터 수집 및 저장 작업 수행
        return stepBuilderFactory.get("ITnewsUpdateStep")
                .tasklet(ITnewsUpdateTasklet) // Tasklet 방식으로 단일 작업 실행
                .build();
    }
}
