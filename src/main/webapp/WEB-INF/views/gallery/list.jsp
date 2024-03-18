<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="${pageContext.request.contextPath }/assets/css/mysite.css"
	rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/assets/css/gallery.css"
	rel="stylesheet" type="text/css">


<!-- Axios 라이브러리 포함(원래는 아래에 씀) -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<style>
/*모달창 배경 회색부분*/
	.modal{
		width: 100%; /*가로 전체*/
		height: 100%; /*세로 전체*/
		display: none; /*시작할 때 숨김처리*/
		position: fixed; /*화면에 고정*/
		left: 0; /*왼쪽 0에서 시작*/
		top: 0; /*위쪽 0에서 시작*/
		z-index: 999; /*제일 위에*/
		overflow: auto; /*내용이 많으면 스크롤 생김*/
		background-color: rgba(0, 0, 0, 0.4); /*배경이 검정색에 반투명*/
		
	}
	/*모달창 내용 흰색부분*/
	.modal .modal-content{
		width: 400px;
		margin: 100px auto; /*상하 100px, 좌우 가운데*/
		padding: 0px 20px 20px 20px; /*안쪽 여백*/
		background-color: #ffffff; /*배경색 흰색*/
		border: 1px solid #888888; /*테두리 모양 색*/
	}
	/*닫기 버튼*/
	.modal .modal-content .closeBtn{
		text-align: right;
		color: #aaaaaa;
		font-size: 28px;
		font-weight: bold;
		cursor: pointer;
	}
</style>
</head>


<body>
	<div id="wrap">

		<c:import url="/WEB-INF/views/include/header.jsp"></c:import>
		<!-- //header -->

		<div id="container" class="clearfix">
			<div id="aside">
				<h2>갤러리</h2>
				<ul>
					<li><a href="">일반갤러리</a></li>
					<li><a href="">파일첨부연습</a></li>
				</ul>
			</div>
			<!-- //aside -->
			<div id="content">

				<div id="content-head">
					<h3>갤러리</h3>
					<div id="location">
						<ul>
							<li>홈</li>
							<li>갤러리</li>
							<li class="last">갤러리</li>
						</ul>
					</div>
					<div class="clear"></div>
				</div>
				<!-- //content-head -->


				<div id="gallery">
					<div id="list">


						<button id="btnImgUpload">이미지올리기</button>
						<div class="clear"></div>


						<ul id="viewArea">

							<!-- 이미지반복영역 -->
							<c:forEach items="${requestScope.galleryList}" var="galleryVo">
							<li>
								<div class="view">
									<input type="hidden" id="no" value="${galleryVo.no }">
									<img class="imgItem" src="${pageContext.request.contextPath}/upload/${galleryVo.saveName}"">
									<div class="imgWriter">
										작성자: <strong>${galleryVo.name}</strong>
									</div>
								</div>
							</li>
							</c:forEach>
							<!-- 이미지반복영역 -->


						</ul>
					</div>
					<!-- //list -->
				</div>
				<!-- //board -->
			</div>
			<!-- //content  -->
		</div>
		<!-- //container  -->


		<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
		<!-- //footer -->

	</div>
	<!-- //wrap -->

	<!-- 이미지등록 팝업(모달)창 -->
	<div id="addModal" class="modal">
		<div class="modal-content">
			<form action="${pageContext.request.contextPath}/gallery/upload" method="post" enctype="multipart/form-data">
				<div class="closeBtn">×</div>
				<div class="m-header">이미지 등록</div>
				<div class="m-body">
					<input id="addModalContent" type="hidden" name="userNo" value="">
					<div>
						<label class="form-text">글작성</label> 
						<input id="addModalContent" type="text" name="addContent" value="">
					</div>
					<div class="form-group">
						<label class="form-text">이미지선택</label> 
						<input id="file" type="file" name="addImg" value="">
					</div>
				</div>
				<div class="m-footer">
					<button type="submit" id="save">저장</button>
				</div>
			</form>
		</div>
	</div>


	<!-- 이미지보기 팝업(모달)창 -->
	<div id="viewModal" class="modal">
		<div class="modal-content">
			<div class="closeBtn">×</div>
			<div class="m-header">이미지보기</div>
			<div class="m-body">
				<div>
					<img id="viewModelImg" src="${pageContext.request.contextPath}/upload/${galleryVo.saveName}">
					<!-- ajax로 처리 : 이미지출력 위치-->
				</div>
				<div>
					<p id="viewModelContent"></p>
				</div>
			</div>
			<div class="m-footer">
				<button>삭제</button>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function(){
	
	//파일 선택 후 저장버튼을 클릭했을 때
	let btnAdd = document.querySelector("#save");
	btnAdd.addEventListener("click", addAndRender);
	
	//모달창 호출 버튼을 클릭했을 때
	let btnImgUpload = document.querySelector("#btnImgUpload");
	btnImgUpload.addEventListener("click", callModal);
	
	//모달창 닫기 버튼(X) 클릭했을 때
	let closeBtn = document.querySelector(".closeBtn");
	closeBtn.addEventListener("click", closeModal);
	
});


//함수

//content, img 저장 
function addAndRender(event){
	console.log("저장버튼 클릭");
	
	//event.preventDefault();
	
	//폼에 있는 데이터 가져오기
	let userNo = document.querySelector("[name='userNo']").value;
	let content = document.querySelector("[name='addContent']").value;
	let img = document.querySelector("[name='addImg']").value; 
	
	let galleryVo = {
			userNo: userNo,
			content: content,
			img: img
	}
	
	//서버로 데이터 전송
	axios({
		method: 'post', // put, post, delete
		url: '${pageContext.request.contextPath}/api/gallery',
		headers: {"Content-Type" : "application/json; charset=utf-8"}, //전송타입
		//params: galleryVo, //get방식 파라미터로 값이 전달
		data: galleryVo, //put, post, delete 방식 자동으로 JSON으로 변환 전달
		responseType: 'json' //수신타입
		})
	.then(function (response) {
		//console.log(response);  //수신데이타

		//그리기
		render(response.data, "up");
		
		//비우기
		document.querySelector("[name = 'userNo']").value="";
		document.querySelector("[name = 'password']").value="";
		document.querySelector("[name = 'content']").value="";
		
	})
	.catch(function (error) {
		console.log(error);
	}); 
	
}


//모달창 부르기: 이미지 등록 누르면 창 열림
function callModal(){
	if(event.target.tagName == "BUTTON"){
		//console.log("모달창 보이기");	
		let modal = document.querySelector(".modal");
		modal.style.display = "block";
	}
	
}
//모달창 닫기 버튼(X) 클릭했을 때
function closeModal(){
	console.log("클릭");
	let modal = document.querySelector(".modal");
	modal.style.display = "none";
}

	
	
</script>




</html>



