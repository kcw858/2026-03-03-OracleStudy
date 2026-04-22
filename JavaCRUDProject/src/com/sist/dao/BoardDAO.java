package com.sist.dao;
import java.util.*;

import com.sist.commons.DButil;
import com.sist.vo.BoardVO;

import java.sql.*;
public class BoardDAO {
	private DButil db = new DButil();
	
	private Connection conn;
	private PreparedStatement ps;
	
	private static BoardDAO dao; // 싱글턴
	
	public static BoardDAO newInstance()
	{
		if(dao == null)
			dao = new BoardDAO();
		return dao;
	}
	
	//목록출력
	// 1. 장렬 => 게시판은 ORDER BY
	// 2. 페이징 => OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY
	// 			=> 0번부터 시작               --- 10개씩 
	public List<BoardVO> board_list(int page)
	{
		List<BoardVO> list = new ArrayList<BoardVO>();
		
		try
		{
			conn = db.getConnection();
			// SQL 문장을 오라클 전송
			String sql = "SELECT /*+ INDEX_DESC(board board_no_pk)*/ no,subject,name,TO_CHAR(regdate,'YYYY-MM-DD'),hit "
					+ "FROM board "
					+ "OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY";
			int start = (page*10) - 10;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start); // ?에 값 채워주기
			
			//실행 후 결과값
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) //첫번째 row로 커서 이동
			{
				BoardVO vo = new BoardVO();
				vo.setNo(rs.getInt(1));
				//vo.setNo(rs.getInt("no")); 인덱스 번호가아닌 컬럼명으로 들어가도 된다
				vo.setSubject(rs.getString(2));
				vo.setName(rs.getString(3));
				vo.setDbday(rs.getString(4));
				vo.setHit(rs.getInt(5));
				list.add(vo);
			}
			rs.close(); //닫아주기
		}catch(Exception ex) {
			
			ex.printStackTrace();
		}
		finally
		{
			db.disConnection(conn, ps);
		}
		return list;
	}
	
	// 총 페이지
	// CEIL
	public int boardTotalPage()
	{
		int total = 0;
		try
		{
			//연결
			conn = db.getConnection();
			
			//SQL 문장 만들기
			String sql = "SELECT CEIL(COUNT(*)/10.0) FROM board";
			
			//오라클로 전송
			ps = conn.prepareStatement(sql); //컬럼의 인덱스번호 또는 컬럼명 (Mybatis는 컬럼명으로 읽는다)
			
			// ?가 있으면 값을 채워주고 없으면 넘어간다
			ResultSet rs = ps.executeQuery();
			
			//출력된 메모리 위치에 커서를 이동시켜야한다
			rs.next();
			
			//해당 데이터형을 이용해서 데이터를 가지고온다
			//NUMBER -> getInt / getDouble,  VARCHAR2 -> getString, CLOB -> getString,  DATE -> getDate
			total = rs.getInt(1);
			rs.close();
			
		}catch(Exception ex) 
		{
			ex.printStackTrace();
		}
		finally
		{
			db.disConnection(conn, ps);
		}
		return total;
	}
	//데이터 추가
	
	public void board_insert(BoardVO vo)
	{
		try 
		{
			conn = db.getConnection();
			
			String sql = "INSERT INTO board VALUES("
					+ "board_seq.nextval,?,?,?,?,SYSDATE,0)";
			ps = conn.prepareStatement(sql);
			
			//실행전 ?에 값을 채워준다
			ps.setString(1, vo.getName());
			ps.setString(2, vo.getSubject());
			ps.setString(3, vo.getContent());
			ps.setString(4, vo.getPwd());
			
			ps.executeUpdate(); // 데이터베이스 변경 COMMIT이 포함되어있다(자바는 Auto Commit)  INSERT/ UPDATE/ DELETE     SELECT는 executeQurey()
			/*
			 *  INSERT
			 *  INSERT => 오류발생 
			 *  INSERT
			 *  -> 하나가 오류가 나면 모두 실패해야한다 => 트랜잭션
			 */
			
			
		} catch (Exception ex) 
		{
			ex.printStackTrace();
		}
		finally
		{
			db.disConnection(conn, ps);
		}
	}
	
	//상세보기
	public BoardVO board_detail(int no)
	{
		BoardVO vo = new BoardVO();
		
		try
		{
			conn = db.getConnection();
			
			//조회수 먼저 증가
			String sql = "UPDATE board SET "
					+ "hit = hit+1 "
					+ "WHERE no = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, no);
			ps.executeUpdate();
			
			//실제 데이터 읽기
			sql = "SELECT no,name,subject,content,hit,TO_CHAR(regdate,'YYYY-MM-DD HH24:MI:SS') as dbday "
					+ "FROM board "
					+ "WHERE no = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, no);
			ResultSet rs = ps.executeQuery();
			rs.next();
			
			//값 채우기
			vo.setNo(rs.getInt(1));
			vo.setName(rs.getString(2));
			vo.setSubject(rs.getString(3));
			vo.setContent(rs.getString(4));
			vo.setHit(rs.getInt(5));
			vo.setDbday(rs.getString(6));
			
			rs.close();
			
		}catch(Exception ex)
		{
			ex.printStackTrace();
		}
		finally
		{
			db.disConnection(conn, ps);
		}
		
		return vo;
	}
	
}
