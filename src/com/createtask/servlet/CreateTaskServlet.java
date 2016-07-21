package com.createtask.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import function.TaskControl;


@WebServlet("/CreateTaskServlet")
public class CreateTaskServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public CreateTaskServlet() {
		super();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String Tname = request.getParameter("Name");
		String Uname = session.getAttribute("uname").toString();
		int ID = -1;
		int State = 2;
		int THIS = 0;
		int THAT = 0;
		String Date      = request.getParameter("Year") + "-" + request.getParameter("Mon") + "-" + request.getParameter("Day");
		String Time      = request.getParameter("Hour") + ":" + request.getParameter("Min") + ":" + request.getParameter("Sec");
		String RCV_Mail  = request.getParameter("Gmail");
		String RCV_PW    = request.getParameter("Password_Of_Gmail");
		String Frm_Sina  = request.getParameter("Weibo");
		String Frm_PW    = request.getParameter("Password_Of_Weibo");
		String SinaText  = request.getParameter("SinaText");
		String To_Sina   = request.getParameter("Weibo2");
		String To_PW     = request.getParameter("Password_Of_Weibo2");
		String Weibo_Content = request.getParameter("text_of_weibo");                   //微博发布内容
		String Send_Mail = request.getParameter("Gmail2");
		String[] split   = Send_Mail.split("@");
		String Mail_User = split[0];//request.getParameter("mail_user");							 //邮件授权的账号
		String Send_PW   = request.getParameter("Password_Of_Gmail2");
		String To_Mail   = request.getParameter("To");
		String Content   = "";
		String Subject   = "";
		String Info      = "";
		String WaitTime  = request.getParameter("WaitTime");

		if(!request.getParameter("Year").equals("year")){
			THIS = 1;
		}
		if(!RCV_Mail.equals("163mail")){
			THIS = 2;
		}
		if(!Frm_Sina.equals("Weibo")){
			THIS = 3;
		}
		if(!WaitTime.equals("Wait_Time(mins)")){
			THIS = 4;
		}

		if(!Send_Mail.equals("163mail")){
			THAT = 1;
			Subject = request.getParameter("Theme");
			Content=request.getParameter("text_of_gmail");
		}

		if(!To_Sina.equals("Weibo")){
			THAT = 2;
			Weibo_Content=request.getParameter("text_of_weibo");
		}

		if(THIS == 1){
			if(THAT == 1){
				Info = "Send　an　e-mail　to　"+To_Mail+"　from　" + Send_Mail +"&#13;at　"+ Date +"　"+Time;
			}
			else if(THAT == 2){
				Info = "Update　Sina--"+To_Sina+"　states&#13;at　"+ Date +"　"+Time;
			}
		}
		else if(THIS == 2){
			if(THAT == 1){
				Info = "Send　an　e-mail　to　"+To_Mail+"　from　" + Send_Mail +"&#13;when　"+ RCV_Mail + "　received　an　e-mail";
			}
			else if(THAT == 2){
				Info = "Update　Sina--"+To_Sina+"&#13;when　"+ RCV_Mail + "　received　an　e-mail";
			}
		}
		else if(THIS == 3){
			if(THAT == 1){
				Info = "Send　an　e-mail　to　"+To_Mail+"　from　" + Send_Mail +"&#13;when　"+ Frm_Sina + "　update　a　new　state";
			}
			else if(THAT == 2){
				Info = "Update　Sina--"+ To_Sina +"&#13;when　"+ Frm_Sina + "　update　a　new　state";
			}
		}
		else if(THIS == 4){
			if(THAT == 1){
				Info = "Send　an　e-mail　to　"+To_Mail+"　from　" + Send_Mail +"&#13;when　"+ Frm_Sina + "　do　not　update　a　new　state　after　" + WaitTime +"　minutes　";
			}
			else if(THAT == 2){
				Info = "Update　Sina--"+ To_Sina +"&#13;when　"+ Frm_Sina + "　do　not　update　a　new　state　after　" + WaitTime +"　minutes　";
			}
		}
		System.out.println(Uname+" "+Tname+" "+THIS+" "+THAT+" "+Date+" "+Time+" "+RCV_Mail+" "+RCV_PW+" "+Frm_Sina+" "+Frm_PW+" "+To_Sina+" "+To_PW+" "+Send_Mail+" "+Send_PW+" "+To_Mail+" "+Content+" "+Subject+" "/*+ATCM+" "+CopyTo+" "*/+Info);
		TaskControl a = (TaskControl)(request.getSession().getAttribute("TaskControl"));
		try {
			a.CreateTask(Uname,Tname,ID,State,THIS,THAT,Date,Time,
				    RCV_Mail,RCV_PW,Frm_Sina,Frm_PW,SinaText,To_Sina,
			        To_PW,Weibo_Content,Send_Mail,Mail_User,Send_PW,To_Mail,Content,Subject,
			        Info,WaitTime);
		} catch (ClassNotFoundException | SQLException e){
			e.printStackTrace();
		}
		if(Uname.equals("admin")){
			request.getRequestDispatcher("/taskAdmin.jsp").forward(request, response);
		}
		else{
			request.getRequestDispatcher("/task2.jsp").forward(request, response);
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}