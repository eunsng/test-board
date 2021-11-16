<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 목록</title>
	<link rel="stylesheet" href = "/css/admin_main.css">
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
</head>

<script>
	
	$(function(){
		
		$("#allchk").click(function(){
			//prop는 체크가 되었는지 확인
			//allchk가 체크되었나 -> true -> 나머지 올 체크
			if( $("#allchk").prop("checked") == true ){
				
				//name 값을 사용   다중값은 id 못받음
				$("input[name='chk']" ).prop("checked",true);
			}else{
				$("input[name='chk']" ).prop("checked",false);
			}
		});
		
		
		$("#btn_all_delete").click(function(){
			
			var len = $("input[name='chk']").length;

			//통합해주는 변수
			var values = "";	
		
			for(var i=0; i<len; i++){
				var chk = document.getElementsByName('chk')[i].checked;
				if (chk == true ){
					values += document.getElementsByName('chk')[i].value;
					values += ",";
				}
			}
	
			// 하나라도 체크되어있으면 삭제처리
			if(values.length > 0) {
				if(confirm("일괄삭제 하시겠습니까?")){
					$.ajax({
						type : "post",
						url	 : "admin_nboardAllDelete.do",
						data : "values="+values,
						
						datatype : "text",
						success  : function(data){
							if(data == "ok"){
								alert("일괄 삭제 완료");
								document.location.reload();
							}else{
								alert("삭제 실패");
							}
						},
						error    : function(){
							alert("오류")	;			
						}			
					});
				}
			}
			
			
		});
		
	});
	
	function fn_delete(unq) {
		
		if( confirm("정말 삭제하시겠습니까") ){
			$.ajax({
				type : "post",
				url	 : "admin_nboardDelete.do",
				data : "unq="+unq,
				
				datatype : "text",
				success  : function(data){
					if(data == "ok"){
						alert("삭제 완료");
						document.location.reload();
					}else{
						alert("삭제실패");
					}
				},
				error    : function(){
					alert("오류")	;			
				}			
			});
		}
	}

</script>


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
			<span style ="font-size :20px; font-family:'맑은 고딕'; font-weight:bold; ">
			공지사항 목록
			</span>
		</div>
		
		<div style="position:relative; width:800px; left:20px; top:30px; margin-bottom:10px;">
			
			<div style ="position:relative; float:left; ">
				<span style ="font-size:12px;">총 출력 개수 : ${total}</span>
			</div>
			
			<form name ="frm" method ="post" action="admin_nboardList.do">
			<div style ="position:relative; margin-bottom:10px; text-align:right;">
				<select name ="s_field">
					<option value ="title"   <c:if test ="${s_field == 'title'}">selected</c:if> >제목</option>
					<option value ="content" <c:if test ="${s_field == 'content'}">selected</c:if> >내용</option>
					<option value ="rdate"   <c:if test ="${s_field == 'rdate'}">selected</c:if> >등록일</option>
				</select>
				<input type ="text" name ="s_text" style ="width:120px;" value ="${s_text}">
				<button type ="submit" id = "btn_search"> 검색 </button>
				(날짜검색 예시: 2021-12-25 또는 2021-10)
			</div>
			</form>
		
		</div>

		<div style="position:relative; left:20px; top:30px;">
	
			<table style ="width:800px;">
				<colgroup>
					<col width="5%"/>
					<col width="10%"/>
					<col width="*"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
				</colgroup>
				<tr>
					<th><input type ="checkbox" name ="allchk" id ="allchk"></th>
					<th>번호</th>
					<th>제목</th>
					<th>이름</th>
					<th>등록일</th>
					<th>변경일</th>
					<th>조회수</th>
					<th>삭제</th>
				</tr>
				
				<c:forEach var ="result" items = "${list}">
				
				<tr align="center">
					<td><input type ="checkbox" value ="${result.unq}" name ="chk" id ="chk"></td>
					<td>${rownum}</td>
					<td align="left">
					<a href="admin_nboardModify.do?unq=${result.unq}&s_field=${s_field}&s_text=${s_text}"> ${result.title}</a>
					</td>
					<td>${result.name}</td>
					<td>${result.rdate}</td>
					<td>${result.udate}</td>
					<td>${result.hits}</td>
					<td><a href ="javascript:fn_delete('${result.unq}')">삭제</a></td>
				</tr>
					<c:set var ="rownum" value ="${rownum-1}" />
				</c:forEach>
			</table>
			<div style ="width: 800px; text-align:left; margin-top:10px;">
				<button type ="button" id ="btn_all_delete" >일괄 삭제</button>
			</div>
			
			
			<div style ="width: 800px; text-align:center; margin-top:10px;">
				
				<c:forEach var = "i" begin="1" end="${total_page }">
					<a href ="admin_nboardList.do?page_no=${i}&s_field=${s_field}&s_text=${s_text}" > ${i} </a>
				</c:forEach>
				
			</div>
			
			
		</div>
	</div>
</div>
</body>
</html>











