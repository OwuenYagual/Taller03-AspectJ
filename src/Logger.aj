import com.bettinghouse.User;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Calendar;

public aspect Logger {
	pointcut signUpSuccessful(User u,Object p):call(* *(..)) && args(u,p);
	after(User u) : log(u) {
		
        String methodName = thisJoinPoint.getSignature().getName();
        //User u = param;
        Calendar cal = Calendar.getInstance();
        //System.out.println(methodName);
        
        if(methodName.equals("successfulSignUp")) {
        	String line = "Usuario registrado: [nickname = "+u.getNickname()+", password = "+u.getPassword()+"]  fecha: ["+cal.getTime()+"]";
            save("Register.txt",line);
        }else if(methodName.equals("effectiveLogIn")) {
        	//System.out.println(methodName);
        	String line = "Sesión iniciada por usuario: ["+u.getNickname()+"]  fecha: ["+cal.getTime()+"]";
	        save("Log.txt",line);
        }
}