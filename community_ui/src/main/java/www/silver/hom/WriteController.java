package www.silver.hom;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import www.silver.vo.PageVO;
import www.silver.vo.BoardVO;
import www.silver.vo.CommentVO;
import www.silver.vo.MemberVO;
import www.silver.util.FileDataUtil;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

@Controller
public class WriteController {

	@Inject
	IF_writeService writeService;

	@Inject
	FileDataUtil filedatautil;

	// QA게시판 페이지로 리다이렉트
	@RequestMapping(value = "/QABoard", method = RequestMethod.GET)
	public String viewBoard() {
		return "redirect:boardview";
	}

	// 글 작성 페이지로 이동
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String write() {
		return "getuseds/write";
	}

	// 게시글 저장 처리
	@RequestMapping(value = "/insertContent", method = RequestMethod.POST)
	public String saveWrite(@ModelAttribute BoardVO boardvo, MultipartFile[] file, HttpSession session)
			throws Exception {
		try {
			// 세션에서 작성자 정보를 가져오기
			MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

			if (loginUser != null) {
				boardvo.setWriter(loginUser.getUserId()); // 작성자 설정
			} else {
				return "common/top";
			}

			List<String> filename = filedatautil.fileUpload(file);
			if (filename == null || filename.isEmpty()) {
				System.out.println("파일 업로드 없음 또는 파일 없음");
				filename = new ArrayList<>();
			} else {
				System.out.println("파일 업로드 성공: " + String.join(", ", filename));
			}
			boardvo.setFilename(filename);
			writeService.addWrite(boardvo);
			System.out.println("글 등록 성공, 게시판 이동");
			return "redirect:boardview";
		} catch (Exception e) {
			System.out.println("글 등록 실패: " + e.getMessage());
			e.printStackTrace();
			return "redirect:/error";
		}
	}

	// 게시판 목록 페이지로 리다이렉트
	@RequestMapping(value = "/boardview", method = RequestMethod.GET)
	public String boardview() {
		return "redirect:/paging?page=1";
	}

	// 페이징 처리된 게시판 목록 조회
	@GetMapping("/paging")
	public String paging(Model model, @RequestParam(value = "page", required = false, defaultValue = "1") int page) {
		if (page < 1) {
			return "redirect:/paging?page=1"; // 페이지 번호 유효성 체크
		}
		System.out.println("요청된 페이지: " + page);
		List<BoardVO> pagingList = writeService.pagingList(page);
		System.out.println("페이징 리스트 크기: " + pagingList.size());
		PageVO pagevo = writeService.pagingParam(page);
		/*if (pagevo == null) {
			System.out.println("오류: pagevo가 null입니다");
			pagevo = new PageVO();
			pagevo.setPage(1);
			pagevo.setMaxPage(1);
			pagevo.setStartPage(1);
			pagevo.setEndPage(1);
		}*/
		model.addAttribute("contentlist", pagingList);
		model.addAttribute("paging", pagevo);
		return "getuseds/board";
	}

	// 게시글 상세 조회
	@RequestMapping(value = "/textview", method = RequestMethod.GET)
	public String textview(@RequestParam("postNum") Long postNum, Model model) {
		// 조회수 증가
		writeService.viewCount(postNum);

		// 글 및 첨부 파일정보 가져오기
		BoardVO boardvo = writeService.textview(postNum);


		model.addAttribute("post", boardvo);
		List<String> attachList = writeService.getAttach(boardvo.getPostNum());
		model.addAttribute("attachList", attachList);
		model.addAttribute("writer", boardvo.getWriter());

		List<CommentVO> commentList = writeService.getComments(postNum);
		for (CommentVO comment : commentList) {
			if (comment.getParentCommentId() == null) {
				comment.setDepth(0); // 부모(최상위)
			} else {
				comment.setDepth(1); // 자식(답글)
			}
		}
		model.addAttribute("commentList", commentList);

		// 4. 상세보기 JSP로 이동
		return "getuseds/detailview";
	}

	// 게시글 삭제 처리
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String deleteContent(@RequestParam("postNum") Long postNum, @RequestParam("writer") String writer,
								HttpSession session, RedirectAttributes ra) {

		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		if (loginUser == null) {
			System.out.println("사용자 정보 없음 로그인하세요.");
			return "redirect:/common/top";
		}

		// 로그인 사용자와 게시글 작성자 확인
		String currentUserId = loginUser.getUserId();
		if (!currentUserId.equals(writer)) {
			System.out.println("로그인한 사용자 작성자 정보가 일치하지 않습니다.");
			return "redirect:/boardview";
		}

		// 삭제 처리
		writeService.deleteWrite(postNum);
		System.out.println("게시글 삭제 완료했습니다.");
		return "redirect:/boardview";
	}

	// 게시글 수정 페이지로 이동
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public String modifyContent(@RequestParam("postNum") Long postNum, HttpSession session, Model model,
								RedirectAttributes ra) {
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

		BoardVO boardVO = writeService.textview(postNum);

		// 글 작성자와 로그인 사용자가 다른 경우
		if (!loginUser.getUserId().equals(boardVO.getWriter())) {
			System.out.println("글 수정은 해당 글의 작성한 회원만 가능합니다");
			return "redirect:/boardview";
		}

		// 수정 페이지로 이동
		model.addAttribute("boardVO", boardVO);
		return "getuseds/write";
	}

	// 게시글 수정 처리
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modifyContent(@ModelAttribute BoardVO boardvo, @RequestParam("file") MultipartFile[] file,
								HttpSession session, RedirectAttributes ra) throws Exception {
		try {
			MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

			if (loginUser == null) {
				ra.addAttribute("message", "해당 기능은 로그인이 필요합니다.");
				return "redirect:/boardview";
			}

			BoardVO existingBoard = writeService.textview(boardvo.getPostNum());
			if (!loginUser.getUserId().equals(existingBoard.getWriter())) {
				System.out.println("회원의 id와 작성자의 id가 일치하지 않습니다.");
				return "redirect:/boardview";
			}

			boardvo.setWriter(loginUser.getUserId());
			// 디버깅을 위한 로그
			System.out.println("로그인한 사용자 ID: " + loginUser.getUserId());
			System.out.println("게시글 작성자 ID: " + boardvo.getWriter());
			System.out.println("BoardVO 객체: " + boardvo.toString());

			// 파일 업로드 처리
			List<String> filename = null;
			try {
				filename = filedatautil.fileUpload(file);
				System.out.println("fileUpload 반환값: " + filename);
			} catch (Exception e) {
				System.out.println("fileUpload 메소드에서 오류 발생!");
				e.printStackTrace();
				System.out.println("파일 업로드 중 오류가 발생했습니다.");
				return "redirect:/error";
			}

			// filename이 null이 아니고, 빈 문자열이 아니면
			if (filename != null && !filename.isEmpty()) {
				boardvo.setFilename(filename);
				System.out.println("modifyWrite 첨부파일 리스트: " + boardvo.getFilename());
			}

			writeService.modifyWrite(boardvo);
			System.out.println("게시글 수정이 완료했습니다.");
			return "redirect:/boardview?postNum=" + boardvo.getPostNum();

		} catch (Exception e) {
			System.out.println("오류 발생!");
			e.printStackTrace();
			System.out.println("게시글 수정 중 오류가 발생했습니다.");
			return "redirect:/error";
		}
	}

	// 댓글 작성 처리
	@PostMapping("/commentWrite")
	@ResponseBody
	public Map<String, Object> saveCommentWrite(@ModelAttribute CommentVO commentvo, long postNum, HttpSession session)
			throws Exception {
		Map<String, Object> result = new HashMap<>();
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		if (loginUser == null) {
			result.put("success", false);
			result.put("message", "로그인이 필요합니다.");
			return result;
		}
		commentvo.setUserId(loginUser.getUserId());
		commentvo.setPostNum(postNum);

		// 만약 depth가 null이면 0으로 설정 (기본값처리)
		if (commentvo.getDepth() == null) {
			commentvo.setDepth(0);
		}

		// 최상위 댓글이면 parentCommentId를 null로 설정하고 depth를 0으로
		if (commentvo.getParentCommentId() == null || commentvo.getParentCommentId() == 0) {
			commentvo.setParentCommentId(null);
			commentvo.setDepth(0);
		} else {
			commentvo.setDepth(1); // 답글이면 1
		}

		try {
			writeService.addCommentWrite(commentvo);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", "댓글 등록 실패: " + e.getMessage());
			e.printStackTrace();
		}
		return result;
	}

	// 댓글 목록 조회
	@GetMapping("/commentSection")
	public String getCommentList(@RequestParam Long postNum, Model model) {
		List<CommentVO> commentList = writeService.getComments(postNum);

		// 부모/자식 depth 설정
		for (CommentVO comment : commentList) {

			if (comment.getParentCommentId() == null) {
				comment.setDepth(0); // 부모(최상위)
			} else {
				comment.setDepth(1); // 자식(답글)
			}
			System.out.println("commentId: " + comment.getCommentId() + ", parent: " + comment.getParentCommentId()
					+ ", depth: " + comment.getDepth());
		}

		model.addAttribute("commentList", commentList);
		return "getuseds/commentSection";
	}

	// 댓글 삭제 처리
	@PostMapping("/deleteComment")
	@ResponseBody // @ResponseBody 추가 필요
	public Map<String, Object> deleteComment(@RequestParam("commentId") int commentId, HttpSession session) {
		Map<String, Object> response = new HashMap<>();
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			response.put("success", false);
			response.put("message", "로그인이 필요합니다.");
			return response;
		}

		try {
			// 서비스 호출 시 userId 전달
			boolean deleteSuccess = writeService.deleteComment(commentId, loginUser.getUserId());

			if (deleteSuccess) {
				response.put("success", true);
				response.put("message", "댓글이 성공적으로 삭제되었습니다.");
			} else {
				response.put("success", false);
				response.put("message", "댓글 삭제에 실패했습니다."); // 권한 없음 또는 다른 메시지 표시
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.put("success", false);
			response.put("message", "댓글 삭제 중 오류가 발생했습니다: " + e.getMessage());
		}
		return response;
	}

	// 댓글 수정 처리
	@PostMapping("/updateComment")
	@ResponseBody
	public Map<String, Object> updateComment(@RequestBody CommentVO commentvo) {
		Map<String, Object> result = new HashMap<>();
		try {
			boolean success;

			if (commentvo.getDepth() == 0) {
				// 일반 댓글 수정
				success = writeService.updateComment(commentvo.getCommentId(),
						commentvo.getContent(), commentvo.getPostNum());
				System.out.println("일반 댓글 수정 - commentId: " + commentvo.getCommentId());
			} else {
				// 답글 수정 (필요시 별도 메소드 사용)
				success = writeService.updateReply(commentvo.getCommentId(),
						commentvo.getContent(), commentvo.getPostNum());
				System.out.println("답글 수정 - commentId: " + commentvo.getCommentId());
			}

			result.put("success", success);
			if (success) {
				result.put("message", "댓글 수정이 완료되었습니다.");
			} else {
				result.put("message", "댓글 수정에 실패했습니다. 해당 댓글을 찾을 수 없거나 권한이 없습니다.");
			}
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", "수정 실패: " + e.getMessage());
		}
		return result;
	}

	// 대댓글 작성 처리
	@PostMapping("/commentReply")
	@ResponseBody
	public Map<String, Object> saveCommentReply(@RequestBody CommentVO commentvo, HttpSession session) {
		Map<String, Object> result = new HashMap<>();
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		System.out.println("parentCommentId(Controller): " + commentvo.getParentCommentId());

		if (loginUser == null) {
			result.put("success", false);
			result.put("message", "로그인이 필요합니다.");
			return result;
		}

		try {
			commentvo.setUserId(loginUser.getUserId());
			// 답글의 depth는 부모 댓글의 depth + 1로 설정하거나, 서비스에서 처리
			writeService.addCommentReply(commentvo);
			result.put("success", true);
			result.put("message", "답글이 등록되었습니다.");
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", "답글 등록 실패: " + e.getMessage());
			e.printStackTrace();
		}
		return result;
	}

}
