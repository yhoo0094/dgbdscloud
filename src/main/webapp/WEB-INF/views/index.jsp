<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta property="og:url" content="https://dgbdscloud.click">
    <meta property="og:title" content="클라우드 사내튜터">
    <meta property="og:type" content="website">
    <meta property="og:image" content="https://dgbdscloud.click/resources/images/cloud_background.jpg">
    <meta property="og:description" content="공유기능 | 열심히 코드를 공부합시다.">
	<title>dgbdscloud</title>
	
	<link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/resources/images/cloud-data.png"> <!-- title 아이콘 변경 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/styles/style.css">
	
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/index.js"></script>
</head>
<body>
	<div class="tc">
		<div class="content display-inb tl">
			<form action="#" id="qForm">
				<div class="titleBox">
					<h1><b>클라우드(AWS) 서버 구축과</b></h1>
					<h1><b>도메인 설정을 통한 나만의 웹 사이트 만들기</b></h1>
				</div>
				
				<div class="infoBox">
					<p><b>안녕하세요, 디비디데이터시스템 서비스개발팀 김상민 프로입니다.</b></p>
					<p><b>사내 튜터를 진행하기에 앞서 간단한 설문을 진행하고자 합니다.</b></p>
					<p><b>해당 설문은 연수 참여 여부와 상관 없이 <span class="colorBlue">누구나 참여 가능</span>합니다.</b></p> 
					<p><b>연수 관련 궁금한 사항은 <a href="https://open.kakao.com/o/gxm3w9Tf" target='_blank'>카카오톡 오픈채팅</a>으로 문의 부탁드립니다.</b></p>
					<p><b>연수에 참여하기 위해 
					<a href="https://ap-northeast-2.console.aws.amazon.com/console/home?region=ap-northeast-2" target='_blank'>AWS</a>
					,
					<a href="https://www.gabia.com/" target='_blank'>가비아</a>
					  계정이 필요합니다(
						<a href="<%=request.getContextPath()%>/resources\files\part1_AWS회원가입.pdf" download="" class="fileDownLink">
							<img src="<%=request.getContextPath()%>resources\images\icon-pdf16.png" alt="icon-pdf16.png" class="iconImg">part1_AWS회원가입.pdf
						</a>
						).</b></p>
					<p><b><span class="colorRed">◈ 연수 참여 신청은 사내 성과관리 시스템을 이용해주시기 바랍니다.</span></b></p>
				</div>
			
				<div class="qBox">
					<p class="question redStar">Q) 이름</p>
					<input type="text" id="empName" name="empName" title="이름" maxlength="10" class="form-control w20 required"/>
				</div>
				
				<div class="qBox">
					<p class="question redStar">Q) 사번</p>
					<input type="text" id="empNum" name="empNum" title="사번" maxlength="7" class="form-control w20 required onlyNum"/>
				</div>
			
				<div class="qBox">
					<p class="question redStar">Q) 직급</p>
					<select id="empRank" name="empRank" title="직급" class="form-control w20 required">
						<option value="">선택하세요</option>
						<option value="1">1급</option>
						<option value="2">2급</option>
						<option value="3">3급</option>
						<option value="4">4급</option>
						<option value="5">5급</option>
						<option value="6">6급</option>
						<option value="7">7급</option>
						<option value="8">인턴</option>
					</select>
				</div>
				
				<div class="qBox">
					<p class="question">Q) 클라우드에 대해 얼마나 알고 있나요?</p>
					<p><input type="radio" name="cloudInt" class="form-check-input" value="4"> 클라우드를 활용해 프로젝트를 진행해 봤다.</p>
					<p><input type="radio" name="cloudInt" class="form-check-input" value="3"> 기본적인 개념 및 용어를 숙지하고 있다.</p>
					<p><input type="radio" name="cloudInt" class="form-check-input" value="2"> 한 번 이상 공부해 본 적이 있으나, 거의 모른다.</p>
					<p><input type="radio" name="cloudInt" class="form-check-input" value="1"> 전혀 모른다.</p>
					<p>
						<input type="radio" id="cloudIntEtcChk" name="cloudInt" class="form-check-input ectChk" value="5"> 기타 
						<input type="text" id="cloudIntEtc" name="cloudIntEtc" maxlength="50" class="form-control w50 display-inb etcInput" disabled="disabled"/>
					</p>
				</div>
				
				<div class="qBox">
					<p class="question">Q) 이번 연수를 통해 배웠으면 싶은 것은 무엇인가요?</p>
					<textarea name="whatCont" rows="5" cols="100"  maxlength="500" class="form-control"></textarea>
				</div>
				
				<div class="qBox">
					<p class="question">Q) 앞으로 듣고 싶은 연수가 있나요?</p>
					<textarea name="whatFuture" rows="5" cols="100"  maxlength="500" class="form-control"></textarea>
				</div>
				
				<div class="qBox">
					<p class="question">Q) 기타 의견</p>
					<textarea name="whatEtc" rows="5" cols="100"  maxlength="500" class="form-control"></textarea>
				</div>
				
				<div class="btnBox">
					<button type="button" onclick="insertAns()" class="btn btn-success">제출하기</button>
				</div>
			</form>	
		</div>
	</div>
</body>
</html>