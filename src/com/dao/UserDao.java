package com.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import com.entity.Message;
import com.entity.User;

public class UserDao {
	private static final String DRIVER = "com.mysql.jdbc.Driver";
	private static final String URL = "jdbc:mysql://localhost:3306/ifttt";
	private static final String DBNAME = "root";
	private static final String DBPASS = "123456";
	private static Connection conn = null;
	private static Statement stm = null;
	
	//创建UserDao对象，默认连接本地已创建好的ifttt数据库
	public UserDao(){
		try{
			if(conn == null){
				Class.forName(DRIVER);//加载数据库驱动
				conn = DriverManager.getConnection(URL, DBNAME, DBPASS);//连接数据库
			}
			if(stm == null){
				stm = conn.createStatement();//statement对象用于执行静态sql语句
			}
		} catch(Exception e){
			e.printStackTrace();
		}
	}
	
	//关闭数据库连接
	private static void close(){
		if(stm != null){
			try{
				stm.close();
			} catch(SQLException e){
				e.printStackTrace();
			}finally {
				stm = null;
			}
		}
		if(conn != null){
			try{
				conn.close();
			} catch(SQLException e){
				e.printStackTrace();
			}finally {
				conn = null;
			}
		}
	}
	
	//更新数据库
	private static int executeUpdate(String sql){
		try{
			new UserDao();
			return stm.executeUpdate(sql);//返回数据库的表的行数，如果表为空返回0
		} catch(SQLException e){
			e.printStackTrace();
			return -2;
		}
	}
	
	//用户登录时调用，根据用户名查找用户名和密码
	public static User Login(String username){
		new UserDao();
		String sql = "select * from users where name = ?";
		PreparedStatement psm = null;
		ResultSet res = null;
		User user = null;
		try{
			psm = conn.prepareStatement(sql);
			psm.setString(1, username);//将sql语句中的?替换成username
			res = psm.executeQuery();//执行查询语句，结果存储在res中
			if(res.next()){
				user = new User();
				user.setName(res.getString("name"));
				user.setPassword(res.getString("password"));
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		UserDao.close();
		return user;
	}
	
	//用户注册，以user中的数据更新数据库
	public static void Register(User user){
		try{
			StringBuffer sql = new StringBuffer("insert into users set ");
			sql.append("name = '" + user.getName() + "',");
			sql.append("password = '" + user.getPassword() + "',");
			sql.append("sex = '" + user.getSex() + "',");
			sql.append("year = '" + user.getYear() + "',");
			sql.append("month = '" + user.getMonth() + "',");
			sql.append("day = '" + user.getDay() + "',");
			sql.append("email = '" + user.getEmail() + "',");
			sql.append("phone = '" + user.getPhone() + "',");
			sql.append("money = 1000,point = 0,level = 0");//新注册的用户，初始金钱为1000
			executeUpdate(sql.toString());
		} catch(Exception e){
			e.printStackTrace();
		}
		UserDao.close();
	}
	
	//获取用户信息
	public static User getInfo(String username){
		new UserDao();
		String sql = "select * from users where name = ?";
		PreparedStatement psm = null;
		ResultSet res = null;
		User user = null;
		try{
			psm = conn.prepareStatement(sql);
			psm.setString(1, username);	//以select * from user where name = username 查询数据库
			res = psm.executeQuery();	//执行查询并返回结果
			if(res.next()){
				user = new User();
				user.setName(res.getString("name"));
				user.setPassword(res.getString("password"));
				user.setYear(res.getString("year"));
				user.setMonth(res.getString("month"));
				user.setDay(res.getString("day"));
				user.setSex(res.getString("sex"));
				user.setEmail(res.getString("email"));
				user.setPhone(res.getString("phone"));
				user.setMoney(res.getString("money"));
				user.setLevel(res.getString("level"));
				user.setPoint(res.getString("point"));
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		UserDao.close();
		return user;
	}
	
	//设置用户信息
	public static void setInfo(User user){
		try{
			StringBuffer sql = new StringBuffer("update users set ");
			sql.append("sex = '" + user.getSex() + "',");
			sql.append("year = '" + user.getYear() + "',");
			sql.append("month = '" + user.getMonth() + "',");
			sql.append("day = '" + user.getDay() + "',");
			sql.append("email = '" + user.getEmail() + "',");
			sql.append("phone = '" + user.getPhone() + "',");
			sql.append("money = " + user.getMoney());
			sql.append("where name = '" + user.getName() + "'");
			executeUpdate(sql.toString());
		} catch(Exception e){
			e.printStackTrace();
		}
		UserDao.close();
	}
	
	//更改用户密码
	public static void resetPass(User user){
		try{
			StringBuffer sql = new StringBuffer("update users set ");
			sql.append("password = '" + user.getPassword() + "' where name = '" + user.getName() + "'");
			executeUpdate(sql.toString());
		} catch(Exception e){
			e.printStackTrace();
		}
		UserDao.close();
	}
	
	//发送消息
	public static void sendMsg(Message message){
		try{
			StringBuffer sql = new StringBuffer("insert messages set ");
			sql.append("isall = '"      + message.getIsAll()      + "',");
			sql.append("tomember = '"   + message.getToMember()   + "',");
			sql.append("frommember = '" + message.getFromMember() + "',");
			sql.append("title = '"      + message.getTitle()      + "',");
			sql.append("content = '"    + message.getContent()    + "',");
			sql.append("time = '"       + message.getTime()       + "'");
			executeUpdate(sql.toString());
		} catch(Exception e){
			e.printStackTrace();
		}
		UserDao.close();
	}
	
	//执行sql查询语句
	public static ResultSet executeQuery(String sql){
		new UserDao();
		ResultSet res = null;
		try{
			res = stm.executeQuery(sql);
		} catch(SQLException e){
			e.printStackTrace();
		}
		return res;
	}
	
	//获得某个member接收到的全部消息
	public static Vector<Message> getAllMsg(String tomember){
		StringBuffer sql = new StringBuffer("select * from messages where tomember = '" + tomember + "' ");
		sql.append("or isall = true and frommember != '" + tomember + "' order by time desc;");
		Vector<Message> messages = new Vector<Message>();
		ResultSet res = null;
		try{
			res = executeQuery(sql.toString());
			Message message;
			while(res.next()){
				message = new Message();
				message.setId(Integer.toString(res.getInt("id")));
				message.setIsAll(Boolean.toString(res.getBoolean("isall")));
				message.setFromMember(res.getString("frommember"));
				message.setTitle(res.getString("title"));
				message.setContent(res.getString("content"));
				message.setTime(res.getString("time"));
				messages.add(message);
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		UserDao.close();
		return messages;
	}
	
	//获得某个member发送出去的全部消息
	public static Vector<Message> getAllMsgSend(String frommember){
		StringBuffer sql = new StringBuffer("select * from messages where frommember='" + frommember + "' order by time desc;");
		Vector<Message> messages = new Vector<Message>();
		ResultSet res = null;
		try{
			res = executeQuery(sql.toString());
			Message message;
			while(res.next()){
				message = new Message();
				message.setId(Integer.toString(res.getInt("id")));
				message.setIsAll(Boolean.toString(res.getBoolean("isall")));
				message.setToMember(res.getString("tomember"));
				message.setTitle(res.getString("title"));
				message.setContent(res.getString("content"));
				message.setTime(res.getString("time"));
				messages.add(message);
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		UserDao.close();
		return messages;
	}
	
	//获得全体用户信息
	public static Vector<User> getAllUser(){
		StringBuffer sql = new StringBuffer("select * from users where name != 'admin';");
		Vector<User> users = new Vector<User>();
		ResultSet res = null;
		try{
			res = executeQuery(sql.toString());
			User user;
			while(res.next()){
				user = new User();
				user.setName(res.getString("name"));
				user.setSex(res.getString("sex"));
				user.setYear(res.getString("year"));
				user.setMonth(res.getString("month"));
				user.setDay(res.getString("day"));
				user.setEmail(res.getString("email"));
				user.setPhone(res.getString("phone"));
				user.setMoney(Integer.toString(res.getInt("money")));
				user.setPoint(Integer.toString(res.getInt("point")));
				user.setLevel(Integer.toString(res.getInt("level")));
				users.add(user);
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		UserDao.close();
		return users;
	}
	
	//删除用户名为username的用户
	public static void deleteUser(String username){
		try{
			StringBuffer sql = new StringBuffer("delete from users where name = '" + username + "'");
			executeUpdate(sql.toString());
		}catch(Exception e){
			e.printStackTrace();
		}
		UserDao.close();
	}
	
	//删除ID为id的消息
	public static void deleteMsg(String id){
		try{
			StringBuffer sql = new StringBuffer("delete from messages where id=" + id);
			executeUpdate(sql.toString());
		} catch(Exception e){
			e.printStackTrace();
		}
		UserDao.close();
	}
	
	//用户升级
	public static void updateLevel(String username, String level){
		try{
			StringBuffer sql = new StringBuffer("update users set level = " + level + " where name = '" + username + "'");
			executeUpdate(sql.toString());
		}catch(Exception e){
			e.printStackTrace();
		}
		UserDao.close();
	}
}
