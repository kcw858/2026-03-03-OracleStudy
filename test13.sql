-- 04-20: ROWNUM (222page)
-- SubQuery : 인라인뷰 / 스칼라 서브쿼리
-- View / Index => 시퀀스, 시노님 (동의어 => 테이블의 별칭)

/*
   오라클에서 지원하는 가상 컬럼 => ROWNUM / ROWID (Index)
				-----------> 모든 테이블에 적용
   오라클에서 순차적으로 ROW의 번호를 부여
   => 사용처
	  - 인기순위 Top 100
	  - 페이징 
	  - 게시판의 상세보기 (이전/다음)
   => 단점
	  - TOP-N => 처음 ~ (중간에서 자르기가 안된다)

   (224page)
     중첩 서브쿼리: 조건값 -> WHERE 문장 뒤
	***= 단일행 서브쿼리 -> 결과값 1개
	***= 다중행 서브쿼리 -> 결과값 여러개
	  -----------------------------------------컬럼 1개
	= 다중컬럼 서브쿼리 -> 컬럼 여러개

      SELECT
      FROM table_name
      WHERE 컬럼 연산자 (SELECT ~)
			-------
			비교 연산자: 서브쿼리의 결과값이 1개일때
			집합 연산자: IN, NOT IN
			한정 연산자: ANY, SOME, ALL -> 결과값중 1개 결정 MAX / MIN
			존재 연산자: EXISTS, NOT EXISTS

     스칼라 서브쿼리: 컬럼 대신 사용: JOIN 대체 => SELECT 뒤에
	= SELECT안에 들어가는 서브쿼리
	= 반드시 결과 값 1개
	= 값 1개만 가지고 오는 SELECT문
	= 주로 사용: 집계함수
	= CASE와 사용시 	
	= 값 1개 계산

     인라인 뷰: 테이블 대신 사용: 한번 사용(보안,페이징) => FROM 뒤에
	= 즉석 검색 결과
	= SELECT ~ FROM (SELECT ~)
				  ------------ 테이블 역할을 수행 ===> SELECT가 안보이게 만드는 과정: VIEW
	= 페이징, rownum변경(순서)
	= 반드시 없는 데이터가 있는경우 오류가 발생한다
	SELECT empno,ename,job,hiredate,sal				
	FROM (SELECT ename,job,hiredate,sal FROM emp)
			     ------------------------- 여기에 포함된 컬럼만 사용이 가능, empno가 없어서 이문장은 오류

	** 서브쿼리는 SELET문장만 사용 가능

-----------------------------------------------------------------------------------------------
스칼라 서브쿼리 / 인라인 뷰 => 저장이 안됨(보안)
 | 컬럼 1개		| 임시 테이블


*/
/*
SELECT ename,AVG(sal) as emp_sal
FROM emp; -> 오류
SELECT ename, (SELECT AVG(sal) FROM emp) as emp_sal
FROM emp;
*/