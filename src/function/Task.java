package function;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

import com.dao.UserDao;

import function_weibo.*;
import function_mail.*;
import weibo4j.model.WeiboException;

public class Task extends Thread{
	String task_name;
	int task_id;
	int THIS_task; //指示THIS任务的标号：1.时间  2.收邮件 3.收微博 4.微博限时监听
	int THAT_task; //指示THAT任务的标号：1.发邮件 2.发微博
	int task_state;//指示任务状态： 0.暂停 1.开始 2.暂停 3.结束 可能用不到
	//int THAT_state;//指示THAT任务状态： 0.暂停 1.开始 2.暂停 3.结束
	private String Date;						 //日期
	private String Time;						 //时间
	private String RCV_Mail;					 //收邮件邮箱
	private String RCV_PW;						 //收邮件邮箱密码
	private String Frm_Sina;					 //监听微博的新浪账号
	private String Frm_PW;						 //监听微博的新浪账号密码
	private String SinaText;					 //监听的类容
	private String To_Sina;						 //更新微博的新浪账号
	private String To_PW;						 //更新微博的新浪账号密码
	String Weibo_Content;                        //微博发布内容
	private String Send_Mail;					 //发邮件的163mail
	String Mail_User;							 //邮件授权的账号
	private String Send_PW;						 //发邮件的163mail的密码
	private String To_Mail;						 //发邮件的目的地
	private String Content;				 		 //发邮件的内容
	private String Subject;
	private String Info;						 //任务描述
	private String waitTime;                     //微博监听时间
	private String accessToken;                  //用户access_token码
	
	int weibo_num = 0;                           //微博限时监听函数中使用,表示监听开始时的微博数
	int wait_is_over = 0;                        //微博限时监听函数中使用
	int mail_num = 0;
	
	myTTask myttask = new myTTask();             //微博wait中使用。
	public Task(){}
	
	public Task(String task_name,int task_id,int task_state,int THIS_task,int THAT_task,String Date,String Time,
			    String RCV_Mail,String RCV_PW,String Frm_Sina,String Frm_PW,String SinaText,String To_Sina,
                String To_PW,String Weibo_Content,String Send_Mail,String Mail_User,String Send_PW,String To_Mail,String Content,
                String Subject,String waitTime,String accessToken){  //没有used 和 info信息
		this.task_name     = task_name;
		this.task_id       = task_id;
		this.task_state    = task_state;
		this.THIS_task     = THIS_task;
		this.THAT_task     = THAT_task;
		this.Date          = Date;
		this.Time          = Time;
		this.RCV_Mail      = RCV_Mail;
		this.RCV_PW        = RCV_PW;
		this.Frm_Sina      = Frm_Sina;
		this.Frm_PW        = Frm_PW;
		this.SinaText      = SinaText;
		this.To_Sina       = To_Sina;
		this.To_PW         = To_PW;
		this.Weibo_Content = Weibo_Content;
		this.Send_Mail     = Send_Mail;
		this.Mail_User     = Mail_User;
		this.Send_PW       = Send_PW;
		this.To_Mail       = To_Mail;
		this.Content       = Content;
		this.Subject       = Subject;
		this.Info          = "";
		this.waitTime      = waitTime;
		this.accessToken   = accessToken;
		this.weibo_num     = 0;                     //微博限时监听函数中使用,表示监听开始时的微博数
		this.wait_is_over  = 0;                     //微博限时监听函数中使用
		this.mail_num      = 0;
		this.myttask       = new myTTask();         //微博wait中使用。
	}
	
	public Task(Task t){
		this.task_name     = t.gettask_name();
		this.task_id       = t.gettask_id();
		this.task_state    = t.gettask_state();
		this.THIS_task     = t.getTHIS_task();
		this.THAT_task     = t.getTHAT_task();
		this.Date          = t.getDate();
		this.Time 		   = t.getTime();
		this.RCV_Mail      = t.getRCV_Mail();
		this.RCV_PW        = t.getRCV_PW();
		this.Frm_Sina      = t.getFrm_Sina();
		this.Frm_PW        = t.getFrm_PW();
		this.SinaText      = t.getSinaText();
		this.To_Sina       = t.getTo_Sina();
		this.To_PW         = t.getTo_PW();
		this.Weibo_Content = t.getWeibo_Content();
		this.Send_Mail     = t.getSend_Mail();
		this.Mail_User     = t.getMail_User();
		this.Send_PW       = t.getSend_PW();
		this.To_Mail       = t.getTo_Mail();
		this.Subject       = t.getSubject();
		this.Content       = t.getContent();
		this.Info          = t.getInfo();
		this.waitTime      = t.getWaitTime();
		this.accessToken   = t.getAccessToken();
		this.myttask       = new myTTask();         //微博wait中使用。
		this.weibo_num     = 0;                     //微博限时监听函数中使用,表示监听开始时的微博数
		this.wait_is_over  = 0;                     //微博限时监听函数中使用
		this.mail_num      = 0;
	}
	
	public String gettask_name()	{return this.task_name;}
	public int gettask_id()			{return this.task_id;}
	public int gettask_state()		{return this.task_state;}
	public int getTHIS_task()		{return this.THIS_task;}
	public int getTHAT_task()		{return this.THAT_task;}
	public String getDate()			{return this.Date;}
	public String getTime()			{return this.Time;}
	public String getRCV_Mail()		{return this.RCV_Mail;}
	public String getRCV_PW()		{return this.RCV_PW;}
	public String getFrm_Sina()		{return this.Frm_Sina;}
	public String getFrm_PW()		{return this.Frm_PW;}
	public String getSinaText()		{return this.SinaText;};
	public String getTo_Sina()		{return this.To_Sina;}
	public String getTo_PW()		{return this.To_PW;}
	public String getWeibo_Content(){return this.Weibo_Content;}
	public String getSend_Mail()	{return this.Send_Mail;}
	public String getMail_User()	{return this.Mail_User;}
	public String getSend_PW()		{return this.Send_PW;}
	public String getTo_Mail()		{return this.To_Mail;}
	public String getContent()		{return this.Content;}
	public String getSubject()		{return this.Subject;}
	public String getInfo()			{return this.Info;}
	public String getWaitTime()		{return this.waitTime;}
	public String getAccessToken()	{return this.accessToken;}

	public void settask_name(String Tname)		{this.task_name = Tname;}
	public void settask_id(int ID)		  		{this.task_id = ID;}
	public void settask_state(int State)		{this.task_state = State;}
	public void setTHIS_task(int THIS)			{this.THIS_task = THIS;}
	public void setTHAT_task(int THAT)			{this.THAT_task = THAT;}
	public void setDate(String Date)			{this.Date = Date;}
	public void setTimeMail(String RCV_Mail)	{this.RCV_Mail = RCV_Mail;}
	public void setRCV_PW(String RCV_PW)		{this.RCV_PW = RCV_PW;}
	public void setFrm_Sina(String Frm_Sina)	{this.Frm_Sina = Frm_Sina;}
	public void setFrm_PW(String Frm_PW)		{this.Frm_PW = Frm_PW;}
	public void setTo_Sina(String To_Sina)		{this.To_Mail = To_Sina;}
	public void setTo_PW(String To_PW)			{this.To_PW = To_PW;}
	public void setSend_Mail(String Send_Mail)	{this.Send_Mail = Send_Mail;}
	public void setMail_User(String Mail_User)	{this.Mail_User = Mail_User;}
	public void setSend_PW(String Send_PW)		{this.Send_PW = Send_PW;}
	public void setTo_Mail(String To_Mail)		{this.To_Mail = To_Mail;}
	public void setSubject(String Subject)		{this.Subject = Subject;}
	public void setContent(String Content)		{this.Content = Content;}
	public void setInfo(String Info)			{this.Info = Info;}
	public void setWaitTime(String waitTime)	{this.waitTime = waitTime;}
	public void setAccessToken(String accessToken){this.accessToken = accessToken;}
	public void setWeibo_Content(String Weibo_Content){this.Weibo_Content = Weibo_Content;}

	//微博限时监听
	public class myTTask extends TimerTask{
		int judge_num;
		myTTask(){
			judge_num = 0;
		}
		public void run(){
			FetchWeibo b = new FetchWeibo(accessToken);
			judge_num = b.weibo_num();
			if(judge_num == weibo_num){
				wait_is_over = 1;
				System.out.println("wait_is_over = 1 微博数量是：" + judge_num);
			}
			else 
				wait_is_over = 3;
		}
	}
	
	//转换时间日期格式
	//day 指的是date，包含年月日
	public static Date StringToDate(String day,String time){
		Date date = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		try {
			date = sf.parse(day + " " + time);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}
		
	@SuppressWarnings("deprecation")
	public boolean equal(Date date){
		Date tmp = StringToDate(this.Date,this.Time);
		if(tmp.getYear()     <= date.getYear()   &&
			tmp.getMonth()   <= date.getMonth()  &&
			tmp.getDate()    <= date.getDate()   &&
			tmp.getHours()   <= date.getHours()  &&
			tmp.getMinutes() <= date.getMinutes()&&
			tmp.getSeconds() <= date.getSeconds())
			return true;
		else
			return false;
	}
	
	//一段时间不发微博判断
	public boolean waitweibo() throws InterruptedException{
		wait_is_over= 0;
		myttask = new myTTask();
		FetchWeibo a = new FetchWeibo(accessToken);
		weibo_num = a.weibo_num();
		System.out.println("微博数量是"+weibo_num);
		int wait_time = Integer.parseInt(waitTime);
		Timer timer = new Timer();
		timer.schedule(myttask, wait_time*60*1000);
		//myttask.cancel();
		System.out.println("(Task:225)enter wait loop");
		while(wait_is_over == 0){
			for(int i =0 ; i<100000;i++)
				for(int j = 0; j<100000;j++)
					for(int l =0;l<1000;l++);
			System.out.println("(Task:230)in wait loop");
			if(this.isInterrupted()){
				System.out.println("(Task:230)task is interrupted");
				myttask.cancel();
				return false;
			}
		}
		System.out.println("(Task:231)leave wait loop");
		if(wait_is_over == 1)
			return true;
		else 
			return false;
	}
	
	public boolean fetch_mail(){
		FetchMail a = new FetchMail();
		int num = a.mail_num(RCV_Mail,RCV_PW);
		System.out.println("当前邮件个数为" + num);
		if(num > mail_num){
			mail_num = num;
			return true;
		}
		else{
			return false;
		}
	}
	
	public boolean fetch_weibo(){
		FetchWeibo a = new FetchWeibo(accessToken);
		int num = a.weibo_num();
		System.out.println("当前微博个数为" + num);
		if((num>weibo_num) && (a.getcontent().equals(SinaText))){
			weibo_num = num;
			return true;
		}
		else return false;
	}
	
	public void send_mail(){
		System.out.println(Send_Mail+" "+Mail_User+" "+Send_PW+" "+To_Mail+" "+Content);
		SendMail a = new SendMail();
		a.send_mail(Mail_User,Send_PW,Send_Mail,To_Mail,Subject, Content);
	}
	
	public void send_weibo() throws WeiboException, IOException{
		SendWeibo a = new SendWeibo();
		a.send_weibo(accessToken,Weibo_Content);
	}
	
	@Override
	public void run(){
		System.out.println("task is running now");
		if(THIS_task == 2){
			FetchMail b = new FetchMail();
			mail_num = b.mail_num(RCV_Mail, RCV_PW);
			System.out.println("初始邮件个数为" + mail_num);
		}
		if(THIS_task == 3){
			FetchWeibo b = new FetchWeibo(accessToken);
			weibo_num = b.weibo_num();
			System.out.println("初始微博数为" + weibo_num);
		}
		if(THIS_task == 4){
			try {
				if(waitweibo()){
					if(THAT_task == 1){
						this.send_mail();
						task_state = 3;
					}
					if(THAT_task == 2){
						try {
							this.send_weibo();
						} catch (WeiboException | IOException e1) {
							e1.printStackTrace();
						}
						task_state = 3;
					}
					String sql="update task set state=3 where id=" + task_id;
			  		try {
						UserDao.Update(sql);
					} catch (ClassNotFoundException | SQLException e) {
						e.printStackTrace();
					}	  		
					return;
				}
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	
		while(true){
			if(this.isInterrupted()){
				System.out.println("(Task:344)task is interrupted");
				return ;
			}
			System.out.println("Task_state is "+ this.task_state +" Task.java 188");
			if(task_state == 1){
				System.out.println("task_satate == 1 :Task.java 188");
				if(THIS_task == 1){
					if(this.equal(new Date())){
						System.out.println("run_2");
						if(THAT_task == 1){
							this.send_mail();	
							task_state = 3;
						}
						if(THAT_task == 2){
							try {
								this.send_weibo();
							} catch (WeiboException | IOException e1) {
								e1.printStackTrace();
							}
							task_state = 3;
						}
						String sql="update task set state=3 where id="+task_id;
				  		try {
							UserDao.Update(sql);
						} catch (ClassNotFoundException | SQLException e) {
							e.printStackTrace();
						}	 
						return;
					}
				}
				else if(THIS_task == 2){
					if(fetch_mail()){
						if(THAT_task == 1){
							this.send_mail();
						}
						if(THAT_task == 2){
							try {
								this.send_weibo();
							} catch (WeiboException | IOException e1) {
								e1.printStackTrace();
							}
						}
					}
				}
				else if(THIS_task == 3){
					if(fetch_weibo()){
						if(THAT_task == 1){
							this.send_mail();
						}
						if(THAT_task == 2){
							try {
								this.send_weibo();
							} catch (WeiboException | IOException e1) {
								e1.printStackTrace();
							}
						}
					}
				}
			}
			for(int i =0 ; i<100000;i++)
				for(int j = 0; j<60000;j++)
					for(int l =0; l<1000;l++);
			System.out.println("Loop is over :Task.java 445");
		}
	}
}
