-- (187page) DML (데이터 조작언어)
/*
    INSERT
    UPDATE
    DELETE
    --------------------> 내용이 변경되어 COMMIT을 해줘야한다
				| 자바는 AutoCommit
    INSERT: 데이터 추가(테이블)
    UPDATE: 데이터 수정
    DELETE: 데이터 삭제

    ** 수정과 삭제는 이상현상이 발생할 수 있다
	 -> 이상현상: 원하지 않는 데이터 변경
			   ----------------------------PRIMARY KEY: 무결성 원칙
    ** 가급적 하나의 테이블에 하나의 PRIMARY KEY

 
    INSERT
	형식)	
	   1. 전체 값 추가
		INSERT INTO board VALUES(값,값...) => 문자열과 날짜는 작은따옴표
				   ------- board에 있는 모든 컬럼값을 추가
				   ------- DEFAULT에 있는 값도 집어넣어줘야해서 의미가 없어진다
	   2. 지정된 값 추가
		INSERT INTO board(컬럼1,컬럼2,컬럼3) VALUES(값1,값2,값3) -> 앞에 지정된 컬럼 수 만큼 값을 넣어준다
												  -> 작성하지않는 컬럼에 DEFAULT값이 있으면 DEFAULT로 들어감

    UPDATE
	형식)
	    1. 전체수정
		UPDATE table_name SET 컬럼=값, 컬럼=값....
	    2. 조건에 맞는 데이터 수정
		UPDATE table_name SET 컬럼=값, 컬럼=값.... WHERE 조건

     DELETE
	형식)
	    1. 전체삭제
		DELETE FROM table_name
      	    2. 조건에 맞는 데이터 삭제
		DELETE FROM table_name WHERE 조건

	====> INSERT / UPDATE -> 반드시 제약조건 확인
*/