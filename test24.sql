-- 04-30 
/*
	검색(사원 검색) / 추가 / 삭제 / 출퇴근 / 급여 계산
	도서 => 대출
*/
--출퇴근
DROP table attend;

CREATE TABLE attend(
	no NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	empno NUMBER,
	work_date DATE DEFAULT SYSDATE,
	check_in DATE DEFAULT SYSDATE,
	check_out DATE DEFAULT SYSDATE,
	status VARCHAR2(20),
	CONSTRAINT att_emp_fk FOREIGN KEY(empno) REFERENCES emp2(empno),
	CONSTRAINT att_status_ck CHECK(status IN('정상','지각','조퇴','결근'))
);