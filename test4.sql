-- 오라클 2일차 => WHERE / ORDER BY
-- WHERE 조건 => 연산자 / 정확한 검사 -> 내장함수 (단일 함수,집계함수)
-- 145page
-- GROUP BY / JOIN / SubQuery => SELECT
-- DDL(Table) => INSERT / UPDATE / DELETE
-- 고급: View / Index / Sequence / PL/SQL
-- 데이터베이스 설계 (ER-MODEL) / 정규화
-- 트랜잭션 / 보안 / 복원 / 백업
/*
  오라클: 경우의 수가 많다 (SQL문장 여러개가 존재한다)
     => 결과값 출력에 집중 후 최적화
  SQL: 구조화된 질의언어
	  ------ 문장형식: 순서 / 형식
		  ----------> 결과값이 같은 여러개를 사용할 수 있다
 	= DML: 데이터 조작언어
	    - SELECT: 데이터 검색 (웹의 70%)
	    - UPDATE: 데이터 수정
	    - INSERT: 데이터 추가
	    - DELETE: 데이터 삭제
	= DDL: 데이터 정의언어 => TABLE(데이터 저장장소)	
					       VIEW(가상 테이블) -> 보안 / 단순한 쿼리
						 -> SELECT ~
					       SEQUENCE: 자동증가 (PRIMARY KEY)
					       INDEX: 검색,정렬 -> 속도의 최적화
					       --------------------------------------------------
					       FUNCTION: 사용자 정의 함수
					       PROCEDURE: 사용자 정의 함수 -> 기능
					       TRIGGER: 자동화 처리
					       --------------------------------------------------> PL/SQL => 재사용에 목적
	     - CREATE: 생성
	     - DROP: 삭제
	     - ALTER: 수정
	     - TRUNCATE: 데이터만 잘라내기
	     - RENAME: 이름 변경
	= DCL: 권한부여 / 해제
	     - GRANT: 권한 부여
	     - REVOKE: 권한 해제 => View / INDEX / 시노님 -> 권한이 없다
	= TCL: 정상 저장 / 모든 명령 취소 -> 일괄 처리
							    ----------> 트랜잭션
	     - COMMIT: 정상적으로 저장
	     - ROLLBACK: 명령 취소
	     - SAVEPOINT: 지정된 위치부터 취소

   1. SELECT: 데이터 검색
      = 형식 / 순서
	------------------------------------------------------------------------
	SELECT *|column_list(원하는 컬럼만 선택) 
	FROM table_name|view_name|SELECT(인라인 뷰)-> 보통 페이징
	------------------------------------------------------------------------> 필수
	[
		WHERE 조건
		GROUP BY 그룹컬럼
		HAVING 그룹에 대한 조건 -> 반드시 GROUP BY가 동반 되어야한다
		ORDER BY 컬럼 (ASC/DESC) -> ASC는 Default값이라서 생략가능
	]
	------------------------------------------------------------------------> 옵션

      = 처리 순서
	FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY

  	----------------------------------------------------
	데이터베이스: 윈도우 폴더와 같다
	----------------------------------------------------
	테이블: 파일
	----------------------------------------------------
	컬럼: 멤버변수
	----------------------------------------------------
	ROW(튜플): 인스턴스 -> 초기화된 객체
	----------------------------------------------------
	**컬럼으로 구분이 되어있어 관리하기 쉽다
	**명령어가 있어 읽기 쓰기 편리
	**조건 -> 검색 => WHERE 컬럼명 연산자 값 (if문)
							------

-- SELECT 사용법

/*
    1. 전체 데이터를 읽기 ========> *
    2. 출력에 필요한 내용만 읽기 ====> column_list
    3. 중복이 없이 출력 ====> DISTINCT
    4. 별칭 => Mybatis (함수)  ====> 컬럼 "", 컬럼 as 별칭
    5. 문자열 결합 =====> ||
    6. 문법사항
        - 대소문자 구분은 하지 않는다 
        - 실제 저장된 데이터는 대소문자를 구분
        - 문장이 종료되면 반드시 ; 세미콜론을 사용한다
        - 자바는 자동으로 ; 세미콜론이 찍힌다
        - 약속: 키워드는 대문자로 사용
*/
/*
-- 가급적이면 전체 검색은 사용하지 않는다
SELECT *
FROM book;
-- 출력에 필요없는 내용이 들어올 수  있다
-- 자바에서 사용시 setXxx를 이용해서 모든값을 받아야 한다
-- null값인 경우의 문제 -> 출력시 null

SELECT bookname,price
FROM book;

SELECT * 
FROM zipcode;

-- null값을 공백으로 변경
SELECT zipcode,sido,gugun,dong,NVL(bunji,' ')
FROM zipcode;

-- 보통 장르, 부서명, 직위를 가져올떄 사용
SELECT DISTINCT publisher
FROM book;

SELECT bookname||'은 출판사가'||publisher||'입니다' "msg"
FROm book;

-- alias 사용시 자동 대문자
SELECT bookname||'은 출판사가'||publisher||'입니다' as msg
FROm book;
*/

/*
   WHERE: 조건검색 => 가장 많이 사용되는 키워드
	       --------- TRUE/FALSE
		|  연산자 (149page)

      1. 산술연산자 (+, -, *, /) -> 나머지는 함수 (MOD())
	  +: 순수하게 덧셈만 가능
	  /:  0으로 나누면 오류발생
	      정수 / 정수 = 실수    ex) 5/2=2.5
	  SELECT 뒤에서 주로 사용
	  ** 연습용 테이블: DUAL
      2. 비교연산자 -> true / false => WHERE절 뒤에 (조건)
	  =: 같다
	  !=: 같지 않다, <>(권장), ^=
	  <: 작다
	  >: 크다
	  <=: 작거나 같다
	  >=: 크거나 같다
	  ** 숫자(정수,실수), 문자열, 날짜 비교 가능 
      3. 논리연산자 -> true / false => WHERE절 뒤에 (조건)
	  AND: &&를 사용하면 안된다 (&는 입력값을 받는 경우에 사용), AND는 포함된경우
	  OR: ||는 문자열 결합시 사용, OR는 미포함인 경우
	  NOT: !
		  NOT IN / NOT BETWEEN / NOT LIKE
	  (조건) AND (조건)
	    |		     |
	   ----------------
	      | 최종 결과

	  (조건) OR (조건)
	    |		     |
	   ----------------
	      | 최종 결과

      4. BETWEEN ~ AND ->  true / false (속도가 느려 권장하지않는다)
	  AND를 대체하는 연산자
	  WHERE 컬럼 BETWEEN 값1 AND 값2  ==   컬럼 >= 값1 AND 컬럼 <= 값2
	    -> 값1과 값2 사이의 값
	    -> 값1과 값2를 포함 (이상 미만)
      5. IN -> OR 여러개를 대체 (OR가 여러개면 IN연산자가 속도가 빨라 권장)
	  예) 
		부서번호가 10, 20, 30
		SELECT * 	
		FROM emp
		WHERE deptno = 10 OR deptno = 20 OR deptno = 30;

		SELECT * 	
		FROM emp
		WHERE deptno IN(10,20,30)
          -> 다중조건: checkbox시 주로 사용
      ***6. IS NULL, IS NOT NULL -> (Mysql은 ifnull)
	       null 값은 연산처리시 결과값이 null이다
	       ex) comm IS NULL    comm IS NOT NULL
	       ex) 이미지가 없는 맛집 -> 이미지 없음 출력 
      ***7. LIKE => SELECT 문장의 핵심은 검색 (자바의 contains)
	    유사 문자열 검색
	     % : 문자 갯수를 알 수 없을 때
	      _ : 문자 한글자
	    contains ===> %검색어%
	    startWith ===> 검색어%
	    endsWith ===> %검색어
	    == 5글자인데 가운데가 C -> __C__
	    == 3글자인데 A로 시작 -> A__
	    == REGEXP_LIKE(): 정규식
	    WHERE ename LIKE '%A%' OR ename LIKE '%B%' OR ename LIKE '%C%';
		=> WHERE REGEXP(ename,'A|B|C')	
	
	    사용자 대신 SQL문장을 만들어서 처리 -> 웹 개발자

*/

--산술 연산자
/*
	SELECT 10+5, 10-5, 10*5, 10/3
	FROM DUAL;

-- 숫자로 인식을 하지만 TO_NUMBER를 사용하지않으면 속도가 저하된다
	SELECT TO_NUMBER('10')+5,'10'-5, '10'*5,'10'/3
	FROM DUAL;

-- emp 사원 => 이달의 총 급여 => sal / comm => sal+comm
-- 연산자 처리 => null값이 있는경우 연산값이 null이다

	SELECT ename, sal, NVL(comm,0) as comm , sal+NVL(comm,0) "총급여"
	FROM emp;

-- 사원의 연봉
	SELECT ename, sal*12 "연봉"
	FROM emp;

	SELECT ename, (sal*12) / 12 "급여"
	FROM emp;
*/


-- 비교연산자
/*
    emp
     = empno 사번
     = ename 이름
     = job 직위
     = mgr 사수사번
     = hiredate 입사일
     = sal 급여
     = comm 성과급
     = deptno 부서번호 -> 부서정보(테이블)
    
    book
     = bookid 책번호
     = bookname 책이름
     = publisher 출판사
     = price 가격
*/
/*
-- 1. 급여가 1500 이상인 사원의 모든 목록을 출력
	SELECT *
	FROM emp
	WHERE sal >= 1500;

-- 2. 급여가 3000인 사원의 이름, 입사일, 직위, 급여 출력
	SELECT ename,hiredate,job,sal
	FROM emp
	WHERE sal = 3000;

-- 3. 직위가 CLERK이 아닌 사원의 모든 정보 출력
	SELECT *
	FROM emp
	WHERE job != 'CLERK';

-- 권장사항 <>
	SELECT *
	FROM emp
	WHERE job <> 'CLERK';

	SELECT *
	FROM emp
	WHERE job ^= 'CLERK';

-- 4. 81년 이전에 입사한 사원의 모든 정보 출력
	SELECT *
	FROM emp
	WHERE hiredate < '81/01/01'; -- 'YY/MM/DD'
	
SELECT *
FROM emp
WHERE TO_CHAR(hiredate,'YY') = 81;

SELECT *
FROM emp
WHERE SUBSTR(hiredate,1,2) = 81;


SELECT *
FROM emp
WHERE hiredate < '81/01/01' OR hiredate > '81/12/31';

SELECT *
FROM emp
WHERE NOT (hiredate >= '81/01/01' AND hiredate <= '81/12/31');


*/
SELECT *
FROM emp
WHERE TO_CHAR(hiredate,'YY') = 81;

SELECT *
FROM emp
WHERE SUBSTR(hiredate,1,2) = 81;


SELECT *
FROM emp
WHERE hiredate < '81/01/01' OR hiredate > '81/12/31';

SELECT *
FROM emp
WHERE NOT (hiredate >= '81/01/01' AND hiredate <= '81/12/31');

-- 직위가 CLERK이고 이름이 SMITH
SELECT * 
FROM emp
WHERE job='CLERK' AND ename='SMITH';

-- 부서번호 10 이거나 직위가 MANAGER
SELECT *
FROM emp
WHERE deptno=10 OR job='MANAGER';

-- 소문자면 찾지못한다 (저장된 데이터는 대소문자 구분)
SELECT * 
FROM emp
WHERE deptno=10 OR job='manager';

/*
   대입 연산자 : =
   구분 => WHERE에서 사용시 (같다)라는 의미
          그 외에서 사용시 대입
    UPDATE
     ename = '홍길동'
*/

-- BETWEEN ~ AND 연산자 (범위나 기간)

-- 급여가 1500이상 3000이하
SELECT *
FROM emp
WHERE sal >= 1500 AND sal <= 3000;

SELECT *
FROM emp
WHERE sal BETWEEN 1500 AND 3000;

-- price가 10000원 이상 30000이하
SELECT *
FROM book
WHERE price BETWEEN 10000 AND 30000;

-- price가 10000원 이상 30000이하가 아닌것
SELECT *
FROM book
WHERE price NOT BETWEEN 10000 AND 30000;

-- IN연산자

-- 사원이름이 KING, SMITH, SCOTT 검색

SELECT *
FROM emp
WHERE ename = 'KING' OR ename = 'SMITH' OR ename='SCOTT';

SELECT *
FROM emp
WHERE ename IN('KING','SMITH','SCOTT');

-- publisher가 굿스포츠, 대한미디어에서 출판한 모든 책정보
SELECT *
FROM book
WHERE publisher NOT IN('굿스포츠','대한미디어');

-- null 처리

-- 성과급이 없는 사원의 모든 정보
SELECT *
FROM emp
WHERE comm IS NULL;

-- 성과급이 있는 사원 / null값과 0원도 제외해야한다
SELECT *
FROM emp
WHERE comm IS NOT NULL AND comm <> 0;

-- LIKE문

-- 이름중에 A를 포함
SELECT ename
FROM emp
WHERE ename LIKE '%A%';

-- 이름중에 A로 시작
SELECT ename
FROM emp
WHERE ename LIKE 'A%';

-- 이름중에 EN / IN 으로 끝나는 이름
SELECT ename
FROM emp
WHERE ename LIKE '%EN' OR ename LIKE '%IN';

-- 5글자인데 가운데 글자가 O
SELECT ename
FROM emp
WHERE ename LIKE '__O__';

-- 3글자인데 가운데 글자가 A
SELECT ename
FROM emp
WHERE ename LIKE '__A%';

-- 책이름중 축구가 포함된 책정보 출력
SELECT *
FROM book
WHERE bookname LIKE '%축구%';

-- 책 제목중 두번째 글자가 '구' 
SELECT *
FROM book
WHERE bookname LIKE '_구%';

SELECT *
FROM customer;

SELECT *
FROM customer
WHERE phone IS NULL;

SELECT *
FROM  customer
WHERE address LIKE '대한민국%';
