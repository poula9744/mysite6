<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="${pageContext.request.contextPath}/assets/css/mysite.css"
	rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/assets/css/guestbook.css"
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

		<!-- header -->
		<c:import url="/WEB-INF/views/include/header.jsp"></c:import>
		<!-- /header -->

		<div id="container" class="clearfix">
			<div id="aside">
				<h2>방명록</h2>
				<ul>
					<li>일반방명록</li>
					<li>ajax방명록</li>
				</ul>
			</div>
			<!-- //aside -->

			<div id="content">

				<div id="content-head" class="clearfix">
					<h3>ajax방명록</h3>
					<div id="location">
						<ul>
							<li>홈</li>
							<li>방명록</li>
							<li class="last">ajax방명록</li>
						</ul>
					</div>
				</div>
				<!-- //content-head -->

				<div id="guestbook">
					<form id="guestForm" action="${pageContext.request.contextPath}/guestbook/insert" method="get">
						<table id="guestAdd">
							<colgroup>
								<col style="width: 70px;">
								<col>
								<col style="width: 70px;">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th>
										<label class="form-text" for="input-uname">이름</label>
									</th>
									<td>
										<input id="input-uname" type="text" name="name" value="">
									</td>
									<th>
										<label class="form-text" for="input-pass">패스워드</label>
									</th>
									<td>
										<input id="input-pass" type="password" name="password" value="">
									</td>
								</tr>
								<tr>
									<td colspan="4">
										<textarea name="content" cols="72" rows="5"></textarea>
									</td>
								</tr>
								<tr class="button-area">
									<td colspan="4" class="text-center">
										<button id="btnAdd" type="submit">등록</button>
									</td>
								</tr>
							</tbody>
						</table>
						<!-- //guestWrite -->
					</form>
					
					<!-- 모달 창 컨텐츠 -->
              		<div id="myModal" class="modal">
                  		<div id="guestbook" class="modal-content">
                    		 <div class="closeBtn">×</div>
                    			 <div class="m-header">
                        			패스워드를 입력하세요
                    		 </div>
                    		 <div class="m-body">
                       			 <input type="password" class="m-password" name="password" value=""><br>
                        		<input type="text" class="m-no"  name="no" value="">
                   			 </div>
                     		<div class="m-footer">
                       			 <button class="btnDelete" type="submit">삭제</button>
                     		</div>
                 	 	</div>
              		 </div>
					
					
					<div id="guestbookListArea">
						<!-- 방명록 글 리스트 -->
						
					</div>

				</div>
				<!-- //guestbook -->

			</div>
			<!-- //content  -->
		</div>
		<!-- //container  -->

		<!-- footer -->
		<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
		<!-- //footer -->
	</div>
	<!-- //wrap -->

</body>

<script>

//DOM tree가 생성되었을 때
document.addEventListener("DOMContentLoaded", function(){
	
	//리스트요청 데이터만 요청
	getListAndRender();
	
	//등록버튼 클릭했을 때 (데이터만 받을거야)/////////////////////////////
	let btnAdd = document.querySelector("#guestForm");
	btnAdd.addEventListener("submit", addAndRender);
	
	
	//모달창 호출 버튼을 클릭했을때
	let guestbookListArea = document.querySelector("#guestbookListArea");
	guestbookListArea.addEventListener("click", callModal);
	
	
	//모달창 닫기 버튼(X) 클릭했을 때
	let closeBtn = document.querySelector(".closeBtn");
	closeBtn.addEventListener("click", closeModal);
		

	//모달창 삭제버튼을 클릭했을때(진짜 삭제)
	let btnDelete = document.querySelector(".btnDelete");
	btnDelete.addEventListener("click", deleteAndRemove);
	
	
	
}); //document.addEventListener

//////////////////////////////////////////////////////////////////////
///////////////////////////함수들////////////////////////////////////
//////////////////////////////////////////////////////////////////////
//리스트 가져오기 --> 그리기
function getListAndRender(){
	axios({
		method: 'get', // put, post, delete
		url: '/mysite6/api/guestbooks',   //(데이터만 오는 친구들은 api를 붙일거임)
		headers: {"Content-Type" : "application/json; charset=utf-8"}, //전송타입
		//params: guestbookVo, //get방식 파라미터로 값이 전달
		//data: guestbookVo, //put, post, delete 방식 자동으로 JSON으로 변환 전달
		responseType: 'json' //수신타입
	})

	.then(function (response) {
		//console.log(response.data); //수신데이타
		
		//리스트자리에 
		//글을 하나씩 추가한다
		for(let i=0; i<response.data.length; i++){
			let guestVo = response.data[i];
			render(guestVo, "up"); //1개의 글을 render()에게 전달 --> render() 리스트위치에 그린다
		}
		
		
	})

	.catch(function (error) {
		console.log(error);
	});
	
}

//글 저장 --> 그리기
function addAndRender(event){
	//console.log("글쓰기버튼 클릭");
	event.preventDefault();
	
	//폼에 있는 데이터 가져오기
	let name = document.querySelector("[name = 'name']").value;
	
	let password = document.querySelector("[name = 'password']").value;
	
	let content = document.querySelector("[name = 'content']").value;
	
	let guestVo = {
			name: name,
			password: password,
			content: content
	}
	
	
	//console.log(guestVo);
	//서버로 데이터 전송
	axios({
		method: 'post', // put, post, delete
		url: '/mysite6/api/guestbooks',
		headers: {"Content-Type" : "application/json; charset=utf-8"}, //전송타입
		//params: guestVo, //get방식 파라미터로 값이 전달
		data: guestVo, //put, post, delete 방식 자동으로 JSON으로 변환 전달
		responseType: 'json' //수신타입
		})
	.then(function (response) {
		//console.log(response);  //수신데이타

		//그리기
		render(response.data, "up");
		
		//비우기
		document.querySelector("[name = 'name']").value="";
		document.querySelector("[name = 'password']").value="";
		document.querySelector("[name = 'content']").value="";
		
	})
	.catch(function (error) {
		console.log(error);
	}); 
}

//삭제 --> 없애기
function deleteAndRemove(){
	//데이터 모으고
	let no = document.querySelector(".m-no").value;
	let password = document.querySelector(".m-password").value;
	
	let guestVo = {
			password: password
	}
	
	console.log(guestVo);

	// /api/guestbooks/delete   method: post
	//서버로 데이터 전송
	axios({
		method: 'delete', // put, post, delete
		url: '/mysite6/api/guestbooks/'+no,
		headers: {"Content-Type" : "application/json; charset=utf-8"}, //전송타입
		params: guestVo, //get방식 파라미터로 값이 전달
		//data: guestbookVo, //put, post, delete 방식 자동으로 JSON으로 변환 전달
		responseType: 'json' //수신타입
		})
	.then(function (response) {
		//console.log(response.data);  //수신데이타
		
		//비우기
		if(response.data==1){
			//찾아서 삭제
			let tagId = "#t-"+no;   //id에 숫자만 들어가면 안됨
			let removeTable  = document.querySelector(tagId);
			//console.log(tagId);
			//console.log(removeTable);
			
			removeTable.remove();
		}
		
	})
	.catch(function (error) {
		console.log(error);
	}); 
}

//방명록 글 그리기
function render(guestbookVo, dir){
	console.log("render()");
	console.log(guestbookVo);
	
	let guestbookListArea = document.querySelector("#guestbookListArea");
	console.log(guestbookListArea);	

	
	
	let str = '';
	str += '<table id="t-'+ guestbookVo.no +'" class="guestRead">';
	str += '	<colgroup>';
	str += '		<col style="width: 10%;">';
	str += '		<col style="width: 40%;">';
	str += '		<col style="width: 40%;">';
	str += '		<col style="width: 10%;">';
	str += '	</colgroup>';
	str += '	<tr>';
	str += '		<td>'+guestbookVo.no+'</td>';
	str += '		<td>'+guestbookVo.name+'</td>';
	str += '		<td>'+guestbookVo.regDate+'</td>';
	str += '		<td><button class="btnModal" type="button" data-no="'+ guestbookVo.no +'">[삭제]</button></td>';
	str += '	</tr>';
	str += '	<tr>';
	str += '		<td colspan=4 class="text-left">'+guestbookVo.content+'</td>';
	str += '	</tr>';
	str += '</table>';
	
	if(dir == "down"){
		guestbookListArea.insertAdjacentHTML("beforeend", str);
	} else if(dir == "up"){
		guestbookListArea.insertAdjacentHTML("afterbegin", str);
	}

}//render

function callModal(){
	if(event.target.tagName == "BUTTON"){
		//console.log("모달창 보이기");	
		let modal = document.querySelector(".modal");
		modal.style.display = "block";
		
		
		//hidden의 value --> no값 입력
		let noTag = document.querySelector('[name="no"]');
		noTag.value = event.target.dataset.no;
		//console.log(event.target.dataset.no);
		
		//패스워드창 비우기
		let tag = document.querySelector(".m-password");
		console.log(tag);
		tag.value = "";
	}
}

function closeModal(){
	console.log("클릭");
	let modal = document.querySelector("#myModal");
	modal.style.display = "none";
}

</script>

</html>