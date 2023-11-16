package kr.co.company.hello.exception;

//RuntimeException을 상속받으면 예외를 try ~ catch 구문으로 잡아주지 않아도 된다
public class BizException extends RuntimeException {
	
	public BizException(){
		super();
	}
	
	//예외를 파라미터로 받는 생성자
	public BizException(Throwable t){
		super(t);
	}
	
	//문자열 메세지를 파라미터로 받는 생성자
	public BizException(String msg){
		super(msg);
	}
}
