package function_mail;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendMail {
	final static boolean isSSL = true;
    final static String host = "smtp.163.com";
    final static int port = 465;
    final static boolean isAuth = true;
    
    public SendMail(){}
    
    //发送163邮件
    public void send_mail(final String username, final String password, String from, String to, String subject, String content){
    	//设置properties
    	Properties props = new Properties();
    	props.put("mail.smtp.ssl.enable", isSSL);
    	props.put("mail.smtp.host", host);
    	props.put("mail.smtp.port", port);
    	props.put("mail.smtp.auth", isAuth);

	    try {
	    	//会话
	    	Session session = Session.getInstance(props, new Authenticator() {
	    		@Override
		    	protected PasswordAuthentication getPasswordAuthentication() {
		    		System.out.println("inside session");
		    		return new PasswordAuthentication(username, password);
		        }
		    });
	    	//设置message
	    	Message message = new MimeMessage(session);
	    	message.setFrom(new InternetAddress(from));
	    	message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
	    	message.setSubject(subject);
	    	message.setText(content);
	    	Transport.send(message);//发送邮件
	      
	    } catch (AddressException e) {
	    	e.printStackTrace();
	    } catch (MessagingException e) {
	    	e.printStackTrace();
	    }
	    System.out.println("发送完毕！");
	}
}