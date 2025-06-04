package www.silver.dao;

import java.util.List;
import java.util.Map;
import www.silver.vo.BoardVO;
import www.silver.vo.CommentVO;

public interface IF_writeDAO {

    // ���ο� �Խñ��� �����ͺ��̽��� ����
    public void insertWrite(BoardVO boardvo);

    // �Խñۿ� ÷�ε� ���ϸ��� �����ͺ��̽��� ����
    public void attachFname(Map<String, Object> params);

    // ��� �Խñ� ����� ��ȸ
    public List<BoardVO> selectall();

    // ����¡ ó���� ���� Ư�� ������ �Խñ� ����� ��ȸ
    public List<BoardVO> pagingList(Map<String, Integer> pagingParams);

    // ��ü �Խñ� ���� ��ȯ (����¡ ����)
    public int boardCount();

    // Ư�� �Խñ� ��ȣ�� �ش��ϴ� �Խñ� �� ������ ��ȸ
    public BoardVO selectOne(Long postNum);

    // Ư�� �Խñۿ� ÷�ε� ���� ����� ��ȸ
    public List<String> getAttach(Long postNum);

    // Ư�� �Խñ��� ����
    public void deleteWrite(Long postNum);

    // Ư�� �Խñ��� ������ ����
    public void modifyWrite(BoardVO boardVO);

    // Ư�� �Խñۿ� ÷�ε� ������ ����
    public void deleteAttach(Long postNum);
    
    // Ư�� �Խñ��� ��ȸ���� ����
    public void viewCount(Long postNum);

    // ���ο� ����� �����ͺ��̽��� ����
    public void insertCommentWrite(CommentVO commentvo);

    // Ư�� �Խñۿ� �޸� ��� ��� ����� ��ȸ
    public List<CommentVO> selectAllComment(Long postNum);

    // Ư�� ����� ���� (�ۼ��� Ȯ�� �� ���� ���� ��ȯ)
    public boolean deleteComment(int commentId, String userId);

    // Ư�� ����� ������ ���� (���� ���� ���� ��ȯ)
    public boolean updateComment(int commentId, String content, Long postNum);

    // Ư�� ��� ID�� �ش��ϴ� ��� ������ ��ȸ (���� �ۼ� �� �θ� ��� ���� Ȯ�ο�)
    public CommentVO getCommentById(int parentCommentId);

    // ������ �����ͺ��̽��� �߰�
    public void addCommentReply(CommentVO commentvo);

	
}
