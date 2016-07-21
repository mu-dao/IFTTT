package com.resetpass;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.UserDao;
import com.entity.User;

//告知Web容器URL
@WebServlet("/ResetPasswordServlet")

public class ResetPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public ResetPassword() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = new User();
		user.setName(request.getParameter("uname"));
		user.setPassword(request.getParameter("upass"));
		UserDao.resetPass(user);//更新数据库中存储的密码
		request.getRequestDispatcher("/Info.jsp").forward(request, response);//回到Info.jsp页面
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}