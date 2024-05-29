import java.util.Calendar;

import com.bettinghouse.User;

public aspect Logger {
	pointcut signUpSuccessful(User u,Object p):call(* *(..)) && args(u,p);
	pointcut log(User u) : call(* *(..)) && args(u);
	
	after(User u, Object p) : signUpSuccessful(u,p) {
		
        String methodName = thisJoinPoint.getSignature().getName();
        //User u = param;
        Calendar cal = Calendar.getInstance();
        System.out.println(methodName);
        
        if(methodName.equals("successfulSignUp")) {
        	String line = "Usuario registrado: [nickname = "+u.getNickname()+", password = "+u.getPassword()+"]  fecha: ["+cal.getTime()+"]";
            save("Register.txt",line);
        }
   }
}
