package www.silver.hom;



public class Test {

	public static void main(String[] args) {

		String[][] wdata={{"apple","cherry","date","elderberry","fig","grape","cherry","honeydew","kiwi","lemon","mango","orange","papaya","quince","raspberry","strawberry","tangerine","ugli fruit","vanilla","watermelon"},
				{"사과","체리","대추야자","엘더베리","무화과","포도","체리","허니듀","키위","레몬","망고","오렌지","파파야","모과","산딸기","딸기","귤","우글리과일","바닐라","수박"}};
		// 영단어와 한글뜻 20개가 담긴 2차원 배열 생성


		//배열의 단어중 5개의 단어와 뜻을 랜덤으로 출력하기
		int[] randomIndex = new int[5]; // 랜덤으로 선택된 단어의 인덱스를 저장할 배열
		int count = 0; // 랜덤으로 선택된 단어의 개수를 세기 위한 변수
		while (count < 5) { // 5개의 단어가 선택될 때까지 반복
			int index = (int) (Math.random() * 20); // 0부터 19까지의 랜덤 인덱스 생성
			boolean isDuplicate = false; // 중복 여부를 확인하기 위한 변수
			for (int i = 0; i < count; i++) { // 이미 선택된 단어와 중복되는지 확인
				if (randomIndex[i] == index) {
					isDuplicate = true; // 중복된 경우
					break;
				}
			}
			if (!isDuplicate) { // 중복되지 않은 경우
				randomIndex[count] = index; // 랜덤 인덱스를 저장
				count++; // 선택된 단어 개수 증가
			}
		}
		// 랜덤으로 선택된 단어와 뜻 출력	
		for (int i = 0; i < 5; i++) {
			System.out.println(wdata[0][randomIndex[i]] + " - " + wdata[1][randomIndex[i]]);
		}

	}
}