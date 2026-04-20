# 오라클 데이터베이스 개론과 실습 공부 정리

<details>
<summary>데이터베이스란</summary>
  
## 2026-04-13
  + 데이터 베이스
    - 관련된 데이터를 모아서 쉽게 관리
    - 많은 정보를 체계적으로 저장하고 필요시마다 빠르게 찾기 위한 공간
  + 데이터베이스 시스템
    - 검색/변경/삭제/추가를 주로 수행 (오라클)
    - 명령어: SELECT / UPDATE / DELETE / INSERT => DML (데이터 조작어) - 웹개발자가 주로 사용
  + 데이터베이스 개념
    - 공유가 가능: 모든 사용자가 공통으로 데이터를 볼 수 있게 만든다
    - 통합된 데이터
      - 통합이 안된 경우는 개인 프로젝트와 같다
      - 중복의 최소화 필요 / 일관성 유지 / 무결성(데이터 오류방지)
    - 저장된 데이터
      - 오라클에 저장하면 삭제하기 전까지 유지
      - ROM에 저장 - 윈도우 시작과 동시에 서버 구동
      - 이미지 형식으로 저장 - 보안이 뛰어나다
    - 운영 데이터: 사이트를 위한 검색할 목적으로 저장된 데이터
  + 데이터베이스 특징
    - 실시간 접근: 오라클 종료하면 안된다 (계속 서버구동)
    - 계속적인 변화: 추가(INSERT), 수정(UPDATE), 삭제 (DELETE)
    - 동시공유: 모든 사용자가 같은 데이터를 사용할 수 있게 공유
    - 내용에 따른 참조: 프로그램 언어 -> 메모리 주소,   DB는 실제 저장된 값을 참조
  + DBMS의 기능
    - 저장 장소 정의 (DDL): 테이블, 뷰, 시퀀스, 인덱스, 시노님, PS/SQL
    - 데이터 조작 (DML): 검색-SELECT, 추가-INSERT, 삭제-DELETE , 수정-UPDATE
    - 데이터 제어 (DCL): GRANT, REVOKE
    - 일괄처리 (TCL): COMMIT, ROLLBACK -> 자바는 AutoCommit
      
</details>

<details>
<summary>관계 데이터 모델</summary>
  
## 2026-04-13
  + 테이블
    - 데이터를 저장한 단위로 릴레이션이라고도 하며 2차원 구조로 되어있다.(ROW,COLUMN)
    - 테이블은 한개의 데이터베이스 안에서 유일한 값이다
    - 클래스는 멤버변수, 테이블은 컬럼
    - 컬럼은 순서가 없다
    - 데이터는 순서가 없다 -> 정렬: ORDER BY(속도가 느려 지양), 대신 인덱스 사용 권장
    - 릴레이션 = 테이블 , 컬럼 = 속성, 속성의 갯수 = 차수(dgree), 튜플 = 행, 튜플의 갯수 = 카디널리티
    - 속성은 단일값이고, 중복이 없으며 순서상관이 없다
  + 키의 종류
    - 기본키
      - PRIMARY키로 유일값, 자동증가하는 번호를 주로사용(SEQUENCE)
      - 데이터 무결성을 목적으로 반드시 한개 이상이 존재해야한다
    - 후보키
      - 유일성과 최소성을 모두 만족하는 키다
      - 기본키가 될 수 있는 키다 ex) ID, 전화번호, 이메일
    - 대체키: 후보키들에서 기본키로 선택이 안된 키
    - 슈퍼키: 유일성은 만족하지만 최소성은 만족하지 못한다
    - 외래키
      - 참조 무결성을 위한 FOREIGN KEY이다
      - 다른 테이블의 기본키를 이용해서 연결하는 키다
      - ex) 게시물 ==== 댓글, 회원 ===== 예약(ID 참조), 학생 === 성적목록
   + 관계대수
     - 데이터를 찾는 방법으로 절차적 언어이다
       - 셀렉션: 조건에 맞는 데이터를 찾는 경우 (WHERE절)
       - 프로젝션: 출력에 필요한 컬럼만 선택
       - 조인: 서로 다른 테이블을 연결해서 사용
       - 집합 연산자: 합집합 / 교집합 / 차집합
         
</details>

<details>
<summary>SQL 기능</summary>
  
## 2026-04-13
   + DML
     - 데이터 조작언어로 SELECT / INSERT / UPDATE / DELETE가 있다.
     - SELECT는 테이블이나 뷰를 검색할때 사용하며 형식이 많이 존재한다
     - INSERT는 데이터 추가, UPDATE는 데이터 수정, DELETE는 데이터 삭제시 사용한다
     - SELECT는 COMMIT이 필요 없지만 INSERT / UPDATE / DELETE는 데이터가 변경되기 때문에 COMMIT이 필요하다
    + DDL
    + DCL
     
  
     
</details>

<details>
<summary>SQL_SELECT_1</summary>
  
## 2026-04-13
   + SELECT 문장
     - 데이터를 검색할때 사용
     - 형식 / 순서
       - SELECT *(ALL) / 원하는 컬럼 지정(Coumn_list) FROM tabel_name  => 필수
       - GROUP BY 그룹컬럼                                            => 선택
       - HAVING 그룹조건    (GROUP BY가 있는 경우에만 사용가능)        => 선택
       - ORDER BY 정렬컬럼 (ASC- 오름차순, DESC- 내림차순)              => 선택
   + 주의점
     - 대소문자 구문이 없다 select / Select / SELECT (하지만 약속으로 키워드는 대문자로 작성)
     - 실제 저장된 데이터는 대소문자를 구분한다
     - 문장이 종료되면 ; 세미콜론 사용
     - 문자, 날짜는 반드시 '' 싱글 따옴표 사용
     - 문자열 형식으로만 되어있다
     - 날짜 형식은 'YY/MM/DD'
     - 중복이 없는 데이터를 가지고 올때는 컬럼 앞에 DISTINCT를 붙인다 (SELECT DISTINCT coulmn FROM table_name)
     - 문자열 결합은 ||를 사용 (ename||'는 급여가'||sal||'입니다') ||,&&은 OR, AND사용
     - &는 Scanner 역할을 한다
     - 띄어쓰기에 주의 해야한다 (FROMtable_name [x] FROM table_name [o])
     
</details>

<details>
<summary>SQL_SELECT_2</summary>
  
## 2026-04-14
   + SELECT 사용법
     - 전체 데이터를 읽기 ========> *
     - 출력에 필요한 내용만 읽기 ====> column_list
     - 중복이 없이 출력 ====> DISTINCT
     - 별칭 => Mybatis (함수)  ====> 컬럼 "", 컬럼 as 별칭
     - 문자열 결합 =====> ||
     - 가급적이면 전체 검색은 사용하지 않는다
   + WHERE 사용
     - 조건검색 => 가장 많이 사용되는 키워드
     - 연산자를 사용
   + 산술연산자(+, -, *, /)
     - +: 순수하게 덧셈만 가능
     - /:  0으로 나누면 오류발생, 정수 / 정수 = 실수 ex) 5/2=2.5
   + 비교연산자 -> true / false => WHERE절 뒤에 (조건)
     - =: 같다
     - !=: 같지 않다, <>(권장), ^=
     - <: 작다
     ->: 크다
     - <=: 작거나 같다
     ->=: 크거나 같다
     - ** 숫자(정수,실수), 문자열, 날짜 비교 가능
   + 논리연산자 -> true / false => WHERE절 뒤에 (조건)
     -  AND: &&를 사용하면 안된다 (&는 입력값을 받는 경우에 사용), AND는 포함된경우
     -  OR: ||는 문자열 결합시 사용, OR는 미포함인 경우
     -  NOT: ! NOT IN / NOT BETWEEN / NOT LIKE
   + BETWEEN ~ AND ->  true / false (속도가 느려 권장하지않는다)
     - AND를 대체하는 연산자
     -  WHERE 컬럼 BETWEEN 값1 AND 값2  ==   컬럼 >= 값1 AND 컬럼 <= 값2
   + IN -> OR 여러개를 대체 (OR가 여러개면 IN연산자가 속도가 빨라 권장)
   + IS NULL, IS NOT NULL -> (Mysql은 ifnull)
   + LIKE => SELECT 문장의 핵심은 검색 (자바의 contains)
     - % : 문자 갯수를 알 수 없을 때
     - _ : 문자 한글자
     - contains ===> %검색어%
     - startWith ===> 검색어%
     - endsWith ===> %검색어
       
</details>

<details>
<summary>SQL_ORDER BY</summary>
  
## 2026-04-15
   + ORDER BY 사용 형식
     - SELECT ~ FROM table_name ORDER BY 컬럼 ASC|DESC
     - 컬럼은 컬럼명,컬럼의 위치번호 (1번부터 시작),함수가 올 수 있다
   + 이중정렬 -> 대댓글
     - ORDER BY sal,ename -> sal 먼저 정렬후 sal이 같은 값을 가지고 있는 데이터끼리만 ename정렬 
     
</details>

</details>

<details>
<summary>집계함수</summary>
  
## 2026-04-15
   + 집계함수
     - 내장 함수: 오라클 라이브러리 -> 이미 만들어져 있는 함수
     - 단일행 함수: ROW 단위
     - 집합(집계)함수: COLUMN단위
   + 집계함수 특징
     - 단일함수, 컬럼을 사용할 수 없다
     - 컬럼사용시에는 반드시 GROUP BY가 존재
   + 집계함수 종류
     - SUM: column의 총합 -> 장바구니 / 구매금액
     - AVG: column의 평균 -> 전체 구매자의 평균 금액 / 통계 , 관리자체이지에서 많이 등장
     - MIN: column 최소값
     - MAX: column의 최대값 -> 자동 증가번호(중복이 없이)
     - COUNT: column의 갯수-> 로그인 / ID 중복체크 / 검색결과
     - RANK(): 순위 출력  1등 2등 2등 4등 -> RANK()
     - DENSE_RANK(): 순위 출력 1등 2등 2등 3등 -> DENSE_RANK()
    + 기타
     - 코딩 순서: SELECT - FROM - WHERE - GROUP BY - HAVING - ORDER BY
     - 실행 순서: FROM - WHERE - GROUP BY - HAVING - SELECT - ORDER BY
       
</details>

<details>
<summary>단일행 함수</summary>
  
## 2026-04-15
   + 단일행 함수 종류
     - 문자함수
       - LENGTH / LENGTHB -> 문자열의 갯수 / 문자의 바이트 수
         - LENGTH('ABC')  ===> 3
         - LENGTH('홍길동')   ==> 3
         - LENGTHB('ABC')  ===> 3
         - LENGTHB('홍길동')   ==> 9 한글은 한글자당 3byte         
       - LPAD / ***RPAD
         - LPAD(문자열,글자수,'변경할 문자')
         - LPAD('KING',5,#) -> #KING -> 남으면 #을 붙힌다
         - RPAD(문자열,글자수,'변경할 문자')
       - UPPER / LOWER/ INTCAP
         - UPPER('문자열') -> 대문자로 출력
         - LOWER('문자열') -> 소문자로 출력
         - INTCAP('문자열') -> 첫자만 대문자
       - ****REPLACE: 변경 (크롤링시 &가 들어오면 변경해줄때 주로 사용)
         - REPLACE(문자열,찾는 문자, 변경할 문자)
         - REPLACE('Hello Java','a','b') -> Hello jbjb
       - TRIM: 공백 / 특정 문자 제거 (자바는 공백만 제거)
         - LTRIM('문자열'), LTRIM('문자열','제거할 문자')
         - RTRIM('문자열'), RTRIM('문자열','제거할 문자')
         - TRIM: 좌우 공백 제거
       - *****SUBSTR / **INSTR / CONCAT
         - SUBSTR: 문자열 자르기
         - SUBSTR(문자열,시작위치,갯수) -> 문자번호는 1부터 시작
         - INSTR(문자열,찾을문자,시작위치,몇번째) -> 위치를 리턴
         - CONCAT: 문자열 결합 => ||
         - CONCAT('Hello ','Oracle') -> Hello Oracle
       - 중요 함수
         - ***LENGTH: 문자의 갯수
			   - ***SUBSTR: 문자 자르기
			   - ***INSTR: 문자 번호 검색
			   - ***RPAD: 문자 채우기
			   - ***REPLACE: 문자 변경
     - 숫자 함수
       - MOD: %로 나누고 나머지 값
       - CEIL: 올림함수
       - TRUNC: 버림함수
       - ROUND: 반올림
     - 날자 함수
       - SYSDATE: 시스템의 날짜 / 시간 => 숫자형으로 되어있다
         - 어제: SYSDATE -1 / 내일: SYSYDATE + 1
         - 등록일 자동처리시 사용
       - MONTH_BETWEEN(현재,과거)
         - 총 개월
     - 변환 함수
       - TO_CHAR: 숫자나 날짜를 문자열로 변환
         - 숫자 콤마 찍기 TO_CHAR(111,'9.999')
         - 년도 YY / YYYY, 월 MM, 일 DD, 시 HH / HH24, 분 MI, 초 SS, 요일 DAY
       - TO_NUMBER: 문자를 숫자로 변환
         - SELECT '10'+1 => 11로 자동변환되지만 TO_NUMBER로 변환하는게 성능에 더 좋다
       - TO_DATE: 문자를 날짜형으로 변환
         - 생년월일 입력, 예약 날짜 => 문자열로 되어있어 날짜형으로 변환 필요
     - 기타 함수
       - NVL: NULL값이 있는 경우 다른 값으로 변경
       - CASE: 다중 조건문
         - CASE WHEN 조건 THEN 값 ... ELSE 값 END as 별칭
           
</details>

<details>
<summary>JOIN</summary>
  
## 2026-04-16
   + 조인
     - 테이블을 연결해서 필요한 데이터를 추출하는 과정
     - JOIN은 SELECT에서만 사용이 가능
     - 조인 종류
       - 오라클 조인 (오라클에서만 사용)/ ANSI 조인 (데이터베이스 표준)
       - INNER JOIN: 교집합 -> 가장 많이 사용되는 조인
         - EQUE_JOIN
         - NON_EQUE_JOIN => 범위
       - OUTER JOIN: NULL값처리 가능 (INNER JOIN을 보완, Admin에서 주로 사용)
         - LEFT OUTER JOIN => FROM table1,table2 (왼쪽에서 처리가 안된 데이터 읽기)
         - RIGTH OUTER JOIN => FROM table1,table2 (오른쪽에서 처리가 안된 데이터 읽기)
         - FULL OUTER JOIN => 양쪽에 있는 모든 데이터 읽기
   + 조인 형식
       - INNER JOIN
         - 오라클 조인: SELECT A.col1, b.col1 FROM A,B WHERE A.col = B.col;
         - ANSI JOIN: SELECT A.col,B.col FROM A JOIN B ON A.col = B.col;
         - 두개 이상의 테이블에서 공통으로 존재하는 값을 이용해서 데이터만 조회
         - 가장 많이 사용되는 JOIN으로 조건이 맞는 경우 => row전체 데이터 추출이 가능 (행을 반환)
      - OUTER JOIN
        - 한쪽 테이블 기준으로 모든 데이터를 출력 => null인 경우에는 출력이 안되는 문제를 해결
        - LEFT OUTER JOIN -> INTERSECT + MINUS A-B
        - RIGTH OUTER JOIN -> INTERSECT + MINUS B-A
        - FULL OUTER JOIN (거의 쓰지 않는다) -> UNION ALL
        - 오라클 LEFT OUTER JOIN: SELECT A.col, B.col FROM A, B WHERE A.col = B.col(+)
        - ANSI LEFT OUTER JOIN: SELECT B.col, A.col FROM A LEFT_OUTRT JOIN B ON A.col = B.col
        - 오라클 LEFT OUTER JOIN: SELECT A.col, B.col FROM A, B WHERE A.col(+) = B.col
        - ANSI LEFT OUTER JOIN: SELECT B.col, A.col FROM A RIGHT_OUTRT JOIN B ON A.col = B.col
    + 조인 주의점
      - 테이블 두개 필요한 데이터 추출 (조인)
      - 컬럼명이 동일 또는 같은 값을 가지고 있는 경우
      - 컬럼명이 동일시에는 반드시 테이블.컬럼 / 별칭.컬럼 -> 없으면 애매한 정의 에러가 뜬다

</details>

<details>
<summary>서브쿼리</summary>
  
## 2026-04-16
   + 서브쿼리 
     - SQL문장 여러개 연결
     - 웹 개발자가 많이 사용하는 문장으로 네트워크 통신 시 전송 한번, 수신 한번 하는게 좋기때문에	
     - DML 전체에서 사용이 가능 (INSERT,UPDATE,DELETE)
   + 서브쿼리 종류 
     -  WHERE 뒤에 일반 서브쿼리 => 조건문 대신
     -  SELECT 뒤에 스칼라 서브쿼리 *** (JOIN 대체) => 컬럼 대신
     -  FROM 뒤에 인라인 뷰 *** => 테이블 대신	
   + 단일행 서브쿼리
     - 비교 연산자 주로 사용( =, <>, <, >, <=, >=)
     - 기준값 한개를 주로 비교할 때 사용 (서브쿼리 결과가 1개인 경우)
   + 다중행 서브쿼리
     - 결과값이 여러개인 경우
     - IN, ANY, ALL, MAX, MIN
     - 집합 데이터 처리
   + 다중컬럼 서브쿼리
     - 복합조건 (많이 사용되지는 않는다)
   + EXISTS
     - IN은 값 비교, XISTS는 존재여부만 파악 (성능을 최적화) -> 조건이 만족이 되면 TRUE -> 다음 문장을 수행하지 않는다
     - SELECT * FROM emp e WHERE EXISTS(SELECT 1 FROM emp WHERE deptno = 10);

</details>

<details>
<summary>데이터 정의어_DDL</summary>
  
## 2026-04-17
   + CREATE: 생성
     - TABLE : 데이터를 저장하는 공간
     - SEQUENCE : 자동 증가 번호(게시판의 번호)
     - VIEW : 가상 테이블 -> SELECT 저장
     - INDEX : 검색 최적화, 빠른 정렬
     - FUCTION / PROCEDURE / TRIGGER
   + 테이블 만드는 방법 => 식별자와 동일
     - 1) 문자로 시작
       2) table명, column명
       3) 같은 데이터베이스에서는 테이블 명이 유일해야한다
       4) 키워드는 사용 불가능
       5) 숫자는 사용이 가능하지만 앞에 사용 금지
       6) 특수문자 사용 가능(_ , $)
   + 제약조건
     - NOT NULL => 컬럼 데이터형 CONSTRAINT 제약조건명 NOT NULL
     - UNIQUE => CONSTRAINT 제약조건명 UNIQUE(컬럼명)
     - CHECK => CONSTRAINT 제약조건명 CHECK(컬럼명 IN(...))
     - PRIMARY KEY => CONSTRAINT 제약조건명 PRIMARY KEY(컬럼명)
     - FOREIGN KEY => CONSTRAINT 제약조건명 FOREIGN KEY(컬럼명) REFERENCES 참조테이블(참조컬럼)
     - DEFAULT => 컬럼 데이터형 DEFAULT 값
   + ALTER: 추가 / 수정 / 삭제
     - ADD / MODIFY / DROP
   + DROP: 전체삭제
   + RENAME: 테이블 이름 변경
   + TRUNCATE: 데이터 잘라내기 => 테이블은 유지

</details>

<details>
<summary>데이터 조작어_DML</summary>
  
## 2026-04-17
   + INSERT: 데이터 추가(테이블)
     - 전체 값 추가
       - INSERT INTO board VALUES(값,값...) => 문자열과 날짜는 작은따옴표
       - DEFAULT에 있는 값도 집어넣어줘야해서 의미가 없어진다
     - 지정된 값 추가
       - INSERT INTO board(컬럼1,컬럼2,컬럼3) VALUES(값1,값2,값3) -> 앞에 지정된 컬럼 수 만큼 값을 넣어준다
       - 작성하지않는 컬럼에 DEFAULT값이 있으면 DEFAULT로 들어감
   + UPDATE: 데이터 수정 
     - 전체수정
       - UPDATE table_name SET 컬럼=값, 컬럼=값....
     - 조건에 맞는 데이터 수정
       - UPDATE table_name SET 컬럼=값, 컬럼=값.... WHERE 조건
   + DELETE: 데이터 삭제 
     - 전체삭제
       - DELETE FROM table_name
     - 조건에 맞는 데이터 삭제 
       - DELETE FROM table_name WHERE 조건

</details>
