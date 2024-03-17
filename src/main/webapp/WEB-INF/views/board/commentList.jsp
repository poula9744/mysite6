<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/assets/css/mysite.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/assets/css/board.css" rel="stylesheet" type="text/css">
<!-- Axios 라이브러리 포함(원래는 아래에 씀) -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
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
					<div id="list">
						<form action="${pageContext.request.contextPath}/board/searchlist" method="get">
							<div class="form-group text-right">
								<input type="text" name="search">
								<button type="submit" id=btn_search>검색</button>
							</div>
						</form>
						
					<table>
							<thead>
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>글쓴이</th>
									<th>조회수</th>
									<th>작성일</th>
									<th>관리</th>
								</tr>
							</thead>
							<tbody id="boardListArea">
									<!-- 방명록 글 리스트 -->
							</tbody>
					</table>
						<div id="paging">
							<ul>
								<li><a href="">◀</a></li>
								<li><a href="">1</a></li>
								<li><a href="">2</a></li>
								<li><a href="">3</a></li>
								<li><a href="">4</a></li>
								<li class="active"><a href="">5</a></li>
								<li><a href="">6</a></li>
								<li><a href="">7</a></li>
								<li><a href="">8</a></li>
								<li><a href="">9</a></li>
								<li><a href="">10</a></li>
								<li><a href="">▶</a></li>
							</ul>
							
							
							<div class="clear"></div>
						</div>
						<a id="btn_write" href="${pageContext.request.contextPath}/board/commentwriteform">글쓰기</a>
					
					</div>
					<!-- //list -->
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
<script>
document.addEventListener("DOMContentLoaded", function(){
	
	//리스트요청
	getListAndRender();	
	
	//제목을 클릭했을 때 --> commentRead를 불러옴
	let clickTitle = document.querySelector(".text-left");
	clickTitle.addEventListener("click", clickAndGo);
	
	
});//document.addEventListener

//////////////////////////////////////////////////////////////////////
///////////////////////////함수들////////////////////////////////////
//////////////////////////////////////////////////////////////////////
//리스트 가져오기 --> 그리기
function getListAndRender(){
	axios({
		method: 'get', // put, post, delete
		url: '${pageContext.request.contextPath}/api/board/comments',   //(데이터만 오는 친구들은 api를 붙일거임)
		headers: {"Content-Type" : "application/json; charset=utf-8"}, //전송타입
		//params: boardVo, //get방식 파라미터로 값이 전달
		//data: boardVo, //put, post, delete 방식 자동으로 JSON으로 변환 전달
		responseType: 'json' //수신타입
	})

	.then(function (response) {
		console.log(response.data); //수신데이타
		
		//리스트자리에 
		//글을 하나씩 추가한다
		for(let i=0; i<response.data.length; i++){
			let boardVo = response.data[i];
			render(boardVo, "up"); //1개의 글을 render()에게 전달 --> render() 리스트위치에 그린다
		}
	})
	.catch(function (error) {
		console.log(error);
	});
}

function render(boardVo, dir){
	console.log("render()");
	console.log(boardVo);
	
	let boardListArea = document.querySelector("#boardListArea");
	console.log(boardListArea);	
	
	let str = '';
	str += '		<tr>';
	str += '			<td>'+boardVo.no+'</td>';
	str += '			<td class="text-left">'+boardVo.title+'</a></td>';
	str += '			<td>'+boardVo.name+'</td>';
	str += '			<td>'+boardVo.hit+'</td>';
	str += '			<td>'+boardVo.regDate+'</td>';
	str += '			<td><a href="${pageContext.request.contextPath}/board/commentdelete?no=${commentVo.no}&userNo=${sessionScope.authUser.no}">[삭제]</a></td>';
	str += '		</tr>';
	

	if(dir == "down"){
		boardListArea.insertAdjacentHTML("beforeend", str);
	} else if(dir == "up"){
		boardListArea.insertAdjacentHTML("afterbegin", str);
	}
}

function readPage(){
	axios({
		method: 'get', // put, post, delete
		url: '${pageContext.request.contextPath}/api/board/comments/'+no,   //(데이터만 오는 친구들은 api를 붙일거임)
		headers: {"Content-Type" : "application/json; charset=utf-8"}, //전송타입
		params: boardVo, //get방식 파라미터로 값이 전달
		//data: boardVo, //put, post, delete 방식 자동으로 JSON으로 변환 전달
		responseType: 'json' //수신타입
	})

	.then(function (response) {
		console.log(response.data); //수신데이타
		
		
	})
	.catch(function (error) {
		console.log(error);
	});
}

function clickAndGo(){
	axios({
		method: 'get', // put, post, delete
		url: '${pageContext.request.contextPath}/api/board/comments/'+no,   //(데이터만 오는 친구들은 api를 붙일거임)
		headers: {"Content-Type" : "application/json; charset=utf-8"}, //전송타입
		params: boardVo, //get방식 파라미터로 값이 전달
		//data: boardVo, //put, post, delete 방식 자동으로 JSON으로 변환 전달
		responseType: 'json' //수신타입
	})

	.then(function (response) {
		console.log(response.data); //수신데이타
		
		//리스트자리에 
		//글을 하나씩 추가한다
		for(let i=0; i<response.data.length; i++){
			let boardVo = response.data[i];
			render(boardVo, "up"); //1개의 글을 render()에게 전달 --> render() 리스트위치에 그린다
		}
	})
	.catch(function (error) {
		console.log(error);
	});
}

</script>

</html>
