$(document).ready(function(){
	color();
});
// 奇偶行背景颜色
var color=function(){
	$(".title_2 li").each(function(){
		$(".title_2 li:even").css("background","#f1f1f1");
	});
};