<%@page import="com.model2.mvc.common.Page"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>
<head>
<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<script type="text/javascript">
function fncGetList(currentPage) {
	document.getElementById('currentPage').value=currentPage;
	document.detailForm.submit();
}
function fncFindProductList(){
	document.detailForm.submit();
}
function fncSortingList(orderType){
	document.getElementById('orderType').value=orderType;
	document.detailForm.submit();
}
function fncSortingByUser(pageSize){
	document.getElementById('pageSize').value=pageSize;
	document.detailForm.submit();
}

$(function(){
	$("td:contains('할인상품보기')").on('click',function(){
		var href = "/product/getProduct?boardNo=${discount.discountBoard}";
		if(${param.menu=="search"}){
			href = href + "&menu=search";
		}
		else if(${param.menu=="manage"}){
			href = href + "&menu=manage";
		}
		self.location = href;
	});
});

 $(function(){
	$("td:contains('${productBoard.title}')").on('click',function(){
		var href = "/product/getProduct?boardNo="+$("#prodTrTd").val().trim()
		if(${param.menu=='search'}){
			href = href + "&menu=search";
		}
		else if(${param.menu=='manage'}){
			href = href + "&menu=manage";
		}
		self.location = href;
		
	});
}); 


</script>
</head>

<body bgcolor="#ffffff" text="#000000">


<div style="width:98%; margin-left:10px;">

<form name="detailForm" >

<input type="hidden" id="HddnDiscountBoardNo" name="HddnDiscountBoardNo" value="${discount.discountBoard}"/>

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
						<c:if test="${param.menu=='search'}">
							상품 목록조회 ${discount.discountBoard}
						</c:if>
						<c:if test="${param.menu=='manage'}">
							상품 관리
						</c:if>
									
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<input type='hidden' id="orderType" name='orderType' value="${search.orderType}"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td>
			<%-- <a href="/product/getProduct?boardNo=
				${discount.discountBoard}
				&menu=
				<c:if test="${param.menu=='search'}">
				search
				</c:if>
				<c:if test="${param.menu=='manage'}">
				manage
				</c:if>">할인상품보기</a> --%>
				할인상품보기
		</td>
		<td align="right">
		<select name="pageSize">
			<option value="${resultPage.pageSize}" >선택</option>
			<c:forEach var="i" begin="1" end="10">
			<option value="${i}" ${i==resultPage.pageSize ? "selected":""}>${i}</option>
			</c:forEach>
		</select>개씩 보기&nbsp;&nbsp;&nbsp;
		<a href="javascript:fncSortingList('1')" id="orderLast" name="orderLast" >최근등록순</a>
		<a href="javascript:fncSortingList('2')" id="orderHigh" name="orderHigh" >가격높은순</a>
		<a href="javascript:fncSortingList('3')" id="orderLow" name="orderLow">가격낮은순</a>
			<select id="searchCondition" name="searchCondition" class="ct_input_g" style="width:80px">
				
				<c:if test="${!empty search.searchCondition}">
				<c:choose>
					<c:when test="${sessionScope.user.userId == 'admin'}">					
					<option value="0" ${!empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>글번호</option>
					</c:when>					
				</c:choose>
					<option value="1" ${!empty search.searchCondition && search.searchCondition==1 ? "selected":""}>글제목</option>
					<option value="2" ${!empty search.searchCondition && search.searchCondition==2 ? "selected":""}>글내용</option>
				</c:if>
			
				<c:if test="${empty search.searchCondition}">
				<c:choose>
					<c:when test="${sessionScope.user.userId == 'admin' }">
					<option value="" >--선택--</option>
					</c:when>
				</c:choose>
					<option value="0" >글번호</option>
					<option value="1" >글제목</option>
					<option value="2" >글내용</option>
				</c:if>
			</select>
			<input type="text" id="searchKeyword" name="searchKeyword"  class="ct_input_g" style="width:200px; height:19px" 
				value="${!empty search.searchKeyword ? search.searchKeyword:''}"
			/>
		</td>
	
		
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="javascript:fncFindProductList();">검색</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지</td>		
	</tr>
	<tr>
		<td class="ct_list_b" width="100">글번호</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">제목</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">등록일</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">현재상태</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:set var="i" value="0"/>
	<c:forEach var="productBoard" items="${list}" >
	<c:set var="i" value="${i+1}"/>
	<tr class="ct_list_pop" id="prodTr">
		<td align="center" id="prodTrTd" >${productBoard.boardNo}</td>
		<td></td>
				<%-- <td align="left">
				<a href="/product/getProduct?boardNo=
				${productBoard.boardNo}
				&menu=
				<c:if test="${param.menu=='search'}">
				search
				</c:if>
				<c:if test="${param.menu=='manage'}">
				manage
				</c:if>">
				${productBoard.title}</a></td> --%>
				<td>${productBoard.title}</td>
		<td></td>
		<td align="left">${productBoard.prodPrice}
			<c:if test="${productBoard.boardNo == discount.discountBoard}">
			<img src="https://static1.squarespace.com/static/513f57ebe4b0970eaf232dec/t/5654b2eae4b05e28e38285cd/1448391403995/" 
											style="height:20px;width:20px;">
			</c:if>
		</td>
		<td></td>
		<td align="left">${productBoard.boardRegDate}</td>
		<td></td>
		<td align="left">
			${productBoard.quantity > 0 ? '판매중':'재고없음'}		
		</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>	
	</c:forEach>
	
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		<input type="hidden" id="menu" name="menu" value="${param.menu}"/>
		<input type="hidden" id="currentPage" name="currentPage" value="${search.currentPage}"/>
			<jsp:include page="../common/pageNavigator.jsp"/>
    	</td>
	</tr>
</table>
<!--  페이지 Navigator 끝 -->

</form>

</div>
</body>
</html>
