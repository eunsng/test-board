<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>공지사항 등록</title>
	
	<link rel="stylesheet" href = "/css/admin_main.css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
  	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  	<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
  	
	<script>
	  $( function() {
		
	  		$("#btn_before").click(function(){
	  			if("${before}" != "") {
	  				location = "admin_nboardModify.do?unq=${before}&s_field=${s_field}&s_text=${s_text}";
	  			} else {
	  				alert("마지막입니다.");
	  			}
	  		}); 
	  		
	 		$("#btn_next").click(function(){
	  			if("${next}" != "") {
	  				location = "admin_nboardModify.do?unq=${next}&s_field=${s_field}&s_text=${s_text}";
	  			} else {
	  				alert("마지막입니다.");
	  			}
	  		});
		  
		  
		  
		  $("#btn_save").click(function(){
			  
			  if( $.trim( $("#title").val() ) == "" ){
				  alert("제목을 입력해주세요.");
				  $("#title").focus();
				  return false;
			  }
			  
			  if( $.trim( $("#content").val() ) == "" ){
				  alert("내용을 입력해주세요.");
				  $("#content").focus();
				  return false;
			  }
			  
			  
			  var formdata = $("#frm").serialize();
			  $.ajax({
				  type : "POST",
				  url  : "admin_nboardModifySave.do",
				  data : formdata,
				  
				  datatype : "text",
				  success  : function(data){
					   if(data == "ok"){
						   alert("변경 완료");
						   location="admin_nboardList.do";
					   }else{
						   alert("실패");
					   }
				  } ,
					  
				  error    : function(){
					  alert("오류발생");
				  			}  
			  });
		  });
	  });
	</script>
</head>

<body>

<div class="div1">

	<div class="div_top">
		<h2>관리자모드</h2>
	</div>
	
	<div class="div2">
		<%@ include file="../include/left_menu.jsp" %>
	</div>
	
	<div class="div3">
	
		<div style="position:relative; left:20px; top:30px; margin-bottom:10px;">
		</div>

		<div style="position:relative; left:20px; top:30px; margin-bottom:5px;">
			<span style ="font-size :20px; font-family:'맑은 고딕'; font-weight:bold; ">공지사항 수정</span>
		</div>

		<div style="position:relative; left:20px; top:30px;">
	
<form id ="frm">
		<input type ="hidden" name ="unq" value ="${vo.unq}">
	<table style ="width:600px;">
		<tr>
			<th>제목</th>
			<td>
			<input type ="text" name ="title" id ="title" value ="${vo.title}">
			</td>
		</tr>
		<tr>
			<th>이름</th>
			<td>
			<input type ="text" name ="name" id ="name" value ="관리자" value ="${vo.name}" >
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
			<textarea name ="content" id="content" 
			style ="width:98%; height:150px;" >${vo.content}</textarea>
			</td>
		</tr>
		
		<tr>
			<th>등록일</th>
			<td> ${vo.rdate}</td>
		</tr>
		<tr>
			<th>최종 변경일</th>
			<td> ${vo.udate}</td>
		</tr>
		<tr>
			<th>조회수</th>
			<td> ${vo.hits}</td>
		</tr>
		
		
		
	</table>
	
	<div style ="width:600px; text-align:center; margin-top:10px;">
		
		<button type ="button" id="btn_before">이전</button>
		&nbsp;
		<button type ="button" id="btn_save">저장</button>
		<button type ="button" onclick ="location='admin_nboardList.do'">취소</button>
		&nbsp;
		<button type ="button" id="btn_next">다음</button>
	</div>
	
</form>	
		</div>
	</div>
</div>
</body>
</html>
