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
			// ���ǿ��� �ۼ��� ������ ��������
			MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

			if (loginUser != null) {
				boardvo.setWriter(loginUser.getUserId()); // �ۼ��� ����
			} else {
				return "common/top";
			}

			List<String> filename = filedatautil.fileUpload(file);
			if (filename == null || filename.isEmpty()) {
				System.out.println("���� ���ε� ���� �Ǵ� ���� ����");
				filename = new ArrayList<>();
			} else {
				System.out.println("���� ���ε� ����: " + String.join(", ", filename));
			}
			boardvo.setFilename(filename);
			System.out.println("boardvo: " + boardvo.getTitle() + ", " + boardvo.getSaleStatus());
			writeService.addWrite(boardvo);
			System.out.println("�� ��� ����, ������ �̵�");
			return "redirect:boardview";
		} catch (Exception e) {
			System.out.println("�� ��� ����: " + e.getMessage());
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
			return "redirect:/paging?page=1"; // ������ ��ȣ ��ȿ�� üũ
		}
		System.out.println("��û�� ������: " + page);
		List<BoardVO> pagingList = writeService.pagingList(page);
		System.out.println("����¡ ����Ʈ ũ��: " + pagingList.size());
		PageVO pagevo = writeService.pagingParam(page);
		if (pagevo == null) {
			System.out.println("����: pagevo�� null�Դϴ�");
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
		// 1. ��ȸ�� ����
		writeService.viewCount(postNum);

		// 2. �� �� ���� ��������
		BoardVO boardvo = writeService.textview(postNum);

		// 3. �𵨿� ���
		model.addAttribute("post", boardvo);
		List<String> attachList = writeService.getAttach(boardvo.getPostNum());
		model.addAttribute("attachList", attachList);
		model.addAttribute("writer", boardvo.getWriter());

		List<CommentVO> commentList = writeService.getComments(postNum);
		for (CommentVO comment : commentList) {
			if (comment.getParentCommentId() == null) {
				comment.setDepth(0); // ���(�ֻ���)
			} else {
				comment.setDepth(1); // ����(���)
			}
		}
		model.addAttribute("commentList", commentList);

		// 4. �󼼺��� JSP�� �̵�
		return "getuseds/detailview";
	}

	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String deleteContent(@RequestParam("postNum") Long postNum, @RequestParam("writer") String writer,
			HttpSession session, RedirectAttributes ra) {
		// ���ǿ��� �α��� ����� ���� ��������
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		if (loginUser == null) {
			System.out.println("����� ���� ���� �����ϴ�.");
			return "redirect:/common/top";
		}

		// �α��� ����ڿ� �Խñ� �ۼ��� Ȯ��
		String currentUserId = loginUser.getUserId();
		if (!currentUserId.equals(writer)) {
			System.out.println("�α����� ������ �ۼ��� ������ ��ġ���� �ʽ��ϴ�.");
			return "redirect:/boardview";
		}

		// ���� ó��
		writeService.deleteWrite(postNum);
		System.out.println("�Խñ� ���� �Ϸ��߽��ϴ�.");
		return "redirect:/boardview";
	}

	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public String modifyContent(@RequestParam("postNum") Long postNum, HttpSession session, Model model,
			RedirectAttributes ra) {
		System.out.println("modifyContent1 ���� �� �����ִ� �뵵 ");
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

		BoardVO boardVO = writeService.textview(postNum);

		// �� �ۼ��ڿ� �α��� ����ڰ� �ٸ� ���
		if (!loginUser.getUserId().equals(boardVO.getWriter())) {
			System.out.println("�� ������ �ش� ���� �ۼ��� ȸ���� �����մϴ�");
			return "redirect:/boardview";
		}

		// ���� ������ �̵�
		model.addAttribute("boardVO", boardVO);
		return "getuseds/write";
	}

	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modifyContent(@ModelAttribute BoardVO boardvo, @RequestParam("file") MultipartFile[] file,
			HttpSession session, RedirectAttributes ra) throws Exception {
		System.out.println("modifyContent �޼ҵ� ���� ���� ���� �۾��� ����");
		try {
			MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

			if (loginUser == null) {
				ra.addAttribute("message", "�ش� ����� �α����� �ʿ��մϴ�.");
				return "redirect:/boardview";
			}

			BoardVO existingBoard = writeService.textview(boardvo.getPostNum());
			if (!loginUser.getUserId().equals(existingBoard.getWriter())) {
				System.out.println("ȸ���� id�� �ۼ����� id�� ��ġ���� �ʽ��ϴ�.");
				return "redirect:/boardview";
			}

			boardvo.setWriter(loginUser.getUserId());
			// ���������� �Ʒ� ���
			System.out.println("�α����� ���� ID: " + loginUser.getUserId());
			System.out.println("�Խñ� �ۼ��� ID: " + boardvo.getWriter());
			System.out.println("BoardVO ��ü: " + boardvo.toString());

			// ���� ���ε� ó��
			List<String> filename = null;
			try {
				filename = filedatautil.fileUpload(file);
				System.out.println("fileUpload ��ȯ��: " + filename);
			} catch (Exception e) {
				System.out.println("fileUpload �޼ҵ忡�� ���� �߻�!");
				e.printStackTrace();
				System.out.println("���� ���ε� �� ������ �߻��߽��ϴ�.");
				return "redirect:/error";
			}

			// filename�� null�� �ƴϰ�, �� ���ڿ��� �ƴ���
			if (filename != null && !filename.isEmpty()) {
				boardvo.setFilename(filename);
				System.out.println("modifyWrite ÷������ ����Ʈ: " + boardvo.getFilename());
			}

			writeService.modifyWrite(boardvo);
			System.out.println("�Խñ� ������ �Ϸ��߽��ϴ�.");
			return "redirect:/boardview?postNum=" + boardvo.getPostNum();

		} catch (Exception e) {
			System.out.println("���� �߻�!");
			e.printStackTrace();
			System.out.println("�Խñ� ���� �� ������ �߻��߽��ϴ�.");
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
			result.put("message", "�α����� �ʿ��մϴ�.");
			return result;
		}
		commentvo.setUserId(loginUser.getUserId());
		commentvo.setPostNum(postNum);

		// �� depth�� null�̸� 0���� ���� (������ġ)
		if (commentvo.getDepth() == null) {
			commentvo.setDepth(0);
		}

		// �ֻ��� ����̸� parentCommentId�� null�� �����ϰ� depth�� 0����
		if (commentvo.getParentCommentId() == null || commentvo.getParentCommentId() == 0) {
			commentvo.setParentCommentId(null);
			commentvo.setDepth(0);
		} else {
			commentvo.setDepth(1); // �����̸� 1
		}

		try {
			writeService.addCommentWrite(commentvo);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", "��� ��� ����: " + e.getMessage());
			e.printStackTrace();
		}
		return result;
	}

	@GetMapping("/commentSection")
	public String getCommentList(@RequestParam Long postNum, Model model) {
		List<CommentVO> commentList = writeService.getComments(postNum);

		// ���/���� depth ����
		for (CommentVO comment : commentList) {

			if (comment.getParentCommentId() == null) {
				comment.setDepth(0); // ���(�ֻ���)
			} else {
				comment.setDepth(1); // ����(���)
			}
			System.out.println("commentId: " + comment.getCommentId() + ", parent: " + comment.getParentCommentId()
					+ ", depth: " + comment.getDepth());
		}

		model.addAttribute("commentList", commentList);
		return "getuseds/commentSection";
	}

	@PostMapping("/deleteComment")
	@ResponseBody // @ResponseBody �߰� ����
	public Map<String, Object> deleteComment(@RequestParam("commentId") int commentId, HttpSession session) {
		Map<String, Object> response = new HashMap<>();
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			response.put("success", false);
			response.put("message", "�α����� �ʿ��մϴ�.");
			return response;
		}

		try {
			// ���� ȣ�� �� userId ���� (�߿�)
			boolean deleteSuccess = writeService.deleteComment(commentId, loginUser.getUserId());

			if (deleteSuccess) {
				response.put("success", true);
				response.put("message", "����� ���������� �����Ǿ����ϴ�.");
			} else {
				response.put("success", false);
				response.put("message", "��� ������ �����߽��ϴ�."); // ���� ���� ���ο� ���� �޽��� ����
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.put("success", false);
			response.put("message", "��� ���� �� ������ �߻��߽��ϴ�: " + e.getMessage());
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
				result.put("message", "��� ������ �Ϸ�Ǿ����ϴ�.");
			} else {
				result.put("message", "��� ������ �����߽��ϴ�. �ش� ����� ã�� �� ���ų� ������ �����ϴ�.");
			}
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", "���� ����: " + e.getMessage());
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
			result.put("message", "�α����� �ʿ��մϴ�.");
			return result;
		}

		try {
			commentvo.setUserId(loginUser.getUserId());
			// ������ depth�� �θ� ����� depth + 1�� �����ϰų�, ���񽺿��� ó��
			writeService.addCommentReply(commentvo);
			result.put("success", true);
			result.put("message", "������ ��ϵǾ����ϴ�.");
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", "���� ��� ����: " + e.getMessage());
			e.printStackTrace();
		}
		return result;
	}

}
