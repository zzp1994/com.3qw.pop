<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<link rel="stylesheet" type="text/css" href="${path}/css/reset.css">
    <div class="blank10"></div>
	<div class="shang">
	
		<c:if test="${page.totalPage > 1}">
		     <c:if test="${page.page == 1}">
		      	 <button class="y"type="button"  ><img src="${path}/images/x6.png">previous</button>
		     </c:if>
			 <c:if test="${page.page> 1}">
				 <a href="#"><button type="button"  class="y" onclick="GoPage(${page.page-1});" ><img src="${path}/images/x5.png"> previous</button></a>
		     </c:if>
			 <c:if test="${page.totalPage<=8}">
			  	 <c:forEach var="v" begin="1" end="${page.totalPage}" step="1">
			  	    <c:if test="${page.page==v}">
			  	       <button type="button"   class="curr">${v}</button>
			  	    </c:if>
			  	     <c:if test="${page.page!=v}">
			  	        <a href="#"><button type="button"  onclick="GoPage(${v})" >${v}</button></a>
			  	    </c:if>
				 </c:forEach>
			</c:if>
		    <c:if test="${page.totalPage>8&&page.page<8}">
			  	 <c:forEach var="v" begin="1" end="7" step="1">
			  	    <c:if test="${page.page==v}">
			  	       <button type="button"  class="curr">${v}</button>
			  	    </c:if>
			  	     <c:if test="${page.page!=v}">
			  	        <a href="#"><button type="button"  onclick="GoPage(${v})">${v}</button></a>
			  	    </c:if>
				 </c:forEach>
				  ...
				  <a href="#"><button type="button"  onclick="GoPage(${page.totalPage})" >${page.totalPage}</button></a>
			</c:if>
			<c:if test="${page.totalPage>8&&page.page>8}">
				  <a href="#"><button type="button"   onclick="GoPage(1)" }>1</button></a>
				  ...
			  	 <c:forEach var="v" begin="${page.totalPage-7}" end="${page.totalPage}" step="1">
			  	    <c:if test="${page.page==v}">
			  	       <button type="button"  class="curr">${v}</button>
			  	    </c:if>
			  	     <c:if test="${page.page!=v}">
			  	        <a href="#"><button type="button"  onclick="GoPage(${v})" >${v}</button></a>
			  	    </c:if>
			  	 </c:forEach>
			</c:if>
			
			 <c:if test="${page.page == page.totalPage}">
		      	 <button type="button"  class="y1"> next<img src="${path}/images/x8.png"></button>
		     </c:if>
			 <c:if test="${page.page< page.totalPage}">
				 <a href="#"><button type="button" class="y1" onclick="GoPage(${page.page+1})"  > next<img src="${path}/images/x9.png"></button></a>
		     </c:if>
		  </c:if>
		   <c:if test="${page.totalPage>1}">
		      <input type="text" class="go" id="go" placeholder="Page Num">
		  	  <button type="button" class="go_button" onclick="javascript: var pagenum=document.getElementById('go').value; GoPage(pagenum)">GO</button>
	     </c:if>
		 
	</div>
	<div class="blank10"></div>
<script type="text/javascript">
	var jQFrm  = null;
	var timestamp = new Date().getTime()+"";
	
	$(document).ready(function(){
		jQFrm = $("#SearchFrom"); 
		if(jQFrm.length!=1){
			alert("error");
			return; }
		jQFrm.append("<input id='currpage_"+timestamp+"' type='hidden' name='page' value='${page.page}'/>");
		jQFrm.append("<input id='pernum_"+timestamp+"' type='hidden'   name='pageSize' value='${page.pageSize}'/>");
	});
	function GoPage(page){
		if(page==undefined || page == null){
			return;
		}
		if(!isNumber(page)){
			return;
		}
		$("#currpage_"+timestamp).val(page);
		jQFrm.submit();
	}
	/**
	 * 判断是否是数字
	 */
	function isNumber(value){
		if(isNaN(value)){
			return false;
		}
		else{
			return true;
		}
	}
</script>