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
import www.silver.service.IF_writeService;
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

	@RequestMapping(value = "/fleaMarket", method = RequestMethod.GET)
	public String viewBoard() {
		return "redirect:boardview";
	}

	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String write() {
		return "getuseds/write";
	}

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
				System.out.println("파일 업로드 실패 또는 파일 없음");
				filename = new ArrayList<>();
			} else {
				System.out.println("파일 업로드 성공: " + String.join(", ", filename));
			}
			boardvo.setFilename(filename);
			System.out.println("boardvo: " + boardvo.getTitle() + ", " + boardvo.getSaleStatus());
			writeService.addWrite(boardvo);
			System.out.println("글 등록 성공, 페이지 이동");
			return "redirect:boardview";
		} catch (Exception e) {
			System.out.println("글 등록 오류: " + e.getMessage());
			e.printStackTrace();
			return "redirect:/error";
		}
	}

	@RequestMapping(value = "/boardview", method = RequestMethod.GET)
	public String boardview() {
		return "redirect:/paging?page=1";
	}

	@GetMapping("/paging")
	public String paging(Model model, @RequestParam(value = "page", required = false, defaultValue = "1") int page) {
		if (page < 1) {
			return "redirect:/paging?page=1"; // 페이지 번호 유효성 체크
		}
		System.out.println("요청된 페이지: " + page);
		List<BoardVO> pagingList = writeService.pagingList(page);
		System.out.println("페이징 리스트 크기: " + pagingList.size());
		PageVO pagevo = writeService.pagingParam(page);
		if (pagevo == null) {
			System.out.println("오류: pagevo가 null입니다");
			pagevo = new PageVO();
			pagevo.setPage(1);
			pagevo.setMaxPage(1);
			pagevo.setStartPage(1);
			pagevo.setEndPage(1);
		}
		model.addAttribute("contentlist", pagingList);
		model.addAttribute("paging", pagevo);
		return "getuseds/board";
	}

	@RequestMapping(value = "/textview", method = RequestMethod.GET)
	public String textview(@RequestParam("postNum") Long postNum, Model model) {
		// 1. 조회수 증가
		writeService.viewCount(postNum);

		// 2. 상세 글 정보 가져오기
		BoardVO boardvo = writeService.textview(postNum);

		// 3. 모델에 담기
		model.addAttribute("post", boardvo);
		List<String> attachList = writeService.getAttach(boardvo.getPostNum());
		model.addAttribute("attachList", attachList);
		model.addAttribute("writer", boardvo.getWriter());

		List<CommentVO> commentList = writeService.getComments(postNum);
		for (CommentVO comment : commentList) {
			if (comment.getParentCommentId() == null) {
				comment.setDepth(0); // 댓글(최상위)
			} else {
				comment.setDepth(1); // 대댓글(답글)
			}
		}
		model.addAttribute("commentList", commentList);

		// 4. 상세보기 JSP로 이동
		return "getuseds/detailview";
	}

	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String deleteContent(@RequestParam("postNum") Long postNum, @RequestParam("writer") String writer,
			HttpSession session, RedirectAttributes ra) {
		// 세션에서 로그인 사용자 정보 가져오기
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		if (loginUser == null) {
			System.out.println("사용자 정보 값이 없습니다.");
			return "redirect:/common/top";
		}

		// 로그인 사용자와 게시글 작성자 확인
		String currentUserId = loginUser.getUserId();
		if (!currentUserId.equals(writer)) {
			System.out.println("로그인한 유저와 작성자 정보가 일치하지 않습니다.");
			return "redirect:/boardview";
		}

		// 삭제 처리
		writeService.deleteWrite(postNum);
		System.out.println("게시글 삭제 완료했습니다.");
		return "redirect:/boardview";
	}

	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public String modifyContent(@RequestParam("postNum") Long postNum, HttpSession session, Model model,
			RedirectAttributes ra) {
		System.out.println("modifyContent1 진입 폼 보여주는 용도 ");
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

		BoardVO boardVO = writeService.textview(postNum);

		// 글 작성자와 로그인 사용자가 다른 경우
		if (!loginUser.getUserId().equals(boardVO.getWriter())) {
			System.out.println("글 수정은 해당 글을 작성한 회원만 가능합니다");
			return "redirect:/boardview";
		}

		// 수정 폼으로 이동
		model.addAttribute("boardVO", boardVO);
		return "getuseds/write";
	}

	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modifyContent(@ModelAttribute BoardVO boardvo, @RequestParam("file") MultipartFile[] file,
			HttpSession session, RedirectAttributes ra) throws Exception {
		System.out.println("modifyContent 메소드 진입 실제 수정 작업을 진행");
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
			// 디버깅용으로 아래 출력
			System.out.println("로그인한 유저 ID: " + loginUser.getUserId());
			System.out.println("게시글 작성자 ID: " + boardvo.getWriter());
			System.out.println("BoardVO 전체: " + boardvo.toString());

			// 파일 업로드 처리
			List<String> filename = null;
			try {
				filename = filedatautil.fileUpload(file);
				System.out.println("fileUpload 반환값: " + filename);
			} catch (Exception e) {
				System.out.println("fileUpload 메소드에서 예외 발생!");
				e.printStackTrace();
				System.out.println("파일 업로드 중 오류가 발생했습니다.");
				return "redirect:/error";
			}

			// filename이 null이 아니고, 빈 문자열이 아닌지
			if (filename != null && !filename.isEmpty()) {
				boardvo.setFilename(filename);
				System.out.println("modifyWrite 첨부파일 리스트: " + boardvo.getFilename());
			}

			writeService.modifyWrite(boardvo);
			System.out.println("게시글 수정을 완료했습니다.");
			return "redirect:/boardview?postNum=" + boardvo.getPostNum();

		} catch (Exception e) {
			System.out.println("예외 발생!");
			e.printStackTrace();
			System.out.println("게시글 수정 중 오류가 발생했습니다.");
			return "redirect:/error";
		}
	}

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

		// ★ depth가 null이면 0으로 세팅 (안전장치)
		if (commentvo.getDepth() == null) {
			commentvo.setDepth(0);
		}

		// 최상위 댓글이면 parentCommentId를 null로 세팅하고 depth도 0으로
		if (commentvo.getParentCommentId() == null || commentvo.getParentCommentId() == 0) {
			commentvo.setParentCommentId(null);
			commentvo.setDepth(0);
		} else {
			commentvo.setDepth(1); // 대댓글이면 1
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

	@GetMapping("/commentSection")
	public String getCommentList(@RequestParam Long postNum, Model model) {
		List<CommentVO> commentList = writeService.getComments(postNum);

		// 댓글/대댓글 depth 보정
		for (CommentVO comment : commentList) {

			if (comment.getParentCommentId() == null) {
				comment.setDepth(0); // 댓글(최상위)
			} else {
				comment.setDepth(1); // 대댓글(답글)
			}
			System.out.println("commentId: " + comment.getCommentId() + ", parent: " + comment.getParentCommentId()
					+ ", depth: " + comment.getDepth());
		}

		model.addAttribute("commentList", commentList);
		return "getuseds/commentSection";
	}

	@PostMapping("/deleteComment")
	@ResponseBody // @ResponseBody 추가 권장
	public Map<String, Object> deleteComment(@RequestParam("commentId") int commentId, HttpSession session) {
		Map<String, Object> response = new HashMap<>();
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			response.put("success", false);
			response.put("message", "로그인이 필요합니다.");
			return response;
		}

		try {
			// 서비스 호출 시 userId 전달 (중요)
			boolean deleteSuccess = writeService.deleteComment(commentId, loginUser.getUserId());

			if (deleteSuccess) {
				response.put("success", true);
				response.put("message", "댓글이 성공적으로 삭제되었습니다.");
			} else {
				response.put("success", false);
				response.put("message", "댓글 삭제에 실패했습니다."); // 실제 실패 원인에 따라 메시지 조정
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.put("success", false);
			response.put("message", "댓글 삭제 중 오류가 발생했습니다: " + e.getMessage());
		}
		return response;
	}

	@PostMapping("/updateComment")
	@ResponseBody
	public Map<String, Object> updateComment(@RequestBody CommentVO commentVO) {
		Map<String, Object> result = new HashMap<>();
		try {
			boolean success = writeService.updateComment(commentVO.getCommentId(), commentVO.getContent(),
					commentVO.getPostNum());
			result.put("success", success);
			if (success) {
				result.put("message", "댓글 수정이 완료되었습니다.");
			} else {
				result.put("message", "댓글 수정에 실패했습니다. 해당 댓글을 찾을 수 없거나 권한이 없습니다.");
			}
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", "서버 오류: " + e.getMessage());
		}
		return result;
	}

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
			// 대댓글의 depth는 부모 댓글의 depth + 1로 설정하거나, 서비스에서 처리
			writeService.addCommentReply(commentvo);
			result.put("success", true);
			result.put("message", "대댓글이 등록되었습니다.");
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", "대댓글 등록 실패: " + e.getMessage());
			e.printStackTrace();
		}
		return result;
	}

}
