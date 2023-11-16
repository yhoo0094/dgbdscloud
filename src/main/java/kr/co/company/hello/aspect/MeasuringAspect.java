package kr.co.company.hello.aspect;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class MeasuringAspect {
	
	@Around("execution(* kr.co.company.hello.service.*Service.*(..))") //~Service 클래스의 모든 메소드
	public Object measuringMethodRunningTime(ProceedingJoinPoint joinpoint) throws Throwable{
		long start = System.currentTimeMillis();

		try {
			return joinpoint.proceed();//타겟메서드 실행
		} finally {
			long result = System.currentTimeMillis() - start;
			String targetMethodName = joinpoint.getSignature().getName();
			System.out.println(targetMethodName + " running time is " + result);
		}
	}
}
