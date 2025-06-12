package www.silver.scheduler;

import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobParameters;
import org.springframework.batch.core.JobParametersBuilder;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.inject.Inject;
import java.time.LocalDateTime;


@Component
@EnableScheduling
public class NewsUpdateScheduler {


     // Spring Batch Job을 실행하기 위한 JobLauncher 주입
    @Inject
    private JobLauncher jobLauncher;


     // 뉴스 업데이트를 담당하는 Spring Batch Job Bean 주입
    @Inject
    private Job ITnewsUpdateJob;


     // 매일 오전 10시 뉴스 업데이트 실행
     // cron 표현식 설명: "초 분 시 일 월 요일"
     // 네이버 뉴스 API에서 최신 IT 뉴스를 수집하여 데이터베이스에 저장
    @Scheduled(cron = "0 0 10 * * *")
    public void scheduleNewsUpdateAt10AM() {
        System.out.println("=== 스케줄링 뉴스 업데이트 시작 (오전 9시 4분) ===");
        System.out.println("실행 시간: " + LocalDateTime.now());

        // 실제 배치 작업 실행 (스케줄 정보와 함께)
        runNewsUpdateJob("매일 오전 10시 자동 실행");
    }

    /**
     * 실제 Spring Batch Job 실행을 담당하는 메서드
     * JobParameters를 통해 각 실행을 고유하게 식별하고 실행 정보를 전달
     * @param scheduleInfo 스케줄 실행 정보
     */
    private void runNewsUpdateJob(String scheduleInfo) {
        try {
            // JobParameters 생성 - 각 실행을 고유하게 식별하기 위한 파라미터 설정
            JobParameters params = new JobParametersBuilder()
                    .addLong("time", System.currentTimeMillis()) // 실행 시간을 밀리초로 추가
                    .addString("schedule", scheduleInfo) // 스케줄 정보 추가
                    .toJobParameters();

            // Spring Batch Job 실행
            // JobLauncher를 통해 ITnewsUpdateJob을 파라미터와 함께 실행
            // 이때 NewsUpdateTasklet의 execute() 메서드가 호출됨
            jobLauncher.run(ITnewsUpdateJob, params);

            System.out.println("=== " + scheduleInfo + " 뉴스 업데이트 완료 ===");

        } catch (Exception e) {
            // 배치 작업 실행 중 발생한 예외 처리
            System.err.println("=== " + scheduleInfo + " 뉴스 업데이트 실패 ===");
            System.err.println("오류 메시지: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
