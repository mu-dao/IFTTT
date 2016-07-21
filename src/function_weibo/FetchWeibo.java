package function_weibo;

import weibo4j.Timeline;
import weibo4j.examples.oauth2.Log;
import weibo4j.model.Status;
import weibo4j.model.StatusWapper;
import weibo4j.model.WeiboException;

public class FetchWeibo {
	public String access_token /*= "2.00X1jziF0WbfZTba0b8c1c0bxj179C"*/;
	public Timeline tm /*= new Timeline(access_token)*/;
	public FetchWeibo(String accessToken){
		System.out.println("FetchWeibo is created.accessToken is: "+ accessToken);
		access_token = accessToken;
		tm = new Timeline(access_token);
		}
	
	
	public int weibo_num(/*String accessToken*/){
		//String access_token = "2.00X1jziF0WbfZTba0b8c1c0bxj179C";
		//String access_token = accessToken;
		//Timeline tm = new Timeline(access_token);
		try {
			StatusWapper status = tm.getUserTimeline();
			for(Status s : status.getStatuses()){
				Log.logInfo(s.toString());
			}
			return (int) status.getTotalNumber();
		} catch (WeiboException e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public String getcontent(/*String accessToken*/){
		//String access_token = "2.00X1jziF0WbfZTba0b8c1c0bxj179C";
		//Timeline tm = new Timeline(access_token);
		//String access_token = accessToken;
		//Timeline tm = new Timeline(access_token);
		try {
			String Content = "";
			String tmp = "";
			StatusWapper status = tm.getUserTimeline();
			for(Status s : status.getStatuses()){
				tmp = s.toString();
				break;
			}
			int i,j;
			for(i = 0;i < tmp.length();i++){
				if(tmp.charAt(i) == 't' && tmp.charAt(i+1) == 'e' &&tmp.charAt(i+2) == 'x' &&tmp.charAt(i+3) == 't' && tmp.charAt(i+4) == '=' )
					break;
			}
			for(j = i+4;j < tmp.length();j++)
			{
				if(tmp.charAt(j) == 's' && tmp.charAt(j+1) == 'o' &&tmp.charAt(j+2) == 'u' &&tmp.charAt(j+3) == 'r' && tmp.charAt(j+4) == 'c' )
					break;
			}
			Content = tmp.substring(i+5, j-2);
			return Content;
		} catch (WeiboException e) {
			e.printStackTrace();
		}
		return null;
		
	}
	
	public boolean fetch_weibo(/*String accessToken*/){
		//String access_token = "2.00X1jziF0WbfZTba0b8c1c0bxj179C";
		//Timeline tm = new Timeline(access_token);
		//String access_token = accessToken;
		//Timeline tm = new Timeline(access_token);
		int weibo_num = weibo_num();
		
		while(true){
			if(weibo_num()>weibo_num){
				return true;
			}
			System.out.println(weibo_num());
			for(long i = 0; i< 1000000000;i++)
				for(long j = 0;j<10;j++)
					;
		}
	}
	
	public static void main(String[] args){
		FetchWeibo a = new FetchWeibo("2.00X1jziF0WbfZTba0b8c1c0bxj179C");
		int num =a.weibo_num();
		System.out.println(num);
		if(a.fetch_weibo()){
		String s = a.getcontent();
		System.out.println(s);
		}
	}

}
