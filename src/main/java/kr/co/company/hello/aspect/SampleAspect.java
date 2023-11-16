package kr.co.company.hello.aspect;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

@Component//자동으로 Bean 등록
@Aspect
public class SampleAspect {
	
	//execution(리턴타입 적용경로)
	@Before("execution(* kr.co.company.hello..*.*(..))")//advice
	public void before(JoinPoint joinPoint){
		String targetMethodName =
				joinPoint.getSignature().getName();//호출된 메소드명 반환
		
		System.out.println(targetMethodName);
	}
}
