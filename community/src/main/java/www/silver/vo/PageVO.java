package www.silver.vo;

public class PageVO { 	
	private int startNo;// 시작번호
	private int endNo;// 끝번호
	// 게시판에서 페이지를 나누기 위해서 필요한 변수들
	private int perPageNum=10;// 페이지당 게시물 수
	private Integer page; // Integer 웹에서 받은 페이지 정보(String)가 없으면 null인데 int는 null을 저장할 수 없다. 오류방지
	private int totalCount; // 전체 게시물 수
	private int endPage;// 마지막 페이지 번호
	private int startPage;// 첫 페이지 번호
	private boolean prev;// 이전 페이지 여부
	private boolean next;// 다음 페이지 여부
	// 검색용 변수 2개 추가
	private String searchType;// 검색타입
	// 검색타입은 게시판에서 검색할 때 어떤 항목으로 검색할 것인지
	private String searchKeyword;// 검색어
	// 검색어는 게시판에서 검색할 때 어떤 단어로 검색할 것인지
	public int getEndNo() {
		return endNo;
	}

	public void setEndNo(int endNo) {
		this.endNo = endNo;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	private void calcPage() {
	// 페이지 계산 메소드
		startNo = (this.page - 1) * perPageNum +1; 
		// 1페이지 1~10, 2페이지 11~20, 3페이지 21~30
		int tempEnd = (int) (Math.ceil(page / (double) this.perPageNum) * this.perPageNum);
		// 페이지당 게시물 수로 나누고 올림을 구해서 곱하기 페이지당 게시물 수
		// 1/10=0.1  > 1   10
		// 6/10=0.6  > 1   10
		// 11/10=1.1  > 2   20

		this.startPage = (tempEnd - this.perPageNum) + 1;	// 시작페이지
		// 1페이지 1, 2페이지 11, 3페이지 21
		if (tempEnd * this.perPageNum > this.totalCount) {	// 전체게시물 수보다 크면
			this.endPage = (int) Math.ceil(this.totalCount / (double) this.perPageNum);	
			// 마지막페이지
			if(endPage!=page) {// 마지막페이지가 아니면
				this.endNo = startNo + this.perPageNum - 1;	// 끝번호는 시작번호와 페이지당 게시물 수로 계산한것에 -1을 해준다.
				// 1페이지 10, 2페이지 20, 3페이지 30
			}else {// 마지막페이지면
				this.endNo = startNo + this.totalCount % 10 - 1;// 끝번호
			}
		} else {			// 전체게시물 수보다 작으면
			this.endPage = tempEnd;// 마지막페이지
			this.endNo = startNo + this.perPageNum - 1;// 끝번호
		}
		
		this.prev = this.startPage != 1;// 이전페이지 여부
		// 1페이지가 아니면 이전페이지가 있다.
		this.next = this.endPage * this.perPageNum < this.totalCount;// 다음페이지 여부
		// 마지막페이지 * 페이지당 게시물 수가 전체게시물 수보다 작으면 다음페이지가 있다.
		
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcPage();// 페이지계산 메소드 호출
		// setTotalCount가 호출되면 calcPage()를 호출해서 페이지계산을 한다.
		// totalCount 전제게시물개수가 있어야지 페이지계산을 할 수 있기 때문에
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public int getStartNo() {

		return startNo;
	}

	public void setStartNo(int startNo) {
		this.startNo = startNo;
	}

	public int getPerPageNum() {
		return perPageNum;
	}

	public void setPerPageNum(int perPageNum) {
		this.perPageNum = perPageNum;
	}
}