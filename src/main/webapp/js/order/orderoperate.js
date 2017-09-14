$(document).ready(function(){
	$("#endTime").live("blur", checkendtime);
	$("#createTime").live("blur", checkcreatetime);
	$("table.sq_wrap").delegate("td a","click",function(){
		//var src = event.srcElement || event.target; 
		if($(this).closest("table").find("tr").length>2){
			$(this).closest("tr").remove();
		}
	});
	
	$(".sub").click(function(){
		var submit = true;
		$("table.sq_wrap").each(function(){
			var it = $(this);
			it.closest(".tabborder").find(".dpl-tip-inline-warning").remove();
			var total = Number(it.closest("div").find(".t2 span").eq(2).text());
			var isisnull = isnull(it), isiserror = iserror(it), isnum=numche(it, total);
			if ( isiserror ||  isisnull || !isnum){	
				if(isisnull){
					it.after($('<span class="dpl-tip-inline-warning" >请将数据填写完整</span>'));
				}else if(!isnum){
					it.after($('<span class="dpl-tip-inline-warning" >按批次录入的商品数量总和应和相应SKU的商品数量总和相等</span>'));
				}
				submit = false;
				return;
			}
				
		});
		if(submit){
			//submit
			$.ajax({
				type:'post',
				url:'../order/despatch',
				data:$("#despatch").serialize(),
				error:function(){
					alert('error');
				},
				success:function(data){
					if(data=="0"){
						alert('服务器忙！请稍后重试！');
					}
					if(data=="1"){
						tipMessage("发货成功！返回已卖出的商品页！",function(){
							window.location.href="../order/getOrder";
						});
					}
				}
			});
			
		}
	});
	
	$("table input.pici").live("blur", chpici);
	$("table input.num").live("blur", chnum);
});
function chnum(){
	var that =$(this), val = this.value;
	that.closest(".tabborder").find(".dpl-tip-inline-warning").remove();
	if(val!=""){
		if(!RegExp("^[0-9]+$").test(val)  || val == "0"){
			that.closest("table").after($('<span class="dpl-tip-inline-warning">数量应为大于0的数字</span>'));
			this.value = "";
		}else {
			var total = Number(that.closest("div").find(".t2 span").eq(2).text()), n=0;
			that.closest("table").find(".num").each(function(i,item){
				n += Number(item.value);
			});
			if(n>total){
				that.closest("table").after($('<span class="dpl-tip-inline-warning" >按批次录入的商品数量总和应和相应SKU的商品数量总和相等</span>'));
				this.value = "";
			}
		}
	}
}
function chpici(){
	var that =$(this), val = this.value;
	that.closest(".tabborder").find(".dpl-tip-inline-warning").remove();
	if(val!=""){
		if(!RegExp("^[\\w-]{1,100}$").test(val)){
			that.closest("table").after($('<span class="dpl-tip-inline-warning" >批次号为1-100位的数字、字母、-和_</span>'));
			this.value = "";
		}else if(that.closest("table").find(".pici").length>1){
			that.closest("table").find(".pici").not(that).each(function(i,item){
				if(val == item.value){
					that.closest("table").after($('<span class="dpl-tip-inline-warning" >批次号不能相同</span>'));
					that.val("") ;
					return;
				}
			});
		}
	}
}


function addtime(event,skuId){
	var src = event.srcElement || event.target; 
	var table =  $(src).closest("div").find("table");
	var total = Number($(src).closest("div").find(".t2 span").eq(2).text());
	
	if(!numche(table, total) && !isnull(table) && !iserror(table) ){
		var tr = $('<tr class="sq_b"><td><input type="hidden" name="skuId" value="'+skuId+'"><input type="text" name="batchNo" class="pici"></td><td><input type="text" name="qty" class="num"></td><td><input type="text" id="createTime" name="createTime" readonly="readonly" onClick="WdatePicker()"></td><td><input type="text" id="endTime" name="endTime" readonly="readonly" onClick="WdatePicker()"></td><td><a>删除</a></td></tr>');
		table.append(tr);
	}
	
}

function add(event,skuId){
	var src = event.srcElement || event.target; 
	var table = $(src).closest("div").find("table");
	var total = Number($(src).closest("div").find(".t2 span").eq(2).text());
	if(!numche(table, total) && !isnull(table) && !iserror(table)){
		var tr = $("<tr class='sq_b'><td><input type='hidden' name='skuId' value='"+skuId+"'><input type='text' name='batchNo' class='pici'></td><td><input type='text' name='qty' class='num'></td><td><a>删除</a></td></tr>");
		$(src).prev().append(tr);
	}
}

function numche(table, total){
	var n =0;
	table.find(".num").each(function(i,item){
		n+=Number(item.value);
	});
	if(n == total){
		return true;
	}else{
		return false;
	}
}

function isnull(table){
	var isnull = false;
	table.find("input").each(function(){
		if(this.value == ""){
			isnull = true;
			return isnull;
		}
	});
	return isnull;
}

function iserror(table){
	var iserror = false;
	if(table.closest(".tabborder").has(".dpl-tip-inline-warning").length>0)
		iserror = true;
	return iserror;
}
function checkendtime(){
	var that =$(this), val = this.value;
	that.closest(".tabborder").find(".dpl-tip-inline-warning").remove();
	if(val!=""){
		var createTime = that.parent().prev().find("#createTime").val();
		if(createTime!=""){
			if(val<createTime){
				that.closest("table").after($('<span class="dpl-tip-inline-warning" >生产日期不能大于有效日期!</span>'));
				this.value = "";
			}
		}
	}
}
function checkcreatetime(){
	var that =$(this), val = this.value;
	that.closest(".tabborder").find(".dpl-tip-inline-warning").remove();
	if(val!=""){
		var endTime = that.parent().next().find("#endTime").val();
		if(endTime!=""){
			if(val>endTime){
				that.closest("table").after($('<span class="dpl-tip-inline-warning" >生产日期不能大于有效日期!</span>'));
				this.value = "";
			}
		}
	}
}

