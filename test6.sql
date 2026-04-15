-- 오라클 3일차 (내장 - 단일행 함수 / GROUP BY / JOIN)
-- SELECT문장 (검색) => 연산자 / 집계함수 / Group By / JOIN / Sub query
-- DDL (table. 데이터형) => INSERT / UPDATE / DELETE
/*
   내장함수: 라이브러리 (오라클에서 지원하는 함수)
				내장함수
				      |
		     |-------------|--------------------------|PL / SQL
		집계함수  단일행 함수     사용자 정의 CREATE FUNCTION func_name(매개변수..)
		----------	-----------
	      column단위   row 단위
	 
		=> row 갯수: count
		=> row 전체 최대값, 최소값: max,min
  		=> row의 총합, 평균: sum, avg
		=> 순위: rank, dense_rank
		-------------------------------------------------
		=> row 한개 계산 : rollup
		=> row/column : cube
		-------------------------------------------------Group by가 존재

		** 오라클은 오류가 나더라도 다음줄로 넘어가는 비절차적이다.
		단일행 함수
		 1. 문자함수
			= LENGTH / LENGTHB -> 문자열의 갯수 / 문자의 바이트 수
			   LENGTH('ABC')  ===> 3
			   LENGTH('홍길동')   ==> 3
			   LENGTHB('ABC')  ===> 3
			   LENGTHB('홍길동')   ==> 9 한글은 한글자당 3byte

			= LPAD / ***RPAD
			   LPAD(문자열,글자수,'변경할 문자')
			   LPAD('KING',5,#) -> #KING -> 남으면 #을 붙힌다
			   LAPD('KING',5,#) -> KIN
			   LPAD / ***RPAD
			   RPAD(문자열,글자수,'변경할 문자')
			   rPAD('KING',5,#) -> KING#
			   RAPD('KING',5,#) -> KIN 

			= UPPER / LOWER/ INTCAP
			   UPPER('문자열') -> 대문자로 출력
			   UPPER('abc') -> ABC
			   LOWER('문자열') -> 소문자로 출력
			   LOWER('ABC') -> abc
			   INTCAP('문자열') -> 첫자만 대문자
			   INTCAP('king') -> King

			= ****REPLACE: 변경 (크롤링시 &가 들어오면 변경해줄때 주로 사용)
			   REPLACE(문자열,찾는 문자, 변경할 문자)
			   REPLACE('Hello Java','a','b') -> Hello jbjb
			   REPLACE('Hello Java','Java','Oracle') -> Hello Oracle

			= TRIM: 공백 / 특정 문자 제거 (자바는 공백만 제거)
			    LTRIM(),RTRIM(),TRIM()
						   |좌우 제거
					| 오른쪽 제거
			    |왼쪽만 제거
			    LTRIM('문자열'), LTRIM('문자열','제거할 문자')
			    | 왼쪽 공백 제거  | 왼쪽 문자 제거
			    RTRIM('문자열'), RTRIM('문자열','제거할 문자')
			    | 오른쪽 공백 제거  | 오른쪽 문자 제거
			    TRIM: 좌우 공백 제거
		            TRIM('문자열')	->  공백 제거  
			    TRIM(문자 FROM 문자열')
			 = ASCII / CHR
					| 숫자를 문자로 변환
				| 문자를 숫자로변환
			    ASCII('A') -> 65
			    CHR(65) -> 'A'
			
				가장 중요
			 = *****SUBSTR / **INSTR / CONCAT
							| 문자열 결합 -> ||  => '%'||?||'%'    Oracle
										CONCAT('%',?'%') Mysql
					    | 문자 위치 (indexOf)
				| 문자열 자르기 (substring)
			    SUBSTR(문자열,시작위치,갯수) -> 문자번호는 1부터 시작 
			    1 2 3 4 5 6 7 8 9
				    -----
			     -> SUBSTR('123456789'4,3) 4번부터 3글자를 자른다 (자바는 시작위치부터, 자를위치 미만)
			    SUBSTR('ORACLE'1,3) => ORA
			    INSTR(문자열,찾을문자,시작위치,몇번째) -> 위치를 리턴
							   --------- 양수면 앞에서부터 indexOf
							   --------- 음수면 lastindexOf
			    H e l l  o    J a  v a
			    1 2 3 4 5 6 7 8 9 10
			    INSTR('Hello Java','a',1,2) -> 10번 a를 찾아온다 
			    CONCAT: 문자열 결합 => ||
			    CONCAT('문자열','결합될 문자열')
			    CONCAT('Hello ','Oracle') -> Hello Oracle

			    --------중요 함수---------
			    ***LENGTH: 문자의 갯수
			    ***SUBSTR: 문자 자르기
			    ***INSTR: 문자 번호 검색
			    ***RPAD: 문자 채우기
			    ***REPLACE: 문자 변경
			--------------------------------------> 웹 개발자: String

		 2. 숫자 함수(211page)
			= MOD: %로 나누고 나머지 값
			    -> MOD(10,2) 10 % 2 => 0
			= CEIL: 올림함수
			   -> 보통 총 페이지 구할떄 사용
				CEIL(9.1) => 10        
			---------------------------
			= TRUNC: 버림함수
			   -> TRUNC(9.8) => 9
			= ROUND: 반올림
			   -> ROUND(9.8) => 10
			---------------------------> 날짜(long 형) 계산시 많이 사용 
			---------------------------------------> 웹 개발자: Math

		 3. 날짜 함수
			***= SYSDATE: 시스템의 날짜 / 시간 => 숫자형으로 되어있다
			    어제: SYSDATE -1 / 내일: SYSYDATE + 1 
			    등록일 자동처리

			***= MONTH_BETWEEN(현재,과거): 총개월 -> 근무개월 수

			= ADD_MONTHS : 금융권
			   적금 3년 / 보험
			   ADD_MONTHS('26/03/03',7) 26/03/03일부터 7개월 후

			= LAST_DAY(SYSDATE): 해당 달의 마지막 날짜

			= NEXT_DAY(날짜,요일'):날짜의 다음 돌아오는 요일

		 4. 변환 함수
			***= TO_CHAR: 숫자나 날짜를 문자열로 변환
			         -> 자바에서 Date사용시 SimpleDateFormat -> 입력시간: 000000
				 -> 숫자변환 1000 => 1,000   (자바에서는 ###,###   여기서는 999,999)
				 ->  년도: YY / YYYY
					월: MM
					일: DD
					시: HH / HH24
					분: MI
					초: SS
					요일: DAY
			= TO_NUMBER: 문자를 숫자로 변환  (자바의 integer.ParseInt가 있으니 많이 사용x)
				-> TO_NUMBER('10') => 정수형 변환 (자동변환이 되어 많이 사용하지 않는다)
				-> SELECT '10' + 1 FROM DUAL => 11 (속도가 느려 TO_NUMBER 사용을 권장)
			= TO_DATE: 문자를 날짜형으로 변환 
				-> 생년월일 입력, 예약 날짜 => 문자열로 되어있어 날짜형으로 변환 필요
				
			VARCHR2 / DATE / NUMBER

		 5. 기타 함수
			= NVL: null값이 있는 경우 다른 값으로 변경 (대체)
				-> NVL(comm,0) comm이 null이면 comm값을 0으로 변경	
				-> 대체되는 값과 대체하는 값의 데이터형이 일치해야한다 
				-> '' -> null , ' ' -> 공백   (띄어쓰기 주의)	
				-> 자동 증가 번호: SELECT NVL(MAX(no)+1,1) FROM board (맨처음 값이 null이기 때문에)

			= DECODE: 선택문   /   CASE: 다중 조건문
			   | 한개의 값을 지정      | 범위를 지정
			    					-> CASE: 조건식 다양하게 사용이 가능(연산자) <, >, BETWEEN ~ AND (실무에서 많이 사용되는 문장)
			    					-> CASE는 TRIGGER에 많이 사용 
			   					-> 부서별 보너스 계산, 호봉 및 연차 계산
								-> CASE 
									 WHEN 조건 THEN 값 
									 WHEN 조건 THEN 값 
									 WHEN 조건 THEN 값 
									 ELSE 값
								     END as 별칭

			------------------------------------------
				    DECODE	     CASE
			------------------------------------------
				=만 사용 가능   	모든 조건 연산
			-------------------------------------------
				가족성이 낮다	가독성이 높다
			-------------------------------------------
				단순값 비교	복잡한 조건
			--------------------------------------------

	** 형식 = 순서 = 라이브러리 = 활용
	
	=> SQL
		1. DQL (데이터 검색): SELECT
			-> SELECT * | colun_list
			     FROM table_name
			     [
				WHERE  ------------연산자 (true / false)
				GROUP BY ---------함수
				HAVING  -----------집계함수
				ORDER BY ----------컬럼 / 컬럼 순서
			     ]

		FROM - WHERE - GROUP BY - HAVING - SELECT - ORDER BY

	연산자
	   - 산술 연산자 => ROW 단위 통계 (+, -, / , *) 
		+ : 덧셈, /: 정수/정수 = 실수
	   - 비교 연산자 =>  =, !=(<>,^=), <, >, <=, >=
	           ** 숫자, 문자, 날짜 비교 가능
	   - 논리 연산자 => AND, OR, NOT
	   - BETWEEN ~ AND => 기간, 범위
	   - IN (OR 대체)
	   - NULL => 연산처리가 안된다 => IS NULL , IS NOT NULL
	   - LIKE => _(한글자), %(여러개)
		** startsWith: A%, endsWith: %A, contains: %A%
	
	함수
	  - 단일행 함수
		= 문자 함수
			LENGTH
			SUBSTR
			INSTR
			RPAD
		= 숫자 함수
			CEIL
			ROUND
			TRUNC
			MOD
		= 날짜 함수
			SYSDATE
			MONTH_BETWEEN
		= 변환 함수
			TO_CHAR
			TO_DATE
		= 기타 함수
			NVL
			CASE  ( ! WHEN ~ THEN ~ ELSE)
	  - 집계 함수
		= COUNT: ROW의 갯수
		= MAX / MIN: COLUMN의 최대값 / 최소값
		= SUM / AVG: COLUMN 전체의 합 / 평균
		= RANK() / DENSE_RANK():  건너뛰기 순위 /  순차적 순위

*/

