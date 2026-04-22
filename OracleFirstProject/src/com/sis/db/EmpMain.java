package com.sis.db;

import java.sql.*;
import java.util.*;

/*
 * 	Java에서 집중해서 봐야할 문법
 * 
 *  1. 메소드
 *  2. 제어문
 *  3. 클래스 => 변수 / 메소드 / 생성자
 *  4. 캡슐화
 *  5. 추상 클래스 / **인터페이스
 *  6. 예외처리
 *  ------------------------------------
 *  7. 라이브러리
 *  	-> String / Collection(List,Map)
 *  	-> IO
 */
public class EmpMain { 
 
	public static void main(String[] args) throws Exception{
		
		Scanner scan = new Scanner(System.in);
		System.out.print("직위 입력: ");
		String name = scan.next();
		
		//1. 드라이버
		Class.forName("oracle.jdbc.driver.OracleDriver");
		String url = "jdbc:oracle:thin:@localhost:1521:XE";
		
		//2. 오라클 연결
		Connection conn = DriverManager.getConnection(url,"hr","happy"); //socket
		
		//3. 명령문 전송
		String sql = "SELECT empno,ename,job "
						+ "FROM emp "
						+ "WHERE job "
						+ "LIKE '%"+name+"%'";
		
		PreparedStatement ps = conn.prepareStatement(sql); //OutputStream
		
		//4. 실행 결과값 가져오기
		ResultSet rs = ps.executeQuery();
		
		//5. 출력
		while(rs.next())
		{
			System.out.println(rs.getInt(1)+" " + rs.getString(2) + " " + rs.getString(3));
		}
		
		rs.close();
		ps.close();
		conn.close();
	}
}
