import java.util.Calendar;
import com.bettinghouse.User;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Calendar;

public aspect Logger {
	pointcut signUpSuccessful(User u,Object p):call(* *(..)) && args(u,p);
	pointcut log(User u) : call(* *(..)) && args(u);
		
	after(User u, Object p) : signUpSuccessful(u,p) {
        String methodName = thisJoinPoint.getSignature().getName();
        Calendar cal = Calendar.getInstance();
        //System.out.println(methodName);
        //System.out.println(methodName);
       
        if(methodName.equals("successfulSignUp")) {
        	String line = "Usuario registrado: [nickname = "+u.getNickname()+", password = "+u.getPassword()+"]  fecha: ["+cal.getTime()+"]";
            save("Register.txt",line);
            System.out.println("**** User created ****");
        }
	}
    	after(User u) : log(u) {
            String methodName = thisJoinPoint.getSignature().getName();
            Calendar cal = Calendar.getInstance();
            //System.out.println(methodName);
            //System.out.println(methodName);
    	
        if(methodName.equals("effectiveLogIn")) {
        	//System.out.println(methodName);
        	String line = "Sesión iniciada por usuario: ["+u.getNickname()+"]  fecha: ["+cal.getTime()+"]";
	        save("Log.txt",line);
        }else if(methodName.equals("effectiveLogOut")) {
        	String line = "Sesión cerrada por usuario: ["+u.getNickname()+"]  fecha: ["+cal.getTime()+"]";
        	save("Log.txt",line);
        }
	}
	
	public void save(String path, String line) {
		try {	
    		File file = new File(path);
            Calendar cal = Calendar.getInstance();
            FileWriter fw = new FileWriter(file, true);
            BufferedWriter bw = new BufferedWriter(fw);
            bw.write(line);
            bw.newLine();
            System.out.println("Escritura exitosa en "+path);
            bw.close();
        }catch(IOException e) {
        	System.err.println("Error al escribir en el archivo: " + e.getMessage());
        }
	}
    	
}
