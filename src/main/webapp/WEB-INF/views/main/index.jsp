<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/assets/css/mysite.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/assets/css/main.css" rel="stylesheet" type="text/css">

</head>

<body>
	<div id="wrap">

		<!-- header -->
		<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
		<!-- /header -->


		<div id="container" class="clearfix">
			<!-- aside 없음 -->
			<div id="full-content">

				<!-- content-head 없음 -->
				<div id="index">

					<img id="profile-img" src="${pageContext.request.contextPath}/assets/image/profile.jpg">

					<div id="greetings">
						<p class="text-xlarge">
							<span class="bold">안녕하세요!!<br>
							안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요.<br> 
							<br> 안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요..<br>
							</span> 
							<br>안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요.<br>
							안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요..<br> <br> 
							안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요.<br> 
							배운 거 있는거 없는 거 다 합쳐서 만들어 놓은 사이트 입니다.<br>
							<br> (자유롭게 꾸며보세요!!)<br> <br>
							<br> <a class="" href="">[방명록에 글 남기기]</a>
						</p>
					</div>
					<!-- //greetings -->

					<div class="clear"></div>

				</div>
				<!-- //index -->

			</div>
			<!-- //full-content -->


		</div>
		<!-- //container -->


		<!-- footer.jsp를 불러와라 -->
		<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
		<!-- //footer -->

	</div>
	<!-- //wrap -->

</body>

</html>
/html>
