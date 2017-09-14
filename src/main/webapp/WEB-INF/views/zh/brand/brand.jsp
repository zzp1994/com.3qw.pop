<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	  <title>商家后台管理系统-品牌管理</title>
      <%@include file="/WEB-INF/views/zh/include/base.jsp"%>
	  <link rel="stylesheet" type="text/css" href="${path}/css/zh/user.css">
      <link rel="stylesheet" type="text/css" href="${path}/css/zh/juese.css">
	</head>
	<body>
		<div id="editDiv" class="alert_user2" style="display:none;">
		<div class="bg"></div>
		<div class="w">
			<div class="box1">
				<h2>绑定子供应商</h2>
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
								<td align="right">品牌名称：</td>
								<td><input id="brandName" type="text" disabled="disabled"></td>
							</tr>
							<tr>
								<td align="right">子供应商：</td>
								<td align="left">
									<select name="subSupplier" id="subSupplier">
									</select>
								</td>
							</tr>
						</table>
				        
						<button id="brandEdit" type="button"  class="bt1">确定</button>
						<button id="userEidtCancel" type="button"  class="bt2" >取消</button>
				</form>
			</div>
			<div class="blank20"></div>
		</div>
	</div>
	<!-- 弹框 end -->

        <%@include file="/WEB-INF/views/zh/include/header.jsp"%>	
	    
		<div class="wrap">
			<%@include file="/WEB-INF/views/zh/include/leftProduct.jsp" %>
			<form  id="SearchFrom"  action="${path}/brand/list" method="post">
			     <input name="sortFields"   type="hidden" value="${page.sortFields}"/> 
		         <input name="order"  type="hidden" value="${page.order}"/> 
			</form>
			
			
		       	<!-- 右边 start -->
			<div class="right f_l">
				<div class="title">
					<p class="c1">品牌管理 </p>
					<div class="clear"></div>
				</div>
				<div class="blank5"></div>
				
				<div id="modelCont">
				
				</div>
				<!-- 右边 end -->
			    
			</div>	
		</div>
		<!-- 底部 start -->
     	<%@include file="/WEB-INF/views/zh/include/last.jsp"%>
	<!-- 底部 end -->
	
	
   </body>
   <script type="text/javascript" src="${path}/js/brand/brand.js"></script>
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
				alert("服务器忙，请稍后再试!"); 
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
					tipMessage("操作成功!",function(){
						location.reload();
					}); 
				}else{ 
					tipMessage("操作失败",function(){
						location.reload();
					});
				}  
			}, 
			error: function (XMLHttpRequest, textStatus, errorThrown) { 
				alert("服务器忙，请稍后再试!"); 
			} 
		});
		
		
	});
	
	function  delBrand(id){
		$.dialog.confirm('确定要删除此品牌?', function(){
			$.ajax( {
				url : '${path}'+"/brand/delete?id="+id,
				type : 'POST',
				timeout : 30000,		
				success: function (data) {
					if(data.status==0){ 
						tipMessage("操作失败!",function(){
							location.reload();
						}); 
					}else{ 
						tipMessage("操作成功",function(){
							location.reload();
						});
					}  
				}, 
				error: function (XMLHttpRequest, textStatus, errorThrown) { 
					alert("服务器忙，请稍后再试!"); 
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