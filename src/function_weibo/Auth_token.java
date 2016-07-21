package function_weibo;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.InetSocketAddress;

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;

import weibo4j.Oauth;
import weibo4j.examples.oauth2.Log;
import weibo4j.http.AccessToken;
import weibo4j.model.WeiboException;
import weibo4j.util.BareBonesBrowserLaunch;

public class Auth_token {
	private MyHttpServer server;
	public String request;
	static String code;
	Object obj;

	public class MyHttpServer extends Thread {
		private HttpServer hs;

		public void start() {
			super.start();
			request = null;
			try {
				hs = HttpServer.create(new InetSocketAddress(8099), 0);
				hs.createContext("/callback.jsp", new MyHandler(this));
				hs.setExecutor(null);
				hs.start();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		public void close() {
			hs.stop(0);
			synchronized (obj) {
				obj.notifyAll();
			}
		}
	}

	class MyHandler implements HttpHandler {
		public MyHandler(MyHttpServer arg) {
			server = arg;
		}

		public void handle(HttpExchange t) throws IOException {
			System.out.println(t.getRequestURI().toString());
			InputStream is = t.getRequestBody();
			byte[] temp = new byte[is.available()];
			is.read(temp);
			request = new String(t.getRequestURI().toString());
			System.out.println(request);
			String response = "Weibo Code Get!";
			t.sendResponseHeaders(200, response.length());
			OutputStream os = t.getResponseBody();
			os.write(response.getBytes());
			os.close();
			server.close();
		}
	}

	class analyser extends Thread {
		@Override
		public synchronized void start() {
			super.start();
			obj = new Object();
			synchronized (obj) {
				while (request == null) {
					try {
						obj.wait();
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
			code = request;
			code = code.split("=")[1];
			System.out.println("code:" + code);
		}
	}

	public static AccessToken getAccessToken() {
		Auth_token auth = new Auth_token();
		Oauth oauth = new Oauth();
		try {
			BareBonesBrowserLaunch.openURL(oauth.authorize("code")); //打开账号输入页面
		} catch (WeiboException e) {
			e.printStackTrace();
		}
		MyHttpServer server = auth.new MyHttpServer();
		server.start(); //运行线程，创建request
		analyser analy = auth.new analyser();
		analy.start();
		try {
			analy.join();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		System.out.println("code: " + code);
		Log.logInfo("code: " + code);
		try {
			return oauth.getAccessTokenByCode(code);
		} catch (WeiboException e) {
			if (401 == e.getStatusCode()) {
				Log.logInfo("Unable to get the access token.");
			} else {
				e.printStackTrace();
			}
		}
		return null;
	}

	public static void main(String[] args){
		Auth_token.getAccessToken();
		
	
	}
}
