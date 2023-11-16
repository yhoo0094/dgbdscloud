package kr.co.company.hello.controller;

import kr.co.company.hello.exception.BizException;

import org.mybatis.spring.MyBatisSystemException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {
	
	@ExceptionHandler(BizException.class)//파라미터로 예외 타입 받음
	public String handleBizException(Exception e, Model model){
		
		//예외의 클래스명 출력
		model.addAttribute("type", e.getClass().getSimpleName());
		
		//예외의 메세지 출력
		model.addAttribute("msg", e.getMessage());
		
		return "error"; //error.jsp를 리턴
	}
	
	//DuplicateKeyException 오류 처리
	@ExceptionHandler(DuplicateKeyException.class)
	public String handleMbsException(Exception e, Model model){
		model.addAttribute("type", e.getClass().getSimpleName());
		model.addAttribute("msg", e.getMessage());
		return "error"; //error.jsp를 리턴
	}
}
