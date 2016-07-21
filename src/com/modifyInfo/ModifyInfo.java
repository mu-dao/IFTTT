package com.modifyInfo;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.UserDao;
import com.entity.User;

@WebServlet("/ModifyInfoServlet")
public class ModifyInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = new User();
		
		user.setName(request.getParameter("name"));
		user.setSex(request.getParameter("sex"));
		user.setYear(request.getParameter("year"));
		user.setMonth(request.getParameter("month"));
		user.setDay(request.getParameter("day"));
		user.setEmail(request.getParameter("email"));
		user.setPhone(request.getParameter("phone"));
		
		String money = request.getParameter("money");
		if(request.getParameter("rechargeMoney") != null && request.getParameter("rechargeMoney") != "")
			money = String.valueOf(Integer.parseInt(money) + Integer.parseInt(request.getParameter("rechargeMoney")));
		user.setMoney(money);
		
		UserDao.setInfo(user);
		request.getRequestDispatcher("/Info.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}