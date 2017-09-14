/**
 * 显示图片上传错误
 * 
 * @param file
 *            出错的文件引用
 * @param errorCode
 *            错误码
 */
function showUploadError(file, errorCode) {
	var errorMsg = {
		"upload.file.too.big" : "文件过大",
		"upload.invalid.file.type" : "类型不符",
		"upload.invalid.size" : "尺寸不对",
		"ware.publish.exception" : "网络不给力"
	};
	var imgBox = $('.g-imgs.open .p-img[fileId=' + file.id + ']');
	if ($.isEmptyObject(imgBox) || imgBox.size() != 1) {
		// 没有对应位置的时候 需不需要提示，如何提示
		// alert(errorMsg[errorCode])
	} else {
		imgBox.parent("li").removeClass("waiting").addClass("error") // 移除上传状态
		.find(".error-txt").remove().end() // 移除以前可能存在的错误提示
		.prepend('<div class="error-txt">' + errorMsg[errorCode] + '</div>')
				.find(".progress").remove();
	}
}
/**
 * 记录已经入队的文件文件引用 每个文件入队，push进来 每个文件上传成功，pop出去
 * 如果入队文件数大于空格数，则将队列中所有文件cancelUpload。并清空该队列
 * 
 * @type {Array}
 */
var queuedFiles = [];
/**
 * 打开文件选择窗口 不做事情
 */
function fileDialogStart() {
	// 将占位属性清除
	var id = this.button.parent().attr("id").split("_")[0];
	$("#" + id + "_img .p-img").removeAttr("fileId");

}
/**
 * 文件入队事件处理
 * 
 * @param file
 */
function fileQueued(file) {
	try {
		// 将已经入队的文件记录下来
		queuedFiles.push(file);
		// 找到本文件将要显示的位置，使用fileId占位
		// $('.g-imgs.open .p-img:empty').each(function (i, o) {
		var id = this.button.parent().attr("id").split("_")[0];

		$('#' + id + '_img .p-img:empty').each(function(i, o) {
			if (!$(this).attr("fileId")) {
				$(this).attr("fileId", file.id);
				return false;
			}
		});
	} catch (ex) {
		this.debug(ex);
	}
}
/**
 * 文件入队错误事件处理
 * 
 * @param file
 * @param errorCode
 * @param message
 */
function fileQueueError(file, errorCode, message) {
	// 找到本文件将要显示的位置，使用fileId占位
	$('#upload_img .p-img:empty').each(function(i, o) {
		if (!$(this).attr("fileId")) {
			$(this).attr("fileId", file.id);
			return false;
		}
	});
	try {
		switch (errorCode) {
		case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
			showUploadError(file, "upload.file.too.big");
			break;
		case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
			showUploadError(file, "upload.file.too.big");
			break;
		case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
			showUploadError(file, "upload.invalid.file.type");
			break;
		default:
			showUploadError(file, "ware.publish.exception");
			break;
		}
	} catch (ex) {
		this.debug(ex);
		showUploadError(file, "ware.publish.exception");
	}
}
/**
 * 文件选择框关闭
 * 
 * @param numFilesSelected
 * @param numFilesQueued
 */

function fileDialogComplete(numFilesSelected, numFilesQueued) {
	try {
		var id = this.button.parent().attr("id").split("_")[0];
		var numSpace = (6 - $('#' + id + '_img .p-img img').size());
		if (numFilesSelected > 0 && numSpace < numFilesSelected) { // 选了大于空位个数的文件。取消本次上传动作，并提示
			// 将已经入队的文件取消上传
			for ( var f in queuedFiles) {
				this.cancelUpload(f.id, false);
			}
			queuedFiles = [];
			// 将占位属性清除
			$("#" + id + "_img .p-img").removeAttr("fileId");
			// 给出提示
			alert("最多只能添加6张图片哦");
		} else {
			// 自动开始上传
			this.startUpload();
		}
	} catch (ex) {
		this.debug(ex);
	}
}
/**
 * 开始上传
 * 
 * @param file
 * @returns {boolean}
 */
function uploadStart(file) {
	try {
		// 对文件名称进行编码
		this.addPostParam("fileName", encodeURIComponent(file.name));
		// product的文件上传
		this.addPostParam("type", "Product");
		// 兼容firefox 将登陆验证的cookie带上
		this.addPostParam("cookiePostName", $("#cookieValue").val());
		// 3级类目id
		// this.addPostParam("cid", $("#cid").val());
		// 显示上传进度条
		var id = this.button.parent().attr("id").split("_")[0];
		var imgBox = $('#' + id + '_img .p-img[fileId=' + file.id + ']');
		imgBox
				.parent("li")
				.removeClass("error")
				.find(".error-txt")
				.remove()
				.end()
				// 移除上一次的错误提示
				.addClass("waiting")
				.find(".progress")
				.remove()
				.end()
				// 移除以前可能存在的进度条
				.append(
						'<div class="progress"><div style="width:0%;" class="per-bar"></div><div class="per-cent">0%</div></div>');
	} catch (ex) {
	}
	return true;
}
/**
 * 上传过程中
 * 
 * @param file
 * @param bytesLoaded
 * @param bytesTotal
 */
function uploadProgress(file, bytesLoaded, bytesTotal) {
	try {
		// 更新上传进度
		var id = this.button.parent().attr("id").split("_")[0];
		var percent = Math.ceil((bytesLoaded / bytesTotal) * 100);
		var imgBox = $('#' + id + '_img .p-img[fileId=' + file.id + ']');
		imgBox.parent("li").find(".progress").find(".per-bar").css("width",
				percent + "%").end().find(".per-cent").text(percent + "%");
	} catch (ex) {
		this.debug(ex);
	}
}
/**
 * 上传成功
 * 
 * @param file
 * 
 * @param serverData
 */
function uploadSuccess(file, serverData) {
	var id = this.button.parent().attr("id").split("_")[0];
	var imgBox = $('#' + id + '_img .p-img[fileId=' + file.id + ']');
	imgBox.empty();
	try {
		// 删除进度条，显示图片

		serverData = $.parseJSON(serverData);
		if (serverData.success) {
			var img = $(
					'<img ' + 'imgtype="temp"' +
					// 'onerror="loadImgError(this)"' +
					'width="100px"' + 'filename="' + serverData.data.filename
							+ '"' + 'src="' + serverData.data.Url + '"/>'
							+ "<input type='hidden' name='imgUrl' value='" + id
							+ "_" + serverData.data.Url + "'>").hide();
			imgBox.removeAttr("fileId").append(img);
			imgBox.parent("li").find(".progress").fadeOut(600, function() {
				$(this).remove();
			});
			img.fadeIn(1000, function() {
				imgBox.parent("li").removeClass("waiting")
			});
			// 显示删除条
			imgBox.parent("li").find(".operate").show();
		} else {
			showUploadError(file, serverData.errorCode);
		}
	} catch (ex) {
		this.debug(ex);
		showUploadError(file, "ware.publish.exception");
	}
}
/**
 * 上传错误
 * 
 * @param file
 * @param errorCode
 * @param message
 */
function uploadError(file, errorCode, message) {
	var id = this.button.parent().attr("id").split("_")[0];
	var imgBox = $('#' + id + '_img .p-img[fileId=' + file.id + ']');
	imgBox.empty();
	imgBox.parent("li").find(".progress").fadeOut(600, function() {
		$(this).remove();
	});
	showUploadError(file, "ware.publish.exception");
}
/**
 * 上传完成
 * 
 * @param file
 */
function uploadComplete(file) {
}
/**
 * 整个文件队列上传完成
 * 
 * @param numFilesUploaded
 */
function queueComplete(numFilesUploaded) {
	var id = this.button.parent().attr("id").split("_")[0];
	queuedFiles = [];
	$('#' + id + '_img .p-img').removeAttr("fileId");
}
/**
 * 探测浏览器是否支持flash插件，当无法探测时，返回true
 * 
 * @returns {boolean}
 */
function flashDetect() {
	if (navigator.mimeTypes.length > 0) {
		return navigator.mimeTypes["application/x-shockwave-flash"]
				&& navigator.mimeTypes["application/x-shockwave-flash"].enabledPlugin;
	} else if (window.ActiveXObject) { // IE
		try {
			new ActiveXObject("ShockwaveFlash.ShockwaveFlash");
			return true;
		} catch (oError) {
			return false;
		}
	} else {
		// no way to detect
		return true;
	}
}



/*条形码图片上传*/
/**
 * 上传成功
 * 
 * @param file
 * 
 * @param serverData
 */
function uploadSuccess1(file, serverData) {
	var id = this.button.parent().attr("id").split("_")[0];
	var imgBox = $('#' + id + '_img');
	imgBox.empty();
	try {
		// 删除进度条，显示图片
		serverData = $.parseJSON(serverData);
		if (serverData.success) {
			var img = $(
					'<img ' + 'imgtype="temp"' +
					// 'onerror="loadImgError(this)"' +
					'width="120px"' 
					     +'height="30px"' 
					     +'class="preview"' 
							+ 'src="' + serverData.data.Url + '"/>'
							+ "<input type='hidden' name='barCodeImg' value='" + serverData.data.Url + "'>");
			imgBox.removeAttr("fileId").append(img);
//			imgBox.parent("li").find(".progress").fadeOut(600, function() {
//				$(this).remove();
//			});
//			img.fadeIn(1000, function() {
//				imgBox.parent("li").removeClass("waiting")
//			});
			// 显示删除条
//			imgBox.parent("li").find(".operate").show();
		} else {
			showUploadError(file, serverData.errorCode);
		}
	} catch (ex) {
		this.debug(ex);
		showUploadError(file, "ware.publish.exception");
	}
}
/**
 * 开始上传
 * 
 * @param file
 * @returns {boolean}
 */
function uploadStart1(file) {
	try {
		// 对文件名称进行编码
		this.addPostParam("fileName", encodeURIComponent(file.name));
		// product的文件上传
		this.addPostParam("type", "Product");
		// 兼容firefox 将登陆验证的cookie带上
		this.addPostParam("cookiePostName", $("#cookieValue").val());
		// 3级类目id
		// this.addPostParam("cid", $("#cid").val());
		// 显示上传进度条
		var id = this.button.parent().attr("id").split("_")[0];
		var imgBox = $('#' + id + '_img');
		imgBox
				.parent("li")
				.removeClass("error")
				.find(".error-txt")
				.remove()
				.end()
				// 移除上一次的错误提示
				.addClass("waiting")
				.find(".progress")
				.remove()
				.end()
				// 移除以前可能存在的进度条
				.append(
						'<div class="progress"><div style="width:0%;" class="per-bar"></div><div class="per-cent">0%</div></div>');
	} catch (ex) {
	}
	return true;
}