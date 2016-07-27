package com.task.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dao.UserDao;
import com.entity.Message;

import function.TaskControl;
import function.Task;
import java.sql.*;

@WebServlet("/TaskServlet")  //加入提示信息、报错信息；Task执行后，数据库状态哪里改变的
public class TaskServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public TaskServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		TaskControl a = (TaskControl)(request.getSession().getAttribute("TaskControl"));
		if(request.getSession().getAttribute("TaskControl") == null)
			System.out.println("no a");
		
		String Uname = request.getSession().getAttribute("uname").toString();
		String start = request.getParameter("start");
		String stop = request.getParameter("stop");
		String alter = request.getParameter("alter");
		String delete = request.getParameter("delete");
		
		//没有任务被选择运行，返回对应用户页面
		if(request.getParameter("select_list")==null){
			request.setAttribute("error", "No task selected!");
			if(Uname.equals("admin")){
				request.getRequestDispatcher("/taskAdmin.jsp").forward(request, response);
			}
			else{
				request.getRequestDispatcher("/task2.jsp").forward(request, response);
			}
		}
		
		
		String selected = request.getParameter("select_list");
		int selectedi = Integer.parseInt(selected);
		int selectedid = 0;
		ArrayList<Task> task = a.getTASK();
		for(int i = 0; i < task.size(); i++){
			if(task.get(i).gettask_id() == selectedi){
				selectedid = i;//任务在队列中的序号       
				break;
			}
		}
		
		if(start != null){
			if(request.getSession().getAttribute("TaskControl") == null)
				System.out.println("no a");
			int state=a.getTASK().get(selectedid).gettask_state();
			task = a.getTASK();
	  		System.out.println("selected task's i is"+ selectedid);
			System.out.println("selected task's name is"+a.getTASK().get(selectedid).gettask_name());
			System.out.println("selected task's state before start is" + a.getTASK().get(selectedid).gettask_state());
			if(state == 2){
				task.get(selectedid).settask_state(1);
				System.out.println("task's state now is"+ task.get(selectedid).gettask_state());
				System.out.println("selected task's THIS and THAT is"+a.getTASK().get(selectedid).getTHIS_task() + " "+ a.getTASK().get(selectedid).getTHAT_task());
				task.get(selectedid).start();
				String sql="update task set state=1 where id="+selectedi;
		  		try {
					UserDao.Update(sql);
				} catch (ClassNotFoundException | SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		  		a.setTASK(task);
				
			}
			else if(state == 1){
				request.setAttribute("error_running", "The task is running!");
				request.getRequestDispatcher("/task2.jsp").forward(request, response);
			}
			else if(state == 3){
				request.setAttribute("error_finish", "The task has finished. Cannot be started again!");
				request.getRequestDispatcher("/task2.jsp").forward(request, response);
				
			}
			request.getRequestDispatcher("/task2.jsp").forward(request, response);
			
		}
		
		if(stop != null){
			if(request.getSession().getAttribute("TaskControl") == null)
				System.out.println("no a");
			int state=a.getTASK().get(selectedid).gettask_state();
			if(state != 1){
				request.setAttribute("error_stop", "The task is not running!");
				request.getRequestDispatcher("/task2.jsp").forward(request, response);
				
			}
			System.out.println("selected task's i is"+ selectedid);
			System.out.println("selected task's name is"+a.getTASK().get(selectedid).gettask_name());
			System.out.println("selected task's state before stop is" + a.getTASK().get(selectedid).gettask_state());
			System.out.println("task is stopped");
			task = a.getTASK();
	  	
	  		task.get(selectedid).settask_state(2);//状态设置为暂停
	  		task.get(selectedid).interrupt();//中断该任务线程
	  		Task temp = new Task(task.get(selectedid));
	  		task.set(selectedid, temp);
	  		String sql="update task set state=2 where id="+selectedi;
	  		try {
				UserDao.Update(sql);
			} catch (ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	  		
	  		a.setTASK(task);
			request.getRequestDispatcher("/task2.jsp").forward(request, response);
		}
		if(delete != null){
			int state=a.getTASK().get(selectedid).gettask_state();
			task = a.getTASK();
			String s="select * from task where id="+selectedi;
			ResultSet rst;
	  		rst = UserDao.executeQuery(s);
	  		String username = "";
	  		try {
				while(rst.next()){
					username=rst.getString(3);//即将被删除的任务属于哪个用户
				}
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
	  		System.out.println("selected task's i is"+ selectedid);
			System.out.println("selected task's name is"+a.getTASK().get(selectedid).gettask_name());
			System.out.println("selected task's state before delete is" + a.getTASK().get(selectedid).gettask_state());
			if(state == 1){
				System.out.println("running");
				if(Uname.equals("admin")){	//管理员删除任务
					//发送删除任务消息
					Message message = new Message();
					message.setFromMember("admin");
					message.setIsAll("false");
					message.setToMember(username);//通知该用户，你的任务被删除了
					message.setTitle("Delete task");
					message.setContent("You task is deleted by admin");
					SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					message.setTime(df.format(new Date()));
					UserDao.sendMsg(message);
					
			  		task.get(selectedid).settask_state(2);
			  		task.get(selectedid).interrupt();//先中断线程
			  		Task temp = new Task(task.get(selectedid));
			  		task.set(selectedid, temp);
			  		String sql="update task set state=2 where id="+selectedi;
			  		try {
						UserDao.Update(sql);
					} catch (ClassNotFoundException | SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}	  		
			  		a.setTASK(task);
			  		
			  		task.remove(selectedid);//删除任务
			  		System.out.println("task is deleted");
			  		String sql2="delete from task where id="+selectedi;
			  		try {
						UserDao.Update(sql2);
					} catch (ClassNotFoundException | SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}	  		
			  		a.setTASK(task);
					request.getRequestDispatcher("/taskAdmin.jsp").forward(request, response);
				}
				else{
					request.setAttribute("error_running", "The task is running!");
					request.getRequestDispatcher("/task2.jsp").forward(request, response);
				}
			}
	  		else{
	  			System.out.println("not running");
	  			task.remove(selectedid);
	  			System.out.println("task is deleted");
	  			String sql="delete from task where id="+selectedi;
	  			try {
	  				UserDao.Update(sql);
	  			} catch (ClassNotFoundException | SQLException e) {
	  				// TODO Auto-generated catch block
	  				e.printStackTrace();
	  			}	  		
	  			a.setTASK(task);
	  		}
			if(Uname.equals("admin")){
				request.getRequestDispatcher("/taskAdmin.jsp").forward(request, response);
			}
			else{
				request.getRequestDispatcher("/task2.jsp").forward(request, response);
			}
		}
		if(alter != null){
			int state=a.getTASK().get(selectedid).gettask_state();
			task = a.getTASK();
			request.getSession().setAttribute("selectedtask", task.get(selectedid));
			System.out.println("selected task's i is"+ selectedid);
			System.out.println("selected task's name is"+a.getTASK().get(selectedid).gettask_name());
			System.out.println("selected task's state before alter is" + a.getTASK().get(selectedid).gettask_state());
			if(state != 1){
				task.remove(selectedid);//删除掉旧的任务
				System.out.println("task is deleted and altered");
				String sql="delete from task where id="+selectedi;
				try {
					UserDao.Update(sql);
				} catch (ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				}	  		
				a.setTASK(task);
				request.getRequestDispatcher("/alterTask.jsp").forward(request, response);//然后把修改后的任务重新添加进来
			}
			else{  //添加报错信息返回给页面
				request.setAttribute("error_running", "The task is running!");
				request.getRequestDispatcher("/task2.jsp").forward(request, response);
			}
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
