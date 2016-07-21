package com.regsys.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.UserDao;
import com.entity.User;

@WebServlet("/RegisterServlet")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Register() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User userCheck = UserDao.Login(request.getParameter("uname"));//尝试使用uname查找数据库，如果返回用户名和密码，说明用户已存在
		if(userCheck != null){
			request.setAttribute("error1", "The username exists!");
			request.getRequestDispatcher("/register.jsp").forward(request, response);	
		}
		
		User user = new User();
		user.setName(request.getParameter("uname"));
		user.setPassword(request.getParameter("upass"));
		user.setSex(request.getParameter("sex"));
		user.setEmail(request.getParameter("email"));
		user.setPhone(request.getParameter("phone"));
		
		if(request.getParameter("year").equals("YYYY"))	
			user.setYear("");
		else	
			user.setYear(request.getParameter("year"));
		if(request.getParameter("month").equals("MM"))		
			user.setMonth("");
		else	
			user.setMonth(request.getParameter("month"));
		if(request.getParameter("day").equals("DD"))
			user.setDay("");
		else	
			user.setDay(request.getParameter("day"));
		
		UserDao.Register(user);
		request.getRequestDispatcher("/index.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}