-- 정렬방법 -> ORDER BY  (155page)
/*
  SELECT ~
  FROM table_name
  ORDER BY 컬럼 ASC|DESC
		 -----
		1. 컬럼명
		2. 컬럼의 위치번호 (1번부터 시작)
		3. 함수
  
- *로 전체를 가져온다면
  SELECT *
  FROM emp        empno,ename,job,mgr,hiredate,sal,comm,deptno
				1    2      3     4        5      6     7        8


- 컬럼리스트로 가져온다면
		 1        2      3      4        5
  SELECT empno,ename,sal,deptno,hiredate
  FROM emp

- 이중정렬 -> 대댓글
  ORDER BY sal,ename
    -> sal 먼저 정렬후 sal이 같은 값을 가지고 있는 데이터끼리만 ename정렬 
*/

-- 집계함수 (157page) => GROUP BY, JOIN, Sub Query
/*
  내장 함수: 오라클 라이브러리 -> 이미 만들어져 있는 함수
	|
  단일행 함수: ROW 단위
			4장: 문자 함수 / 숫자 함수 / 날짜 함수 / 변환 함수 / 기타 함수
 집합(집계)함수: COLUMN단위
		       단일함수, 컬럼을 사용할 수 없다
		       컬럼사용시에는 반드시 GROUP BY가 존재
 
 *** 단일행과 집합 함수는 같이 사용할 수 없다

   집계함수
     - SUM: column의 총합 -> 장바구니 / 구매금액
     - AVG: column의 평균 -> 전체 구매자의 평균 금액 / 통계 , 관리자체이지에서 많이 등장
     - MIN: column 최소값
     - MAX: column의 최대값 -> 자동 증가번호(중복이 없이)
     - COUNT: column의 갯수-> 로그인 / ID 중복체크 / 검색결과
     - RANK(): 순위 출력
     - DENSE_RANK(): 순위 출력

      1등 2등 2등 4등 -> RANK()
      1등 2등 2등 3등 -> DENSE_RANK()

      - GROUP BY -> CUBE / ROLLUP
*/
/*
(142page ~ 159page)
   코딩 순서: SELECT - FROM - WHERE - GROUP BY - HAVING - ORDER BY
   실행 순서: FROM - WHERE - GROUP BY - HAVING - SELECT - ORDER BY
  1. 연산자 -> WHERE: 조건 검색
	오라클에서 제동하는 연산자
	 = 산술연산자 (+, - , *, /) => 산술만 처리
		'10' +1 => 자동으로 정수형으로 변경되어 11로 나온다
		--- TO_NUMBER('10')
		/ : 0으로 나누면 오류가 발생
		    정수 / 정수 = 실수
		SELECT 뒤에서 통계(총합 / 평균) 

	 = 비교연산자 ( = , != <> ^=, <, >, <=, >=)
	      	ture / false -> WHERE뒤에서 조건 처리
		WHERE 컬럼  연산자   값
			    sal      >     1000
		*** 같지않다는 <> 사용이 권장

	 = 논리 연산자 (OR, AND, NOT)
		AND는 범위, 기간 포함
		OR는 범위,기간 미포함
		NOT는 부정 -> NOT IN , NOT BETWEEN, NOT LIKE
		(조건) AND (조건) => 두개의 조건이 true일때
		(조건) OR (조건) => 둘중 하나라도 true면 true
   	 = BETWEEN ~ AND연산자: AND를 보완
		BETWEEN 10 AND 20 -> 10과 20도 포함된다
		페이징시 사용 -> 최근에는 LIMIT을 지원
		AUTO_INCREMENT -> 자동증가
	 = IN 연산자
		IN(값1,값2...) -> 값을 포함하고 있는 데이터 추출
		OR가 여러개인경우 / 다중 조건 검색시 많이 사용
	 = NULL 연산자
		모든 연산시 null값이 있는경우 연산처리가 불가능
		IS NULL 
		IS NOT NULL
	 = LIKE 연산자
		유사 문자열 검색
		패턴 -> % 문자 제한이 없다 ,  _ 한글자
		검색어% -> startsWith
		%검색어 -> endsWith
		%검색어% -> contains

  2. 정렬 -> ORDER BY
	- 마지막 순서
	ORDER BY 컬럼 ASC|DESC
	ASC는 생략이 가능
	ORDER BY 컬럼1,컬럼2 -> 컬럼1에 같은 값이 있는 경우만 컬럼2 정렬
	컬럼 대신 번호 사용 가능(컬럼의 위치 번호)  1번부터 시작
	
  3. 집계함수 
	COUNT -> ROW의 갯수
	MIN / MAX -> 최소값 / 최대값 (단일행 함수/컬럼을 같이 사용할 수 없다) 단, 사용시 GROUP BY를 사용하면 가능
	SUM -> column의 총합
	AVG -> column의 평균
	RNAK() / DENSE_RANK() -> 순위 

*/
