<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	  <title>Supplier-Brand</title>
      <%@include file="/WEB-INF/views/en/include/base.jsp"%>
	  <link rel="stylesheet" type="text/css" href="${path}/css/en/user.css">
      <link rel="stylesheet" type="text/css" href="${path}/css/en/juese.css">
	</head>
	<body>
		<div id="editDiv" class="alert_user2" style="display:none;">
		<div class="bg"></div>
		<div class="w">
			<div class="box1">
				<h2>Binding Sub_Supplier</h2>
				<img src="<%=path%>/images/close.jpg" class="w_close">
			</div>
			<div class="box3">
				<form id="editForm" action="${path}/brand/bind" method="post" >
						<input id="brandId"  type="hidden" name="brandId" >
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
								<col width="60px">
								<col>
							</colgroup>
							<tr>
								<td align="right">Brand Name：</td>
								<td><input id="brandName" type="text" disabled="disabled"></td>
							</tr>
							<tr>
								<td align="right">Sub_Supplier：</td>
								<td align="left">
									<select name="subSupplier" id="subSupplier">
									</select>
								</td>
							</tr>
						</table>
				        
						<button id="brandEdit" type="button"  class="bt1">Confirm</button>
						<button id="userEidtCancel" type="button"  class="bt2" >Cancel</button>
				</form>
			</div>
			<div class="blank20"></div>
		</div>
	</div>
	<!-- 弹框 end -->

        <%@include file="/WEB-INF/views/en/include/header.jsp"%>	
	    
		<div class="wrap">
			<%@include file="/WEB-INF/views/en/include/leftProduct.jsp" %>
			<form  id="SearchFrom"  action="${path}/brand/list" method="post">
			     <input name="sortFields"   type="hidden" value="${page.sortFields}"/> 
		         <input name="order"  type="hidden" value="${page.order}"/> 
			</form>
			
			
		       	<!-- 右边 start -->
				<div class="right f_l">
					<div class="title">
						<p class="c1">Brand</p>
						<div class="clear"></div>
					</div>
					<div class="blank5"></div>
					
					
					<div id="modelCont">
				
					</div>
				</div>
				<!-- 右边 end -->
		</div>	
			
			</div>
		<!-- 底部 start -->
     	<%@include file="/WEB-INF/views/en/include/last.jsp"%>
	<!-- 底部 end -->
	
	<script type="text/javascript" src="${path}/js/brand/brand.js"></script>
   </body>
   <script type="text/javascript">
   $(document).ready(function(){
	   clickSubmit(1);
   });
   
	function clickSubmit(page){
		
		var brandArray = new Array();
		
		if(page!=undefined && "" != page){
			brandArray.push('page='+page);
		}
		
		$.ajax({
			url : '${path}'+"/brand/getBrandModel",
			type : 'POST',
			data : brandArray.join('&')+'&math='+Math.random(),
			success: function (msg) {
				 $('#modelCont').html(msg);
			}, 
			error: function (XMLHttpRequest, textStatus, errorThrown) { 
				alert("服务器忙，请稍后再试!"); 
			} 
		});
	}
   			function editBrand(){
   				window.location.href="../brand/toAddUI";
   			}
			function  manage(id,name){
				$("#brandId").val(id);
				$("#brandName").val(name);
				
				$.ajax( {
					url : '${path}'+"/brand/getSubSupplier",
					type : 'POST',
					timeout : 30000,		
					success: function (msg) {
						$("#subSupplier").html("");
						$.each(eval(msg),function(i,n){
							$("#subSupplier").append("<option value='"+n.supplierId+"'>"+n.name+"</option>");
						});	  
						$('#editDiv').toggle();
					}, 
					error: function (XMLHttpRequest, textStatus, errorThrown) { 
						alert('Server is busy, please try again later!');
					} 
				});
				
			}
			
			$("#brandEdit").click(function(){
				var brandId = $("#brandId").val();
				var subSupplier = $("#subSupplier").val();
				
				$.ajax( {
					url : '${path}'+"/brand/bind",
					type : 'POST',
					data : "brandId="+brandId+"&subSupplier="+subSupplier,
					timeout : 30000,		
					success: function (data) {
						if(data==1){ 
							tipMessage("Successful!",function(){
								location.reload();
							}); 
						}else{ 
							tipMessage("Error",function(){
								location.reload();
							});
						}  
					}, 
					error: function (XMLHttpRequest, textStatus, errorThrown) { 
						alert('Server is busy, please try again later!');
					} 
				});
				
				
			});
			
			function  delBrand(id){
				$.dialog.confirm('Are you sure to delete this brand?', function(){
					$.ajax( {
						url : '${path}'+"/brand/delete?id="+id,
						type : 'POST',
						timeout : 30000,		
						success: function (data) {
							if(data.status==0){ 
								tipMessage("Error!",function(){
									location.reload();
								}); 
							}else{ 
								tipMessage("Successful!",function(){
									location.reload();
								});
							}  
						}, 
						error: function (XMLHttpRequest, textStatus, errorThrown) { 
							alert("Server is busy, please try again later!"); 
						} 
					}, function(){
					   // $.dialog.tips('执行取消操作');
					});
		    	});
			}
			function  deleteAll(){
				if($(":checkbox[name='nn'][checked]").length<=0){
					alert("Please select a item to delete!");
				}else{
					$.dialog.confirm('Are you sure to delete selected items?', function(){
						   //$("#deleteForm").submit();
					        ajaxSubmit("#deleteForm");	
					}, function(){
						   // $.dialog.tips('执行取消操作');
						});
			    	}
				}
	 </script> 
</html>