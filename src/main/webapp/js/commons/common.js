/*var confirm=function(str){
		var confirmdiv = $('<div id="confirm" class="alert_user4"><div class="bg"></div><div class="w"><div class="box1"></div><div class="box4"><p></p></div><div class="ann"><button  type="button" class="bt1">confirm</button><button  type="button" class="bt2">cancel</button> </div></div></div>');
		 //var handler = handler1;
		var flag = true;
		$("body").append(confirmdiv);
		 $("#confirm").show();
		 $("#confirm .box4 p").text(str);
		 //$("#confirm .bt1").bind("click",handler);
		 $("#confirm .b_close").click(function(){
			//$("#confirm .bt1").unbind("click",handler);
			$("#confirm").remove();
			flag = false;
			//return false;
		 })
		 $("#confirm .bt2").click(function(){
			//$("#confirm .bt1").unbind("click",handler);
			$("#confirm").remove();
			flag = false;
		 })
		 $("#confirm .bt1").click(function(){
			//$("#confirm .bt1").unbind("click",handler);
			$("#confirm").remove();
			flag = true;
		 })	 
		 return flag;
     }*/
var alert=function(str){
     	 var alertdiv = $('<div id="alert" class="alert_user4"><div class="bg"></div><div class="w"><div class="box1"></div><div class="box4"><p></p></div><div class="ann"><button  type="button" class="bt1">confirm</button> </div></div></div>');
		 $("body").append(alertdiv);
		 $("#alert").show();
		 $("#alert .box4 p").text(str);
		 $("#alert .b_close").click(function(){
			$("#alert").remove();
		 })
		 $("#alert .bt1").click(function(){
			$("#alert").remove();
		 })
}