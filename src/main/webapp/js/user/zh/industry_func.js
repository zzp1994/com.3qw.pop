var ind_flag_arr = new Array();		//	已选中数组
//var ind_flag_arr = new Array('21','31','37');
if($('#mercgr').val().length>0){
	 ind_flag_arr=$('#mercgr').val().split(",");
}
var language=$("#language").val();
var Industry = {
	// 行业列表
	init : function(){
		var _str='',_id='';
		if (ind_flag_arr.length>0){
			for (var i in ind_flag_arr){
				_str+=','+ind_a[ind_flag_arr[i]];
				_id+=','+ind_flag_arr[i];
			}
			$('#mer-cgr').val(_str.substring(1));
			$('#mercgr').val(_id.substring(1));
		}
	},
	Show : function(){
		var output='',flag,output2='';
		for (var i in ind_a){
			flag=in_array(i,ind_flag_arr)?' chkON':'';
			output+='<li class="Industry' + i + flag + '" onclick="Industry.Chk(\''+i+'\')">'+ind_a[i]+'</li>';
		}
		for (var i in ind_flag_arr){
			output2+='<li class="Industry' + ind_flag_arr[i] + ' chkON" onclick="Industry.Chk(\''+ind_flag_arr[i]+'\')">'+ind_a[ind_flag_arr[i]]+'</li>';
		}
		$('#drag').width('670px');
		//$('#drag').css('top"',200); 
		$('#IndustryList').html('<ul>'+output+'</ul>');
		$('#IndustrySelected dd').html(output2);

		// 鼠标悬停变色
		$('#IndustryAlpha li').hover(function(){$(this).addClass('over')},function(){$(this).removeClass('over')});
	},
	Chk : function(id){
		if(!in_array(id,ind_flag_arr)){
			if(ind_flag_arr.length<5){
				ind_flag_arr[ind_flag_arr.length]=id;
				var html='<li class="Industry'+id+'" onclick="Industry.Chk(\''+id+'\')">'+ind_a[id]+'</li>';
				$('#IndustrySelected dd').append(html);
				$('.Industry'+id).addClass('chkON');
				$('#IndustrySelected li').hover(function(){$(this).addClass('over')},function(){$(this).removeClass('over')});
			}else{
				if(language == "en"){
					alert('The total items is no more than 5 ');
				}else{
					alert('您最多能选择5项');
				}
				
				return false;
			}
		}else{
			for (var i in ind_flag_arr){
				if(ind_flag_arr[i]==id) ind_flag_arr.splice(i,1);;
			}
			$('#IndustrySelected .Industry'+id).remove();
			$('.Industry'+id).removeClass('chkON');
		}
	},
	// 确定
	confirm : function(){
		var indStr='';
		for(var i in ind_flag_arr){
			indStr+=','+ind_a[ind_flag_arr[i]];
		}
		if(language == "en"){
			indStr=indStr.substring(1)?indStr.substring(1):'';
		}else{
			indStr=indStr.substring(1)?indStr.substring(1):'';
		}
		
		$('#mer-cgr').val(indStr);
		$('#mercgr').val(ind_flag_arr);
		boxAlpha();

	},

}

// 多选
function IndustrySelect(){
	var dragHtml ='<div id="IndustryAlpha">';		//行业
	if(language == "en"){
		 dragHtml+='		<dl id="IndustrySelected"><dt>Selected categories：</dt><dd></dd></dl>';
		 dragHtml+='		<div id="IndustryList"></div>';//行业列表
		 dragHtml+='</div>';
	     $('#drag_h').html('<b>Please select product categories(The total items is no more than 5)</b><span onclick="Industry.confirm()">Confrim</span>');
	}else{
		dragHtml+='		<dl id="IndustrySelected"><dt>已选商品类别：</dt><dd></dd></dl>';
		dragHtml+='		<div id="IndustryList"></div>';//行业列表
		dragHtml+='</div>';
	     $('#drag_h').html('<b>请选择商品类别（您最多能选择5项）</b><span onclick="Industry.confirm()">确定</span>');
	}
	
	$('#drag_con').html(dragHtml);

	Industry.Show();
	boxAlpha();
	draglayer();
}

// 默认选中赋值文本显示框
function showText(){
	var indStr='';
	for(var i in ind_flag_arr){
		indStr+=','+ind_a[ind_flag_arr[i]];
	}
	if(language == "en"){
		indStr=indStr.substring(1)?indStr.substring(1):'';
	}else{
		indStr=indStr.substring(1)?indStr.substring(1):'';
	}
	$('#mer-cgr').val(indStr);
}

