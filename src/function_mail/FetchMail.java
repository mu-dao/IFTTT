package function_mail;

import java.util.Properties;
import javax.mail.Folder;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;
import javax.mail.Store;

public class FetchMail {
    final static String protocol = "pop3";
    final static boolean isSSL = true;
    final static String host = "pop.163.com";
    final static int port = 995;
    int size = 0;
    public FetchMail(){}
    
    //获取用户收件箱中邮件的数目
    public int mail_num(String username, String password){
    	
        Properties props = new Properties();
        props.put("mail.pop3.ssl.enable", isSSL);
        props.put("mail.pop3.host", host);
        props.put("mail.pop3.port", port);

        Session session = Session.getDefaultInstance(props);

        Store store = null;
        Folder folder = null;
        try {
            store = session.getStore(protocol);
            store.connect(username, password);

            folder = store.getFolder("INBOX");
            folder.open(Folder.READ_ONLY);
            size = folder.getMessageCount();//获得该用户收件箱中邮件的数目
            
        } catch (NoSuchProviderException e) {
            e.printStackTrace();
        } catch (MessagingException e) {
            e.printStackTrace();
        } finally {
            try {
                if (folder != null) {
                    folder.close(false);
                }
                if (store != null) {
                    store.close();
                }
            } catch (MessagingException e) {
                e.printStackTrace();
            }
        }
        System.out.println("接收完毕！");
        return size;
    }
    
    //每隔一段时间就判断用户是否收到了新邮件，即收件箱数目是否变大
	public boolean fetch_mail(String username, String password){
		int mail_num = mail_num(username,password);
		while(true){
			if(mail_num(username,password) > mail_num){
				return true;
			}
			System.out.println(mail_num(username,password));
			for(long i = 0; i < 100000000; i++)
				for(long j = 0; j < 100; j++);
		}
	}
}
