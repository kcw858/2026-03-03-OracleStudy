-- 2026-04-17 DDL (179page) : 데이터 정의어

/*
   SQL 
     ==> DML의 단위는 ROW
     DML: 제이터 조작어(처리) => SELECT: 데이터 검색
					       INSERT: 데이터 추가
					       UPDATE: 데이터 수정
					       DELETE: 데이터 삭제
					       --------------------------CRUD
     ==> DDL의 단위는 Column
     DDL: 데이터 정의어 => CREAT: 생성
					- TABLE : 데이터를 저장하는 공간
					- SEQUENCE : 자동 증가 번호(게시판의 번호)
					- VIEW : 가상 테이블 -> SELECT 저장
					- INDEX : 검색 최적화, 빠른 정렬
					- FUCTION / PROCEDURE / TRIGGER : 5장
					==> AutoCommit
				      ALTER: 추가 / 수정 / 삭제
					- ADD / MODIFY / DROP
				      DROP: 전체 삭제
				      RENAME: 테이블 이름 변경
				      TRUNCATE: 삭제 => 테이블은 유지
						       ----- 데이터만 삭제 
     = 테이블을 만드는 방법 => 식별자
	------- class => 멤버변수: column  객체: row
        1) 문자로 시작한다(알파벳,한글): 운영체제 호환문제로 알파벳으로 쓰는게 좋다
	   **대소문자 구분이 없다 (오라클 자체에 저장 => 대문자로 저장)
	   ** user_tables에 저장
	2) table명, column명 => 문자의 갯수는 30byte까지 (한글 10글자)
	   -> 보통 7~15자 (freeboard, goods_list)
	   -> column이름을 table명으로 사용해도 된다
	3) 같은 데이터베이스(XEL)에서는 테이블명이 유일해야 된다
	4) 키워드는 사용할 수 없다
	   -> SELECT , ORDER, BY ....
	5) 숫자는 사용이 가능하지만 앞에 사용 금지
	6) 특수문자 사용이 가능(_,$) => _를 주로 사용

	형식)
		CREATE TABLE table_name(
			컬럼명 데이터형 [제약조건], 
			-------식별자
			컬럼명 데이터형 [제약조건],
			컬럼명 데이터형 [제약조건]
			제약조건
			제약조건
		);

     1. 오라클에서 지원하는 데이터형
	  1) 문자형: 문자를 저장하거나 문자열 저장 ====> String
		- CHAR
		    = 고정바이트
		    = 1byte ~ 2000byte까지 사용 가능
		    = 일정한 값 (남자 / 여자 , 우편번호....)
		    = 성별 / (user/admin) -> y/n
		    = 한글은 한글자당 3byte
		    = CHAR(10) => 'y' 
			--------------------
			y \0 \0 ..........		
			-------------------- 메모리 누수
		- VARCHAR2
		    = 가변 바이트: 입력한 글자 수 만큼 메모리 할당 (메모리 누수 방지)
		    = 1byte ~ 4000byte
		    = 문자열에서 가장 많이 사용되는 데이터형
		    = 반드시 byte수 지정
		    = VARCHAR2(100)
		    = 이름 , 주소, 전화번호, 이미지(http)
		- CLOB
		    = 가변 바이트
		    = 4GB
		    = 글자가 많은 경우
		    = 줄거리 , 자기소개, 게시판의 내용, 레시피 방법

	  2) 숫자형: 정수, 실수 =====> int, double
		- NUMBER
		    = default는 NUMBER(8,2) => NUMBER(38,128)
				     --------------- 정수는 8자리 사용가능
				     --------------- 실수면 정수 6자리 소수점 2자리
				     NUMBER(2,1) -> 0~99 / 0.0~9.9
		    = NUMBER(10) ==> 10자리까지 사용 가능
		    = NUMBER(10,2) ==> 10자중 소수점으로 2자리 사용 가능
		    = int / double

	  3) 날짜형: DATE => SYSDATE ======> java.util.Date
		- DATE
		    = 문자형식으로 저장: yy/mm/dd
		- TIMESTAMP
		    = 기록경주 (잘 사용하지않음)

	  4) 기타: 이미지, 동영상 ... (보통 증명사진)
		- DFILE / BLOB
			     ------
			     4G -> binary형식으로 저장 (자바에서는 InputStream으로 받는다)
		  ------
		  4G -> File 형식으로 저장
	------------------------------------------------------------
	자바 매핑 => ~VO
	CHAR , VARCHAR2 , CLOB => String
	NUMBER => int / double
	DATE => java.util.Date
	BFILE, BLOB => InputStream
	------------------------------------------------------------

     2. 테이터 유지 = 제약조건
	= 정형화된 데이터 : 규칙에 맞게 저장 -> 바로사용이 가능
				    구분이 잘되어 있다 -> 데이터베이스
	= 반정형화 데이터 : 구분된 데이터 -> XML, HTML, JSON (크롤링)
	= 비정형화 데이터 : 규칙도없고 구분도 없는 데이터 => 트위터, facebook
	----------------------------------------------------------------------------------------> 이 데이터들을 분석해 필요한 데이터만 정형화된 데이터로 변경

	 - 웹사이트에 출력된 데이터는 정형화된 데이터이다
	   --------- 데이터베이스에서 출력
	
 	제약조건
	  - 반드시 입력값을 필요로 하는 경우 
	       1) NOT NULL
		 - name VARCHAR2(20) NOT NULL
	  - 중복이 없는 값 추가
	       2) UNIQUE : null 허용
		 - email / phone: 후보키
	       3) NOT NULL + UNIQUE
		 - ROW 구분자: 숫자(자동처리), ID
		 - PRIMARY KEY: 데이터 무결성 -> 테이블 제작시 반드시 1개 이상 추가
               4) 다른 테이블과 연결: 외래키 / 참조키
		 - FOREIGN KEY : 반드시 PRIMARY KEY와 연결
	       5) 지정된 테이터만 출력
		 - CHECK : radio / select(콤보) -> 부서명 / 근무지 / 장르 ....
	       6) DEFAULT : 미리 데이터 설정
		 - regdate DATE DEFAULT SYSDATE 
		 - hit NUMBER DEFAULT 0
	    - 컬럼에서 제약조건을 여러개 사용 가능
	    - 테이블 안에서 PRIMARY KEY 한개 설정이 가능, 나중에 설정시에 여러개 설정이 가능

	제약조건
	  NOT NULL
		=> 컬럼 데이터형 NOT NULL
		=> 컬럼 데이터형 CONSTRAINT 제약조건명 NOT NULL (유지보수 측면에서 권장)	
	
	  UNIQUE
		=> 컬럼 데이터형 UNIQUE
		=> 컬럼 데이터형 ,
		      CONSTRAINT 제약조건명 UNIQUE(컬럼명)
	  CHECK
		=> 컬럼 데이터형 CHECK(컬럼명 IN(...))
		=> 컬럼 데이터형 ,
		      CONSTRAINT 제약조건명 CHECK(컬럼명 IN(...))
	
	   PRIMARY KEY
		=> 컬럼 데이터형 PRIMARY KEY
		=> 컬럼 데이터형 ,
		      CONSTRAINT 제약조건명 PRIMARY KEY(컬럼명)

	   FOREIGN KEY
		=> 컬럼 데이터형,
		      CONSTRAINT 제약조건명 FOREIGN KEY(컬럼명)
		      REFERENCES 참조테이블(참조컬럼)
		
	   DEFAULT
		=> 컬럼 데이터형 DEFAULT 값
			    ----------
				VARCHAR2(1~4000byte), CLOB(4G), CHAR(1~2000byte)
				NUMBER => 8,2
				DATE

	   형식
		CREATE TABLE table_name
		(
			컬럼명 데이터형 [제약조건][제약조건] ... , => NOT NULL, DEFAULT
			컬럼명 데이터형 [제약조건][제약조건] ... ,
			컬럼명 데이터형 [제약조건][제약조건] ... ,
			[제약조건], => PK, UK, CK, FK
			[제약조건]
		);

		DEFAULT 우선 -> 다음 제약조건
*/

CREATE TABLE aaa(
	name VARCHAR2(10) CONSTRAINT aaa_name_nn NOT NULL DEFAULT '홍길동'
);
->오류구문 (DEFAULT는 제약조건 앞에 적어야한다)

