<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="http://code.jquery.com/jquery-2.1.4.min.js">
	

</script>


<c:if test="${ resultPage.currentPage > 1 }">
		<%-- <a href="javascript:fncGetUserList('${ resultPage.currentPage-1}')">◀ 이전</a> --%>
		<button type="button" id="prePageBtn">◀ 이전</button>
</c:if>

<c:forEach var="i"  begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">
	<%-- <a href="javascript:fncGetUserList('${ i }');">${ i }</a> --%>
	<button type="button" class="pageNumb">${i}</button>
</c:forEach>

<%-- <c:if test="${ resultPage.endUnitPage >= resultPage.maxPage }">
		이후 ▶
</c:if> --%>
<c:if test="${ resultPage.endUnitPage < resultPage.maxPage }">
		<%-- <a href="javascript:fncGetUserList('${resultPage.endUnitPage+1}')">이후 ▶</a> --%>
		<button type="button" id="postPageBtn">이후 ▶</button>
</c:if>


<script>
$(function(){
	$('.pageNumb').on('click',function(){
		var page = $(this).html();
		$('#currentPage').val(page);
		$('.listForm').attr("method","post");
		if($('.pageTitle').html() == "상품 목록조회"){
			$('.listForm').attr("action","/product/listProduct").submit();
		}else if($('.pageTitle').html() == "구매 목록조회" ){
			$('.listForm').attr("action","/purchase/listPurchase").submit();
		}else if($('.pageTitle').html() == "회원 목록 조회"){
			$('.listForm').attr("action","/user/listUser").submit();
		}
	});
	
	$('#prePageBtn').on('click',function(){
		var page = ${resultPage.currentPage}-1;
		$('#currentPage').val(page);
		$('.listForm').attr("method","post");
		if($('.pageTitle').html() == "상품 목록조회"){
			$('.listForm').attr("action","/product/listProduct").submit();
		}else if($('.pageTitle').html() == "구매 목록조회" ){
			$('.listForm').attr("action","/purchase/listPurchase").submit();
		}else if($('.pageTitle').html() == "회원 목록 조회"){
			$('.listForm').attr("action","/user/listUser").submit();
		}
	});
	
	$('#postPageBtn').on('click',function(){
		var page = ${resultPage.endUnitPage+1};
		$('#currentPage').val(page);
		$('.listForm').attr("method","post");
		if($('.pageTitle').html() == "상품 목록조회"){
			$('.listForm').attr("action","/product/listProduct").submit();
		}else if($('.pageTitle').html() == "구매 목록조회" ){
			$('.listForm').attr("action","/purchase/listPurchase").submit();
		}else if($('.pageTitle').html() == "회원 목록 조회"){
			$('.listForm').attr("action","/user/listUser").submit();
		}
	});
	
	$('.ct_list_pop:nth-child(4n+6)').css('background-color','whitesmoke');
});
</script>