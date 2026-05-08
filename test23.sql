-- 데이터베이스 설계 (ER-MODEL)
/*
	데이터 추출 : web -> 상세보기
	위키북스
	--------------
	books
	 = 이미지
	 = 책제목
	 = 저자
	 = 가격
	 = 출판일
	 = ISBN
	 = 책소개
	 = 태그
	 = 번호 -> 구분자, 결정자 (PK)

	books(no,bookname,poster,author,price,pubdate,isbn,content,tag)

	
*/
-- 테이블 -> 시퀀스 -> 인덱스
-- view: 여러개의 JOIN이 있는 경우 (SQL 문장 저장) => 재사용
-- view가 많은 경우 PROCEDURE
/*
     PRIMARY KEY ==> 회원 / 사원 -> 숫자(자동증가)
     FOREIGN KEY : 관계
						     id
						_________
						|	    |
			  books -- <도서대출> --회원
			      |			|	
	     		      ----------------
				books no
		
			=> loan(no,bno,id,대출일,반납일,상태)

			sawon --<관계>-- 출근/퇴근/조퇴/외출/휴가
					| sabun
					
     CHECK
     UNIQUE
     NOT NULL
*/
CREATE TABLE books
(
	no NUMBER,
	bookname VARCHAR2(2000) CONSTRAINT books_bn-nn NOT NULL,
	poster VARCHAR2(260) CONSTRAINT books_poster-nn NOT NULL,
	author VARCHAR2(1000) CONSTRAINT books_author-nn NOT NULL,
	price VARCHAR2(100) CONSTRAINT books_price-nn NOT NULL,
	pubdate VARCHAR2(100) CONSTRAINT books_pub-nn NOT NULL,
	isbn VARCHAR2(100) CONSTRAINT books_isbn-nn NOT NULL,
	content CLOB,
	tag CLOB,
	CONSTRAINT books_no_pk PRIMARY KEY(no)
);

CREATE SEQUENCE books_no_seq
	START WITH 1
	INCREMENT BY 1
	NOCYCLE
	NOCACHE;

CREATE INDEX idx_books_bn ON books(bookname);
CREATE INDEX idx_books_tag ON books(tag);