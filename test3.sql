-- Chapter 1 데이터베이스 (발전 과정)
-- Chapter 2 테이블 구성요소, 데이터 추출방법, 데이터 모델

-- Chpater 3 DQL (SELECT)
-- 테이블 여러개를 연결해서 데이터를 추출 (JOIN, SUBQUERY)
-- Chapter 4 DDL (테이블,뷰,인덱스,시컨스,시노님)
-- Chapter 5 SQL 고급(내장함수), DML (INSERT,UPDATE,DELETE)
-- Chapter 6 ~7 데이터 베이스 설계 (ER-모델, 정규화)
-- Chapter 8 트랜잭션 
-- Chapter 9 보안, 백업, 복원 -> Admin
/*SELECT empno,ename,job,dname,loc
FROM emp NATURAL JOIN dept;
*/
/*
SELECT empno,ename,job,dname,loc
FROM emp JOIN dept USING(deptno);
*/

--3장 SQL기초 (129page)
/*
 1. SELECT: 데이터 검색
      = 형식 / 순서
      = 연산자
      = JOIN / SubQuery
*/
-- RENAME emp TO emp2;
-- RENAME dept TO dept2;



/*
	SELECT 문장 (142page)
	 1. 데이터 검색
	 2. 형식 / 순서
	 --------------------------------------------------------
	   SELECT *(ALL) / 원하는 컬럼 지정(Column_list)
	   FROM table_name
	 --------------------------------------------------------필수
	   WHERE 조건(연산자)
	   GROUP BY 그룹컬럼
	   HAVING 그룹 조건 ===> GROUP BY가 있는 경우만 사용 가능
	   ORDER BY 정렬컬럼 (ASC-오름차순/DESC-내림차순)
	3. 주의점
	  = 대소문자 구분이 없다 select / SELECT / Select
	     (약속 -> 키워드는 대문자로 한다)
	  = 실제 저장된 데이터는 대소문자를 구분한다 (KING값 => king 검색(x))
	  = 문장이 종료가 되면 ; 세미콜론 사용
	     (자바에서는 자동으로 세미콜론이 추가됨)
	  = 문자, 날짜는 반드시 '' 싱글 따옴표 사용
	4. 문자열 형식으로만 되어 있다
	5. 날짜 형식 => 'YY/MM/DD' '26/04/13'
	6. 중복이 없는 데이터를 가지고 올때 컬럼 앞에 DISTINCT를 붙인다
	7. 문자열 결합은 ||를 쓴다
	    ename||'는 급여가'||sal||'입니다' => ||,&&(x)  -> OR, AND 사용
	8. & => Scanner  크롤링시 &가 붙어있으면 다른 문자로 바꿔서 가져와야한다
	9. 띄어쓰기 주의  FROMemp (x) FROM emp
*/
/*
사원정보 -[인원수 14명]
 EMPNO NOT NULL NUMBER(4)   	=> 사번
 ENAME VARCHAR2(10)		=> 이름
 JOB VARCHAR2(9)			=> 직위
 MGR NUMBER(4)			=> 사수 사번
 HIREDATE DATE				=> 입사일
 SAL NUMBER(7,2)			=> 급여
 COMM NUMBER(7,2)			=> 성과급
 DEPTNO NUMBER(2)			=> 부서번호
*/

/*
  SQL => 문자열 형식 => String sql = ""
  ---- 143page
  1. DML: 데이터 조작언어
     -----
	SELECT: 데이터를 검색 => 테이블, 뷰에서 검색   **SELECT는 형식이 많이 존재
	----------------------------------
	INSERT: 데이터 추가
	UPDATE: 데이터 수정
	DELETE: 데이터 삭제
	---------------------------------- 데이터가 변경되기 때문에 COMMIT이 필요
  2. DDL: 데이터 정의언어
     ----- 테이블, 뷰, 시퀀스, 인덱스, 시노님, 함수, 프로시져, 트리거
	CREATE: 생성
	DROP: 삭제
	ALTER: 변경
	TRUNCATE: 데이터만 잘라내기
	REANME: 이름변경
  3. DCL: 데이터 제어언어
     ----- 권한과 관련
	GRANT: 권한 부여
	REVOKE: 권한 해제
  4. TCL: 트랜젝션 제어언어
     ---- 
	COMMIT: 정상적으로 저장
	ROLLBACK: 명령문 전체 취소
	SAVEPOINT: 원하는 부분만 취소
*/
