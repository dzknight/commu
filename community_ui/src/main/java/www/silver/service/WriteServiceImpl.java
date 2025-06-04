package www.silver.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import www.silver.vo.BoardVO;
import www.silver.vo.CommentVO;
import www.silver.vo.PageVO;
import www.silver.dao.IF_writeDAO;

@Service
public class WriteServiceImpl implements IF_writeService {

    @Inject
    IF_writeDAO writedao;

    @Override
    public void addWrite(BoardVO boardvo) {
        // 寃뚯떆湲� �벑濡� (postNum�쓣 癒쇱� �솗蹂댄븳 �썑 �뙆�씪泥섎━)
        writedao.insertWrite(boardvo);
        // 寃뚯떆湲� �벑濡� �썑 �뙆�씪 紐⑸줉 ���옣 - postNum 湲곗��쑝濡� 臾띠쓬 泥섎━
        Long postNum = boardvo.getPostNum();
        List<String> fname = boardvo.getFilename();
        for (String filename : fname) {
            Map<String, Object> params = new HashMap<>();
            params.put("postNum", postNum);
            params.put("filename", filename);
            writedao.attachFname(params);
        }
    }

    @Override
    public List<BoardVO> boardAllView() {
        List<BoardVO> clist = writedao.selectall();
        return clist;
    }

    int pageLimit = 10; // �븳 �럹�씠吏��떦 蹂댁뿬以� 寃뚯떆湲� �닔
    int blockLimit = 5; // �븯�떒�뿉 蹂댁뿬以� �럹�씠吏� 踰덊샇 媛쒖닔

    @Override
    public List<BoardVO> pagingList(int page) {
        if (page < 1) {
            page = 1;
        }
        int pagingStart = (page - 1) * pageLimit;
        Map<String, Integer> pagingParams = new HashMap<>();
        pagingParams.put("start", pagingStart);
        pagingParams.put("limit", pageLimit);
        List<BoardVO> pagingList = writedao.pagingList(pagingParams);
        System.out.println("Paging list retrieved: " + pagingList.size() + " items for page " + page);
        return pagingList;
    }

    @Override
    public PageVO pagingParam(int page) {
        int boardCount = writedao.boardCount();
        System.out.println("Total board count: " + boardCount);

        int maxPage = (int) Math.ceil((double) boardCount / pageLimit);
        if (maxPage < 1) maxPage = 1;

        // �쁽�옱 �럹�씠吏� �쑀�슚�꽦 寃��궗
        if (page < 1) page = 1;
        if (page > maxPage) page = maxPage;

        // �븯�떒 �럹�씠吏� 踰덊샇 踰붿쐞 怨꾩궛
        int startPage = ((page - 1) / blockLimit) * blockLimit + 1;
        int endPage = startPage + blockLimit - 1;
        if (endPage > maxPage) endPage = maxPage;

        PageVO pagevo = new PageVO();
        pagevo.setPage(page);
        pagevo.setMaxPage(maxPage);
        pagevo.setStartPage(startPage);
        pagevo.setEndPage(endPage);

        System.out.println("== �럹�씠吏� 泥섎━ 寃곌낵 ==");
        System.out.println("page = " + page);
        System.out.println("startPage = " + startPage);
        System.out.println("endPage = " + endPage);
        System.out.println("maxPage = " + maxPage);

        return pagevo;
    }

    @Override
    public BoardVO textview(Long postNum) {
        BoardVO boardvo = writedao.selectOne(postNum);
        System.out.println("寃뚯떆湲� �긽�꽭議고쉶, 湲�踰덊샇 " + postNum + "踰덉쓣 �샇異쒗빀�땲�떎.");
        return boardvo;
    }

    @Override
    public List<String> getAttach(Long postNum) {
        return writedao.getAttach(postNum);
    }

    @Override
    public void deleteWrite(Long postNum) {
        writedao.deleteWrite(postNum);
    }

    @Override
    public void modifyWrite(BoardVO boardvo) {
    	 System.out.println("modify POST �샇異쒕맖");
        // 1) 寃뚯떆湲� �궡�슜 癒쇱� �닔�젙
        writedao.modifyWrite(boardvo);
        
        // 2) 湲곗〈 泥⑤��뙆�씪 �궘�젣 (postNum 湲곗�)
        writedao.deleteAttach(boardvo.getPostNum());
        
        // 3) �깉 泥⑤��뙆�씪 insert
        List<String> filenames = boardvo.getFilename();
        if (filenames != null) {
            for (String filename : filenames) {
                Map<String, Object> params = new HashMap<>();
                params.put("postNum", boardvo.getPostNum());
                params.put("filename", filename);
                writedao.attachFname(params);
            }
        }
    }

	@Override
	public void viewCount(Long postNum) {
		writedao.viewCount(postNum);
		
		
	}

	@Override
	public void addCommentWrite(CommentVO commentvo) {
        writedao.insertCommentWrite(commentvo);
	}

	@Override
	public List<CommentVO> getComments(Long postNum) {
		List<CommentVO> commentList = writedao.selectAllComment(postNum);
		return commentList;
	}

	@Override
	public boolean deleteComment(int commentId, String userId) {
		return writedao.deleteComment(commentId, userId);
	}

	@Override
	public boolean updateComment(int commentId, String content, Long postNum) {
		return writedao.updateComment(commentId, content, postNum);
		
	}

	@Override
	public void addCommentReply(CommentVO commentvo) {
	    // 부모 댓글 정보 조회
	    Integer parentCommentId = commentvo.getParentCommentId();
	    // 부모 댓글이의 id가 널이 아니면
	    if (parentCommentId != null) {
	        CommentVO parentComment = writedao.getCommentById(parentCommentId);
	        if (parentComment != null) {
	            // 대댓글의 depth를 부모 댓글의 depth + 1로 설정
	            commentvo.setDepth(parentComment.getDepth() + 1);
	            // postNum은 클라이언트에서 전달받은 값을 우선 사용하거나, 부모 댓글 값으로 보완
	            if (commentvo.getPostNum() == null) {
	                commentvo.setPostNum(parentComment.getPostNum());
	            }
	        } else {
	            // 부모 댓글이 존재하지 않는 경우 (예외 상황)
	            commentvo.setDepth(1);
	        }
	    }
	    // 대댓글 저장
	    writedao.addCommentReply(commentvo);
	}

	

		
		
		
	

	

	

}
