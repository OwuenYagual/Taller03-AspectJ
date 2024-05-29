import com.bettinghouse.User;

public aspect Logger {
	pointcut signUpSuccessful(User u,Object p):call(* *(..)) && args(u,p);
}
