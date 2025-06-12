package www.silver.batch;

import java.util.List;

import javax.inject.Inject;

import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.stereotype.Component;

import www.silver.dao.IF_newsDAO;
import www.silver.service.IF_newsService;
import www.silver.vo.NewsVO;

/**
 * 뉴스 업데이트 배치 작업을 수행하는 Tasklet 구현체
 * Spring Batch에서 실제 뉴스 데이터 수집 및 저장 로직을 담당
 */
@Component // Spring Bean으로 등록하여 의존성 주입 가능하도록 설정
public class NewsUpdateTasklet implements Tasklet {

	// 뉴스 서비스 인터페이스 주입 - 실제 뉴스 수집 및 저장 로직 담당
	@Inject
	IF_newsService newsService;

	/**
	 * Spring Batch Step에서 실행되는 메인 로직
	 * @param contribution Step 실행 결과에 대한 정보를 담는 객체
	 * @param chunkContext 현재 실행 중인 Step과 Job의 컨텍스트 정보
	 * @return RepeatStatus.FINISHED - 작업 완료 상태 반환
	 * @throws Exception 배치 작업 중 발생할 수 있는 모든 예외
	 */
	@Override
	public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
		System.out.println("=== 뉴스 업데이트 배치 시작 ===");
		System.out.println("시작 시간: " + java.time.LocalDateTime.now());
		System.out.println("배치 작업 ID: " + chunkContext.getStepContext().getJobName());

		try {
			// 배치 작업 및 상태 확인
			System.out.println("뉴스 수집 시작 - 네이버 API 호출 준비");

			// 뉴스 처리의 핵심 로직 (Reader + Processor + Writer 역할)
			// 네이버 뉴스 API에서 데이터를 가져와 데이터베이스에 저장
			newsService.fetchAndSaveNews();

			System.out.println("=== 뉴스 업데이트 배치 완료 ===");
			System.out.println("완료 시간: " + java.time.LocalDateTime.now());

		} catch (Exception e) {
			// 오류 처리
			System.err.println("=== 뉴스 업데이트 중 오류 발생 ===");
			System.err.println("오류 메시지: " + e.getMessage());
			System.err.println("오류 발생 시간: " + java.time.LocalDateTime.now());
			e.printStackTrace();

			// Spring Batch가 실패로 처리하도록 예외 재발생
			// 이를 통해 Job 실행 이력에 실패 상태가 기록됨
			throw e;
		}

		// RepeatStatus.FINISHED: 이 Tasklet이 성공적으로 완료되었음을 Spring Batch에 알림
		// 다음 Step이 있다면 진행하고, 없다면 Job 종료
		return RepeatStatus.FINISHED;
	}
}
