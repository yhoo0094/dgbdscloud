package kr.co.company.hello.Interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class MeasuringInterceptor extends HandlerInterceptorAdapter {

	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		long beginTime = (long) request.getAttribute("mi.beginTime");
		long endTime = System.currentTimeMillis();
		
		System.out.println(request.getRequestURI() + "실행시간: " + (endTime - beginTime));
	}

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		request.setAttribute("mi.beginTime", System.currentTimeMillis());
		return true;
	}
	
}
