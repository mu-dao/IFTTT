package function;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import function.Task;
import com.dao.UserDao;
import function_weibo.*;

public class TaskControl {
	private static ArrayList<Task> TASK = new ArrayList<Task>();            //利用ArrayList实现的线程池，用于对任务进行管理
	private static int flag = 0;

	//使线程池中的第i个任务开始执行
	public void run(int i){
		System.out.println("start:"+ i);
		TASK.get(i).run();
		System.out.println("start_second");
	}
	
	public int getFLAG(){
		return flag;
	}
	public ArrayList<Task> getTASK(){
		return TASK;
	}
	public void setFLAG(int i){
		flag = i;
	}
	public void setTASK(ArrayList<Task> task){
		TASK = task;
	}
	
	//所有信息存入数据库中，除了used 和 info 其余数据用来创建task,同时将新建的任务运行起来。最后修改数据库中的经验值和剩余金额
	public void CreateTask(String Uname,String Tname,int ID,int State,int THIS,int THAT,String Date,String Time,
		    String RCV_Mail,String RCV_PW,String Frm_Sina,String Frm_PW,String SinaText,String To_Sina,
            String To_PW,String Weibo_Content,String Send_Mail,String Mail_User,String Send_PW,String To_Mail,String Content,String Subject,
            String Info,String WaitTime) throws ClassNotFoundException, SQLException{
		
		String accessToken = "accessToken";
		//任务和微博相关，取accessToken
		if(THIS == 3 || THIS == 4 || THAT == 2){
			accessToken = Auth_token.getAccessToken().getAccessToken(); //a.getAccessToken()返回的是accessToken类，类中也有getAccessToken()函数返回String类的token码
			System.out.println("got accessToken, it is : "+ accessToken);
		}
		
		//查找task表中最大的ID
		ResultSet rst = UserDao.Querry("select MAX(ID) from task");
		int num = 0;
		while(rst.next()){
			if(rst.getString(1) != null)
				num = Integer.parseInt(rst.getString(1));
		}
		int id = num + 1;
		ArrayList<Task> task = getTASK();
		task.add(new Task(Tname,id,State,THIS,THAT,Date,Time,RCV_Mail,RCV_PW,Frm_Sina,Frm_PW,SinaText,To_Sina,To_PW,Weibo_Content,Send_Mail,Mail_User,Send_PW,To_Mail,Content,Subject,WaitTime,accessToken));
		int i = task.size();
		System.out.println("(TaskControl 88)task size is"+i);
		setTASK(task);
		String sql = "insert into task values("+id+",'"+Tname+"','"+Uname+"','"+State+"',"+THIS+","+THAT+",'"+Date+"','"+Time+"','"+RCV_Mail+"','"+RCV_PW+"','"+Frm_Sina+"','"+Frm_PW+"','"+SinaText+"','"+To_Sina+"','"+To_PW+"','"+Weibo_Content+"','"+Send_Mail+"','"+Mail_User+"','"+Send_PW+"','"+To_Mail+"','"+Content+"','"+Subject+"','"+Info+"','"+WaitTime+"','"+accessToken+"')";
		UserDao.Update(sql);
		String sql2 = "update users set money=money-10,point=point+10 where name='"+Uname+"'";
		System.out.println(sql2);
		UserDao.Update(sql2);
		ResultSet rst2 = UserDao.Querry("select point from users where name='"+Uname+"'");
		if(rst2.next()){
			if(Integer.parseInt(rst2.getString(1))%100 == 0){
				String sql3 = "update users set level=level+1 where name='"+Uname+"'";
				UserDao.Update(sql3);
			}
		}
	}
	
	public void Update() throws NumberFormatException, SQLException, ClassNotFoundException{
		System.out.println("flag is " + getFLAG());
		if(getFLAG() == 0){
			System.out.println(" first");
			String sql = "select * from task";
			ResultSet rst = UserDao.Querry(sql);
			ArrayList<Task> task = getTASK();
			int i = 0;
			while(rst.next()){
				task.add(new Task(rst.getString(2),Integer.parseInt(rst.getString(1)),2,Integer.parseInt(rst.getString(5)),Integer.parseInt(rst.getString(6)),rst.getString(7),rst.getString(8),rst.getString(9),rst.getString(10),rst.getString(11),rst.getString(12),rst.getString(13),rst.getString(14),rst.getString(15), rst.getString(16), rst.getString(17),rst.getString(18), rst.getString(19), rst.getString(20), rst.getString(21), rst.getString(22),/*rst.getString(23),rst.getString(24),*/rst.getString(24),rst.getString(25)));
				/*状态全部设成暂停态*/
				/*if(Integer.parseInt(rst.getString(4)) == 1)
					task.get(i).settask_state(2);  //如果任务状态是1，把状态改成2*/
				System.out.println("after update task size is "+ i);
				i++;
			}
			setTASK(task);
			setFLAG(2);
		}
	}
}