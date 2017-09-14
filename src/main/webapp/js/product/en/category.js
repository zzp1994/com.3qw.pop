
//当前选择的对象默认为"";
var g_obj="";

$(function(){
	//一级
	$(".main_m_fir ul li").live('click',function(){
		_fdbCss($(this),"main_m_sec");
		g_obj=$(this);
	});
	//二级
	$(".main_m_sec ul li").live('click',function(){
		_fdbCss($(this),"main_m_thi");
		g_obj=$(this);
	});
	//三级
	$(".main_m_thi ul li").live('click',function(){
		_fdbCss($(this),"main_m_fou");
		g_obj=$(this);
	});
	//四级
	$(".main_m_fou ul li").live('click',function(){
		_fdbCss($(this),"main_m_fiv");
		g_obj=$(this);
	});
	//五级
	$(".main_m_fiv ul li").live('click',function(){
		_fdbCss2($(this));
		g_obj=$(this);
		
		$(".main .infoDiv").remove();
		$(".infoDiv").clone().appendTo($(".color:last").parent());
		setTimeout(function(){
			$(".main .infoDiv").fadeOut(400);
		},3000);
	});


	$(".main_m_thi ul li").live('click',function(){
		$(".main_m_fou ul").show();
		$(".main_m_fou").removeClass("original");
	});
	//main_m original main_m_sec

	//进入下一页
	$("#nextView").click(function(){
		if(g_obj==""||g_obj.attr("pid")=="0"){
			alert("please select category");
			return false;
		}else{
			var val=g_obj.attr("pval");
			var path=$("#path").val();
			var url=path + "/product/toCreateUI?cid="+val;
			window.parent.location=url;
//			var url="http://localhost:8080/web-supplier/product/toCreateUI?cid="+val;
//			window.location=url;
			//alert(val);
		}
	});

	//发布商品（提示）
	$(".btn_red2").live("click",function(){
		$("#nextView").click();
		return false;
	});

});





//样式
function _fdbCss(obj,node){
	_fdbCss2(obj);
	var val=obj.attr("pval");
	var path=$("#path").val();
	f_fAjax("post",path+"/product/childCategory",{parentCid:val},node);
}

//当前选择的目录
function addCate(obj){
	var cate = obj.find("a").html();
	$("#selectCategory").html("Currently Selected Category： ");
	var temp= obj.parent().parent().attr("class");
	var sec=".main ul li a[class='color']";
	if(temp=="main_m main_m_fir"){
		  $("#selectCategory").append("<span>"+cate+"</span>");
		  return;
	}
	$(sec).each(function(index,element){
		    var ca=$(this).parent().parent().parent().attr("class")
		    if(ca=="main_m main_m_fir"){
			   $("#selectCategory").append("<span>"+$(this).text()+"</span>");
			   
		    }
		    else if(ca==temp){
		    	$("#selectCategory").append("<span>&gt;</span>" + "<span>"+cate+"</span>");
		    	return false;
		    }
		    if(ca!=temp&&ca!="main_m main_m_fir"){
		    	$("#selectCategory").append("<span>&gt;</span>" + "<span>"+$(this).text()+"</span>");}
		    
		    
	  });
	
}

//选中 字体颜色
function _fdbCss2(obj){
	obj.parent().find(".color").removeClass("color");
	obj.addClass("color");
	obj.find("a").addClass("color");
	addCate(obj);
}

//数据交互
function f_fAjax(type,url,data,node){
	$.ajax({
		type: type,
        url: url,
        dataType:"text",
        data: data,
        success: function (source, textStatus) {
			_fdbCss3(node);
//			var val=JSON.parse(source);
			//alert(source.text);
			var val = '';
			if(source!=""){
				val = eval("(" +source+ ")");
			}
			if(val.length>0){
				//移除禁用模板
				$("."+node).removeClass("original");
				//绑定数据
				_fdbStep(val,node);
			} else{
				$(".main .infoDiv").remove();
				$(".infoDiv").clone().appendTo($(".color:last").parent());
				setTimeout(function(){
					$(".main .infoDiv").fadeOut(400);
				},3000);
			}
        },
        error: function () {
            alert("error");
        }
    });
}

//还原模板
function _fdbCss3(node){
	var aNode=["main_m_sec","main_m_thi","main_m_fou","main_m_fiv"];
	$.each(aNode,function(i){
		if(node==aNode[i]){
			for(j=i;j<aNode.length;j++){
				$("."+aNode[j]+" ul").html("").hide();
				//添加禁用模板
				$("."+aNode[j]).addClass("original");
			}
		}
	});
}


//绑定数据
function _fdbStep(arr,node){
	$("."+node+" ul").html("");
	$.each(arr,function(i){
		var temp=$(".dw_temp").find("li").clone();
		temp.attr("pval",arr[i].cid);
		temp.attr("pid",arr[i].leaf);
		temp.find("a").text(arr[i].name);
		temp.appendTo($("."+node+" ul"));
	});
	$("."+node+" ul").show();
}

if (typeof JSON !== 'object') {
    JSON = {};
}

(function () {
    'use strict';

    function f(n) {
        // Format integers to have at least two digits.
        return n < 10 ? '0' + n : n;
    }

    if (typeof Date.prototype.toJSON !== 'function') {

        Date.prototype.toJSON = function () {

            return isFinite(this.valueOf())
                ? this.getUTCFullYear()     + '-' +
                    f(this.getUTCMonth() + 1) + '-' +
                    f(this.getUTCDate())      + 'T' +
                    f(this.getUTCHours())     + ':' +
                    f(this.getUTCMinutes())   + ':' +
                    f(this.getUTCSeconds())   + 'Z'
                : null;
        };

        String.prototype.toJSON      =
            Number.prototype.toJSON  =
            Boolean.prototype.toJSON = function () {
                return this.valueOf();
            };
    }

    var cx,
        escapable,
        gap,
        indent,
        meta,
        rep;


    function quote(string) {

// If the string contains no control characters, no quote characters, and no
// backslash characters, then we can safely slap some quotes around it.
// Otherwise we must also replace the offending characters with safe escape
// sequences.

        escapable.lastIndex = 0;
        return escapable.test(string) ? '"' + string.replace(escapable, function (a) {
            var c = meta[a];
            return typeof c === 'string' ? c
                : '\\u' + ('0000' + a.charCodeAt(0).toString(16)).slice(-4);
        }) + '"' : '"' + string + '"';
    }


    function str(key, holder) {

// Produce a string from holder[key].

        var i,          // The loop counter.
            k,          // The member key.
            v,          // The member value.
            length,
            mind = gap,
            partial,
            value = holder[key];

// If the value has a toJSON method, call it to obtain a replacement value.

        if (value && typeof value === 'object' &&
                typeof value.toJSON === 'function') {
            value = value.toJSON(key);
        }

// If we were called with a replacer function, then call the replacer to
// obtain a replacement value.

        if (typeof rep === 'function') {
            value = rep.call(holder, key, value);
        }

// What happens next depends on the value's type.

        switch (typeof value) {
        case 'string':
            return quote(value);

        case 'number':

// JSON numbers must be finite. Encode non-finite numbers as null.

            return isFinite(value) ? String(value) : 'null';

        case 'boolean':
        case 'null':

// If the value is a boolean or null, convert it to a string. Note:
// typeof null does not produce 'null'. The case is included here in
// the remote chance that this gets fixed someday.

            return String(value);

// If the type is 'object', we might be dealing with an object or an array or
// null.

        case 'object':

// Due to a specification blunder in ECMAScript, typeof null is 'object',
// so watch out for that case.

            if (!value) {
                return 'null';
            }

// Make an array to hold the partial results of stringifying this object value.

            gap += indent;
            partial = [];

// Is the value an array?

            if (Object.prototype.toString.apply(value) === '[object Array]') {

// The value is an array. Stringify every element. Use null as a placeholder
// for non-JSON values.

                length = value.length;
                for (i = 0; i < length; i += 1) {
                    partial[i] = str(i, value) || 'null';
                }

// Join all of the elements together, separated with commas, and wrap them in
// brackets.

                v = partial.length === 0 ? '[]' : gap
                    ? '[\n' + gap + partial.join(',\n' + gap) + '\n' + mind + ']' : '[' + partial.join(',') + ']';
                    gap = mind;
                return v;
            }

// If the replacer is an array, use it to select the members to be stringified.

            if (rep && typeof rep === 'object') {
                length = rep.length;
                for (i = 0; i < length; i += 1) {
                    if (typeof rep[i] === 'string') {
                        k = rep[i];
                        v = str(k, value);
                        if (v) {
                            partial.push(quote(k) + (gap ? ': ' : ':') + v);
                        }
                    }
                }
            } else {

// Otherwise, iterate through all of the keys in the object.

                for (k in value) {
                    if (Object.prototype.hasOwnProperty.call(value, k)) {
                        v = str(k, value);
                        if (v) {
                            partial.push(quote(k) + (gap ? ': ' : ':') + v);
                        }
                    }
                }
            }

// Join all of the member texts together, separated with commas,
// and wrap them in braces.

            v = partial.length === 0
                ? '{}'
                : gap
                ? '{\n' + gap + partial.join(',\n' + gap) + '\n' + mind + '}'
                : '{' + partial.join(',') + '}';
            gap = mind;
            return v;
        }
    }

// If the JSON object does not yet have a stringify method, give it one.

    if (typeof JSON.stringify !== 'function') {
        escapable = /[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g;
        meta = {    // table of character substitutions
            '\b': '\\b',
            '\t': '\\t',
            '\n': '\\n',
            '\f': '\\f',
            '\r': '\\r',
            '"' : '\\"',
            '\\': '\\\\'
        };
        JSON.stringify = function (value, replacer, space) {

// The stringify method takes a value and an optional replacer, and an optional
// space parameter, and returns a JSON text. The replacer can be a function
// that can replace values, or an array of strings that will select the keys.
// A default replacer method can be provided. Use of the space parameter can
// produce text that is more easily readable.

            var i;
            gap = '';
            indent = '';

// If the space parameter is a number, make an indent string containing that
// many spaces.

            if (typeof space === 'number') {
                for (i = 0; i < space; i += 1) {
                    indent += ' ';
                }

// If the space parameter is a string, it will be used as the indent string.

            } else if (typeof space === 'string') {
                indent = space;
            }

// If there is a replacer, it must be a function or an array.
// Otherwise, throw an error.

            rep = replacer;
            if (replacer && typeof replacer !== 'function' &&
                    (typeof replacer !== 'object' ||
                    typeof replacer.length !== 'number')) {
                throw new Error('JSON.stringify');
            }

// Make a fake root object containing our value under the key of ''.
// Return the result of stringifying the value.

            return str('', {'': value});
        };
    }


// If the JSON object does not yet have a parse method, give it one.

    if (typeof JSON.parse !== 'function') {
        cx = /[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g;
        JSON.parse = function (text, reviver) {

// The parse method takes a text and an optional reviver function, and returns
// a JavaScript value if the text is a valid JSON text.

            var j;

            function walk(holder, key) {

// The walk method is used to recursively walk the resulting structure so
// that modifications can be made.

                var k, v, value = holder[key];
                if (value && typeof value === 'object') {
                    for (k in value) {
                        if (Object.prototype.hasOwnProperty.call(value, k)) {
                            v = walk(value, k);
                            if (v !== undefined) {
                                value[k] = v;
                            } else {
                                delete value[k];
                            }
                        }
                    }
                }
                return reviver.call(holder, key, value);
            }


// Parsing happens in four stages. In the first stage, we replace certain
// Unicode characters with escape sequences. JavaScript handles many characters
// incorrectly, either silently deleting them, or treating them as line endings.

            text = String(text);
            cx.lastIndex = 0;
            if (cx.test(text)) {
                text = text.replace(cx, function (a) {
                    return '\\u' +
                        ('0000' + a.charCodeAt(0).toString(16)).slice(-4);
                });
            }

// In the second stage, we run the text against regular expressions that look
// for non-JSON patterns. We are especially concerned with '()' and 'new'
// because they can cause invocation, and '=' because it can cause mutation.
// But just to be safe, we want to reject all unexpected forms.

// We split the second stage into 4 regexp operations in order to work around
// crippling inefficiencies in IE's and Safari's regexp engines. First we
// replace the JSON backslash pairs with '@' (a non-JSON character). Second, we
// replace all simple value tokens with ']' characters. Third, we delete all
// open brackets that follow a colon or comma or that begin the text. Finally,
// we look to see that the remaining characters are only whitespace or ']' or
// ',' or ':' or '{' or '}'. If that is so, then the text is safe for eval.

            if (/^[\],:{}\s]*$/
                    .test(text.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g, '@')
                        .replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g, ']')
                        .replace(/(?:^|:|,)(?:\s*\[)+/g, ''))) {

// In the third stage we use the eval function to compile the text into a
// JavaScript structure. The '{' operator is subject to a syntactic ambiguity
// in JavaScript: it can begin a block or an object literal. We wrap the text
// in parens to eliminate the ambiguity.

                j = eval('(' + text + ')');

// In the optional fourth stage, we recursively walk the new structure, passing
// each name/value pair to a reviver function for possible transformation.

                return typeof reviver === 'function' ? walk({'': j}, '') : j;
            }

// If the text is not JSON parseable, then a SyntaxError is thrown.

            throw new SyntaxError('JSON.parse');
        };
    }
}());