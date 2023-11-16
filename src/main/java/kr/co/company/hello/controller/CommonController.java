package kr.co.company.hello.controller;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;

import kr.co.company.hello.service.CommonService;

@Controller
public class CommonController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private CommonService commonService;
	
	//홈페이지
	@RequestMapping("/")
	public String index(){
		Map<String, Object> result = commonService.selectServerTime("");
		return "index";
	}
	
	//제출하기
	@RequestMapping("/insertAns.do")
	public void insertAns(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> inData = new HashMap<String, Object>();
		Enumeration<String> paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String key = paramNames.nextElement();
            String value = request.getParameter(key);
            inData.put(key, value);
        }
		
		Map<String, Object> outData = commonService.insertAns((StringBuilder)request.getAttribute("IN_LOG_STR"), inData);

		Gson gson = new Gson();
		String json = gson.toJson(outData);
		response.setContentType("application/json; charset=UTF-8");
		response.getWriter().print(json);	//결과 json형태로 담아서 보내기
	}		
}
