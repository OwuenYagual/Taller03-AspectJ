import com.bettinghouse.User;

public aspect Logger {
	pointcut signUpSuccessful(User u,Object p):call(* *(..)) && args(u,p);
	pointcut log(User u) : call(* *(..)) && args(u);
}
