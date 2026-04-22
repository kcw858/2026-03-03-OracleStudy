package com.sist.client;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.*;

import com.sist.dao.BoardDAO;
import com.sist.vo.BoardVO;
public class BoardInsert extends JPanel implements ActionListener{
    JLabel titleLa,nameLa,subLa,contLa,pwdLa;
    JTextField nameTf,subTf;
    JPasswordField pwdPf;
    JTextArea ta;
    JButton b1,b2;
    UserMainForm mf;
    public BoardInsert(UserMainForm mf)
    {
    	this.mf = mf;
    	titleLa=new JLabel("글쓰기",JLabel.CENTER);// <table>
    	titleLa.setFont(new Font("맑은 고딕",Font.BOLD,30)); //<h3></h3>
    	setLayout(null);
    	titleLa.setBounds(10, 15, 620, 50);
    	add(titleLa);
    	
    	nameLa=new JLabel("이름",JLabel.CENTER);
    	nameTf=new JTextField();
    	nameLa.setBounds(180, 70, 80, 30);
    	nameTf.setBounds(265, 70, 150, 30);
    	add(nameLa);add(nameTf);
    	
    	subLa=new JLabel("제목",JLabel.CENTER);
    	subTf=new JTextField();
    	subLa.setBounds(180, 105, 80, 30);
    	subTf.setBounds(265, 105, 450, 30);
    	add(subLa);add(subTf);
    	
    	
    	contLa=new JLabel("내용",JLabel.CENTER);
    	ta=new JTextArea();
    	JScrollPane js=new JScrollPane(ta);
    	contLa.setBounds(180, 140, 80, 30);
    	js.setBounds(265, 140, 450, 250);
    	add(contLa);add(js);
 
    	pwdLa=new JLabel("비밀번호",JLabel.CENTER);
    	pwdPf=new JPasswordField();
    	//             Top  Right Bottom Left ==> CSS
    	pwdLa.setBounds(180, 395, 80, 30);
    	//             x  y width heigth
    	pwdPf.setBounds(265, 395, 150, 30);
    	add(pwdLa);add(pwdPf);
    	
    	b1=new JButton("글쓰기");
    	b2=new JButton("취소");
    	
    	JPanel p=new JPanel();
    	p.add(b1);p.add(b2);
    	p.setBounds(180, 435, 535, 35);
    	add(p);
    	
    	b2.addActionListener(this);
    	b1.addActionListener(this);
    }
	@Override
	public void actionPerformed(ActionEvent e) {
		if(e.getSource() == b2)
		{
			mf.cp.card.show(mf.cp,"BLIST");
		}else if(e.getSource() == b1)		
		{	
			//입력된 값 읽기
			String name = nameTf.getText();
			
			if(name.trim().length() < 1) //유효성 검사
			{
				//입력이 안된 경우
				nameTf.requestFocus();
				return;
			}
			
			//입력된 값 읽기
			String subject = subTf.getText();
			
			if(subject.trim().length() < 1) //유효성 검사
			{
				//입력이 안된 경우
				subTf.requestFocus();
				return;
			}
			
			//입력된 값 읽기
			String content = ta.getText();
			
			if(content.trim().length() < 1) //유효성 검사
			{
				//입력이 안된 경우
				ta.requestFocus();
				return;
			}
			
			//입력된 값 읽기 // 리턴형 char[]을 문자열로 변환
			String pwd = String.valueOf(pwdPf.getPassword());
			
			if(pwd.trim().length() < 1) //유효성 검사
			{
				//입력이 안된 경우
				pwdPf.requestFocus();
				return;
			}
			
			BoardVO vo = new BoardVO();
			vo.setName(name);
			vo.setSubject(subject);
			vo.setContent(content);
			vo.setPwd(pwd);
			
			//DB연동
			
			BoardDAO dao = BoardDAO.newInstance();
			
			dao.board_insert(vo);
			
			//이동 => boardList
			
			mf.cp.card.show(mf.cp, "BLIST");
			mf.cp.bList.print(); // 새로고침
		}
		
	}
}
