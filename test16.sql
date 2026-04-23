--3장 ~ 4장
/*
     SQL: 
	DML / DDL / DCL / TCL

	1) 명령문 / 문법 / 순서
	 DML
	    SELECT * | column
	    FROM table_name | view_name | (SELECT ~)
	    [
		WHERE 조건
		GROUP BY
		HAVING
		ORDER BY
	    ]

	    INSERT INTO table_name VALUES(값...) -> 컬럼 갯수만큼 채운다
	    INSERT INTO table_name(컬럼...) VALUES(값...) -> 컬럼 지정된 갯수만큼
	    
	    UPDATE table_name SET 컬럼 = 값, 컬럼 = 값 ... [WHERE 조건]

	    DELETE FROM table_name [WHERE 조건]

	-------------------------------------------------------------------------------------------- 자바에서 사용하지 않는다(DDL, DCL, TCL)
	 DDL
	    CREATE
		1) 테이블 생성
		      CREATE TABLE table_name
		      (
				컬럼 데이터 형 [제약조건], => DEFAULT, NOT NULL
				컬럼 데이터 형 [제약조건],
				컬럼 데이터 형 [제약조건],
				[제약조건] => PK, FK, UK, CK
	               )
	
		      CREATE TABLE table_name
		      AS
			SELECT ~

		2) 뷰 생성
		     CREATE [OR REPLACE] VIEW view_name
		     AS
			SELECT ~ 

		3) 시퀀스 생성
		      CREATE SEQUENCE seq_name
			  START WITH 1
			  INCREMENT BY 1
			  NOCACHE
			  NOCYCLE

		4) 인덱스 생성
		      CREATE INDEX index_name ON 테이블(컬럼명)
		      CREATE INDEX index_name ON 테이블(컬럼명,컬럼명 [ASC | DESC])
		      CREATE INDEX index_name ON 테이블(함수(컬럼명))
									    NVL(bunji,' ')

	    ALTER
		=> 테이블
			ALTER TABLE table_name ADD 컬럼 데이터형[제약조건]
			ALTER TABLE table_name MODIFY 컬럼 데이터형[제약조건]
			ALTER TABLE table_name DROP COLUMN 컬럼명
			ALTER TABLE table_name RENAME COLUMN 컬럼명 TO 컬럼명

	    DROP
		DROP TABLE table_name
		DROP INDEX index_name
		DROP SEQUENCE seq_name
		DROP VIEW view_name

	    RENAME
		=> 테이블 이름 변경
			RENAME old_name TO new_name

	    TRUNCATE
		TRUNCATE TABLE table_name
	 DCL
		GRANT CREATE VIEW TO hr
		REVOKE CREATE VIEW FROM hr
	 TCL
		COMMIT / ROLLBACK
	--------------------------------------------------------------------------------------------
	=> NUMBER / VARCHAR2 / CHAR / CLOB / DATE / TIMESTAMP
	=> PRIMARY KEY / FOREIGN KEY / CHECK
*/