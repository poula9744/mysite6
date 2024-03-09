<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/assets/css/mysite.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/assets/css/board.css" rel="stylesheet" type="text/css">

</head>


<body>
	<div id="wrap">

		<!-- header -->
		<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
		<!-- /header -->

		<div id="container" class="clearfix">
			<div id="aside">
				<h2>게시판</h2>
				<ul>
					<li><a href="${pageContext.request.contextPath}/board/list">일반게시판</a></li>
					<li><a href="${pageContext.request.contextPath}/board/commentlist">댓글게시판</a></li>
				</ul>
			</div>
			<!-- //aside -->

			<div id="content">

				<div id="content-head">
					<h3>댓글게시판</h3>
					<div id="location">
						<ul>
							<li>홈</li>
							<li>게시판</li>
							<li class="last">댓글게시판</li>
						</ul>
					</div>
					<div class="clear"></div>
				</div>
				<!-- //content-head -->

				<div id="board">
					<div id="modifyForm">
						<form action="${pageContext.request.contextPath}/board/commentmodify" method="get">
							<!-- 고유번호 -->
							<input type="hidden" name="no" value="${param.no}">
							
							<!-- 작성자 -->
							<div class="form-group">
								<span class="form-text">작성자</span> <span class="form-value">${commentVo.name}</span>
							</div>
							<!-- 작성자 고유번호 -->
							<input type="text" name="userNo" value="${sessionScope.authUser.no}">

							<!-- 조회수 -->
							<div class="form-group">
								<span class="form-text">조회수</span> <span class="form-value">${commentVo.hit}</span>
							</div>

							<!-- 작성일 -->
							<div class="form-group">
								<span class="form-text">작성일</span> <span class="form-value">${commentVo.regDate}</span>
							</div>

							<!-- 제목 -->
							<div class="form-group">
								<label class="form-text" for="txt-title">제목</label> <input type="text" id="txt-title" name="title"
									value="${commentVo.title}">
							</div>



							<!-- 내용 -->
							<div class="form-group">
								<textarea id="txt-content" name="content">
									${commnetVo.content}
								</textarea>
							</div>

							<a id="btn_cancel" href="${pageContext.request.contextPath}/board/list">취소</a>
							<button id="btn_modify" type="submit">수정</button>

						</form>
						<!-- //form -->
					</div>
					<!-- //modifyForm -->
				</div>
				<!-- //board -->
			</div>
			<!-- //content  -->

		</div>
		<!-- //container  -->


		<!-- footer -->
		<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
		<!-- //footer -->
	</div>
	<!-- //wrap -->

</body>

</html>