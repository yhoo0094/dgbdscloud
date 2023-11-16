package kr.co.company.hello.service;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommonService {
	
	@Autowired
	SqlSession sqlSession; //SqlSession 빈 DI
	
	public Map<String, Object> selectServerTime(String str) {
		Map<String, Object> result = sqlSession.selectOne("mappers.commonMapper.selectServerTime", str);
		return result;
	}
	
	public Map<String, Object> insertAns(StringBuilder logStr, Map<String, Object> inData) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		//사번 존재여부 확인
		Boolean isExist = sqlSession.selectOne("mappers.commonMapper.isExistEmpNum", inData);
		if(!isExist) {
			result.put("RESULT", "FAIL");
			result.put("MSG", "이미 해당 사번으로 제출된 자료가 존재합니다.");
		} else {
			int cnt = sqlSession.insert("mappers.commonMapper.insertAns", inData);
			if(cnt == 1) {
				result.put("RESULT", "SUCCESS");
			} else {
				result.put("RESULT", "FAIL");
			}
		}
		return result;
	}	
}
