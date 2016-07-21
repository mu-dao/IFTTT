package com.loginsys.servlet;
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.UserDao;
import com.entity.User;

import function.TaskControl;

@WebServlet("/LoginServlet")
public class CheckLogin extends HttpServlet{
	private static final long serialVersionUID = 1L;

	public void init() throws ServletException{
		super.init();
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		//获取用户名和密码
		String uname = request.getParameter("uname");
		String upass = request.getParameter("upass");
		
		User user = UserDao.Login(uname);//用户不存在则返回null，用户存在则返回用户名和密码
		//用户存在
		if(user != null){
			//密码正确
			if(user.getPassword().equals(upass)){
				HttpSession session = request.getSession();//创建一个HttpSession
				session.setAttribute("uname", uname);//设置session的uname属性
				//如果用户是admin，则进入管理页面(Management.jsp)
				if(uname.equals("admin")){
					request.getRequestDispatcher("/Management.jsp").forward(request, response);
					TaskControl a = (TaskControl)(request.getSession().getAttribute("TaskControl"));
					try {
						a.Update();
					} catch (NumberFormatException | ClassNotFoundException | SQLException e) {
						e.printStackTrace();
					}
				}
				//如果是普通用户，则进入用户主页
				else{
					request.getRequestDispatcher("/MainPage.jsp").forward(request, response);
					TaskControl a = (TaskControl)(request.getSession().getAttribute("TaskControl"));
					try {
						a.Update();
					} catch (NumberFormatException | ClassNotFoundException | SQLException e) {
						e.printStackTrace();
					}
				}
			}
			//密码错误，回到登录页面
			else{
				request.setAttribute("error2", "Incorrect Password!");
				request.getRequestDispatcher("/login.jsp").forward(request, response);
			}
		}
		//用户不存在，回到登录页面
		else{
			request.setAttribute("error1", "User don't exist!");
			request.getRequestDispatcher("/login.jsp").forward(request, response);
		}
	}
	//简单地将get和post做同样的处理
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		doGet(request, response);
	}
}