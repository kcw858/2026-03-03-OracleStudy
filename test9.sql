/*
    JOIN 주의점
     1. 테이블 두개 필요한 데이터 추출 (조인)
     2. 컬럼명이 동일 또는 같은 값을 가지고 있는 경우
     3. 컬럼명이 동일시에는 반드시 테이블.컬럼 / 별칭.컬럼
						-------------------------없으면 애매한 정의 에러가 뜬다
     4. NATURAL JOIN, JOIN ~ USING: 같은 컬럼명이 존재해야하고 NON_EQUI_JOIN에서 사용이 불가능
     5. 조인 조건
	 => 같은 데이터를 가지고 있어야한다
		 영화 = 맛집	멜론 = 지니
			 | 지역		| 가수명 / 곡명
	 => SELECT 문장에서만 사용이 가능
	 => 오라클 조인          /          ANSI 조인
	      -------------			   -----------
	     FROM table1, table2	FROM table1 JOIN table2	
	     WHERE 조인 조건		ON 조인 조건

		=>조인 조건 외 다른 조건이 있는 경우 AND로 추가 
      6. 한쪽에만 데이터가 존재할경우 => OUTER JOIN
      7. 데이터 연결 추출
	 

   SQL문장 여러개 연결 => 서브쿼리 (170page)
	- 웹 개발자가 많이 사용하는 문장
	    -> 네트워크 통신
		 --------------- 전송 한번, 수신 한번 하는게 좋기때문에		
	- DML 전체에서 사용이 가능
	  ----- INSERT / UPDATE / DELETE
	- 종류
	    1. WHERE 뒤에 일반 서브쿼리 => 조건문 대신
	    2. SELECT 뒤에 스칼라 서브쿼리 *** (JOIN 대체) => 컬럼 대신
	    3. FROM 뒤에 인라인 뷰 *** => 테이블 대신	
				--------- 페이징
	
	SQL + SQL = 서브쿼리
	데이터 + 데이터 = JOIN


	=> WHERE 뒤에 일반 서브쿼리
		MAINQuery
		WHERE (SubQuery)
			    ------------ 결과값을 MAINQuery로 전송 후 결과값 출력
*/

-- 급여가 전체 평균보다 작은 사원의 정보
-- SELECT ~ WHERE sal = (평균)

/*
    교재 
	book: 책정보
	  bookid: 책 구분자 => 중복x ,PRIMARY KEY
	  bookname: 책 제목
	  publisher: 출판사
	  price: 가격
	customer: 회원
	  custid: id
	  name
	  address
	  phone
	orders: 구매 현황
	  orderid
	  custid
	  bookid
	  saleprice: 구매 금액
	  orderdate: 구매일

 1. 가장 비싼 가격의 책 제목 출력 170page
 SELECT MAX(price) FROM book;

 SELECT bookname FROM book WHERE price = (SELECT MAX(price) FROM book);
										| 실행 35000

테이블 여러개 = 테이터 통합: 조인
 SQL여러개 = 서브쿼리

EXISTS: 값이 있는지 여부 체크 -> 속도가 빠르다

서브쿼리는 테이블로 사용된다
*/
/*
SELECT empno, ename , job, hiredate, sal, rownum
FROM emp;
*/

-- EXISTS => ROW가 존재하는지
SELECT *
FROM emp e
WHERE EXISTS(
  SELECT 1 FROM emp WHERE deptno = 10
);

-- EXISTS는 같은 조건에 맞으면 ROW의 결과를 포함시켜준다

/*
  IN은 값 비교
  EXISTS는 존재여부만 파악 (성능을 최적화) -> 조건이 만족이 되면 TRUE -> 다음 문장을 수행하지 않는다

  ***단일행 서브쿼리 => 비교 연산자 주로 사용( =, <>, <, >, <=, >=)
			 => 기준값 한개를 주로 비교할 때 사용 (서브쿼리 결과가 1개인 경우)

  ***다중행 서브쿼리 => 결과값이 여러개인 경우
			 => IN, ANY, ALL, MAX, MIN
			 => 집합 데이터 처리

   인라인뷰 	/ 	스칼라 서브쿼리
 FROM(SELECT ~)	SELECT(SELECT ~)
 보안				조인을 대신

--------------------------------------------------------------

  단일행: 1개, 비교연산자, 기준값 기준
  다중행: 여러개의 값, IN연산자 사용, 집합비교
  다중컬럼:(col1,col2) 복합조건 (많이 사용되지는 않는다)
  EXISTS: 존재여부만 체크해 속도가 빠르다
  
  FROM: 테이블 대신
  스칼라: 컬럼 대신

  == 개념: SQL여러개를 한개로 만들어서 처리 (웹개발, 데이터베이스)
  == 사용처: 웹개발, 데이터베이스
  == JOIN: 테이블 + 테이블 => 컬럼 확장
	-----------------> 복잡한 쿼리문장이 있는경우 (가독성)
  == 서브 쿼리: SQL+SQL => 쿼리안에 있는 결과값을 가지고 온다

*/






