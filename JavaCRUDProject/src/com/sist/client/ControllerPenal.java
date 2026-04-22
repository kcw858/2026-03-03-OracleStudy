package com.sist.client;
import java.util.*;
import java.awt.*;
import javax.swing.*;

public class ControllerPenal extends JPanel{
	
	CardLayout card = new CardLayout();
	UserMainForm mf;
	HomePanel hp = new HomePanel();
	BoardList bList;
	BoardInsert bInsert;
	BoardDetail bDetail;
	public ControllerPenal(UserMainForm mf)
	{
		this.mf = mf;
		bList = new BoardList(mf);
		bInsert  = new BoardInsert(mf);
		bDetail = new BoardDetail(mf);
		setLayout(card);
		//setBackground(Color.CYAN);
		add("HOME",hp);
		add("BLIST",bList);
		add("BINSERT",bInsert);
		add("BDETAIL",bDetail);
	}
	

}
