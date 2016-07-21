package function_weibo;

import java.io.IOException;
import weibo4j.Timeline;
import weibo4j.examples.oauth2.Log;
import weibo4j.model.Status;
import weibo4j.model.WeiboException;

public class SendWeibo {
	public SendWeibo(){}
	public void send_weibo(String accessToken,String wbConstant) throws WeiboException, IOException{
		//System.out.println("statrt to send weibo");
		/*Oauth oauth = new Oauth();
		BareBonesBrowserLaunch.openURL(oauth.authorize("code"));
		System.out.println(oauth.authorize("code"));
		System.out.print("Hit enter when it's done.[Enter]:");
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		String code = br.readLine();
		Log.logInfo("code: " + code);
		try{
			System.out.println(oauth.getAccessTokenByCode(code));
		} catch (WeiboException e) {
			if(401 == e.getStatusCode()){
				Log.logInfo("Unable to get the access token.");
			}else{
				e.printStackTrace();
			}
		}*/
		
		
		//String access_token = "2.00X1jziF0WbfZTba0b8c1c0bxj179C";
		//String statuses = "hhh";
		String access_token = accessToken;
		/*if(access_token == "2.00X1jziF0WbfZTba0b8c1c0bxj179C")
			System.out.println("accessToken is right");
		else
			System.out.println("accessToken is wrong");*/
		String statuses = wbConstant;
		Timeline tm = new Timeline(access_token);
		try {
			Status status = tm.updateStatus(statuses);
			Log.logInfo(status.toString());
		} catch (WeiboException e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) throws WeiboException, IOException{
		SendWeibo a = new SendWeibo();
		a.send_weibo("2.00X1jziF0WbfZTba0b8c1c0bxj179C","heihei");
	}

}
