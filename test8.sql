-- 2026-04-16 JOIN / SubQuery => 162 ~ 178page

/*
   조인
    => 정규화: 테이블이 나눠진다
    => 연결해서 필요한 데이터를 추출하는 과정
					      ---- JOIN은 SELECT에서만 사용이 가능
    => 조인 종류
	    - 오라클 조인 (오라클에서만 사용)/ ANSI 조인 (데이터베이스 표준)
	 1. INNER JOIN: 교집합 -> 가장 많이 사용되는 조인
			      		-> NULL은 처리가 안된다
	     = EUQI_JOIN 
	     = NON_EUOQ_JOIN => 범위
	 2. OUTER JOIN: NULL값처리 가능 (INNER JOIN을 보완, Admin에서 주로 사용)
	     = LEFT OUTER JOIN => FROM table1,table2 (왼쪽에서 처리가 안된 데이터 읽기)
	     = RIGTH OUTER JOIN => FROM table1,table2 (오른쪽에서 처리가 안된 데이터 읽기)
	     = FULL OUTER JOIN => 양쪽에 있는 모든 데이터 읽기
	-------------------------------------------------------------------------------------------------------컬럼이 다를 수 있다
	 3. 컬럼명이 동일
	     = 자연조인 => NATURAL JOIN
	     = USING => JOIN ~ USING
	   -> 두개 이상의 테이블을 연결해서 출력에 필요한 데이터 추출하는 과정

	 =>형식
		1) INNER JOIN
			-오라클 조인: SELECT A.col,B.col
					  FROM A,B
					  WHERE A.col = B.col; 
						
					  SELECT a.col,b.col
					  FROM A a,B b
					  WHERE a.col = b.col; => 테이블 별칭 사용이 가능
									=> 같은 컬럼명이면 반드시 구분
									=> 다른 컬럼명이면 생략 가능
			-ANSI JOIN: SELECT A.col,B.col
					FROM A JOIN B
					ON A.col = B.col
								=> 데이터를 합쳐서 한번에 출력할 목적

		   => 여러 테이블 정보를 동시에 출력이 필요한 경우

	    		1. INNER JOIN 
			    두개 이상의 테이블에서 공통으로 존재하는 값을 이용해서 데이터만 조회
				= 교집합
				= 가장 많이 사용되는 JOIN
				= 조건이 맞는 경우 => row전체 데이터 추출이 가능 (행을 반환)
			2. 문법 형식
			     SELECT 출력하는 데이터
			     FROM table1,table2
			     WHERE table1.col = table2.col    => 별칭 사용이 가능
			3. EQUI_JOIN ==> 같은 값인 경우 (=)
			     NON_EQUI_JOIN ==> 범위에 포함된 경우 (BETWEEN,비교,논리)
			4. SELF 조인 -> 같은 테이블로 조인
					      ------------ 구분이 필요하다(테이블 별칭으로 구분)
				=> FROM emp e1, emp e2
			5. 단점은 null인 경우에는 처리하지 못한다

		2) OUTER JOIN => INNER JOIN _+ 알파
			-> 한쪽 테이블 기준으로 모든 데이터를 출력 => null인 경우에는 출력이 안되는 문제를 해결
			
			= LEFT OUTER JOIN
			    -> INTERSECT + MINUS A-B
			= RIGTH OUTER JOIN
			    -> INTERSECT + MINUS B-A
			= FULL OUTER JOIN (거의 쓰지 않는다)
			    -> UNION ALL
		   	
			1. 문법 / 형식
			  SELECT B.col, A.col
			  FROM A LEFT_OUTRT JOIN B
			  ON A.col = B.col

			  SELECT A.col, B.col
			  FROM A, B
			  WHERE A.col = B.col(+)
				
			---------------------------------------------
			  SELECT A.col, B.col
			  FROM A RIGHT_OUTRT JOIN B
			  ON A.col = B.col

			  SELECT a.col, b.col
			  FROM A, B
			  WHERE A.col(+) = B.col

			------------------------------------------

			  SELECT A.col, B.col
			  FROM A RIGHT_OUTRT JOIN B
			  ON A.col = B.col	
			  ===> UNION ALL
			 오라클 조인이 없다			      										
*/	
