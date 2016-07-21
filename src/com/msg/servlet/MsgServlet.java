package com.msg.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.dao.UserDao;
import com.entity.Message;

@WebServlet("/MsgServlet")
public class MsgServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public MsgServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Message message = new Message();
		
		HttpSession session = request.getSession();
		//根据request提交的表单设置message的数据
		message.setFromMember(session.getAttribute("uname").toString());
		message.setIsAll(request.getParameter("toall"));
		message.setToMember(request.getParameter("tomember"));
		message.setTitle(request.getParameter("title"));
		message.setContent(request.getParameter("content"));
		//设置发送时间为当前的时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		message.setTime(df.format(new Date()));
		
		if(request.getParameter("id") != null){
			String id = request.getParameter("id");
			if(!id.equals("-1")){
				UserDao.deleteMsg(id);
			}
		}
		//发送消息，根据发送者的不同，设置返回页面
		UserDao.sendMsg(message);
		if(message.getFromMember().equals("admin"))
			request.getRequestDispatcher("/Management.jsp").forward(request, response);
		else
			request.getRequestDispatcher("/MainPage.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}