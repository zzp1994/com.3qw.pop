//jQuery(function() {
	
    uploader = [];
        
    function inituploader(name, id,  urllist){
    	var $ = jQuery,    // just in case. Make sure it's not an other libaray.
        productId= $("#productId").val();
    	//uploader容器
        //var $wrap = $('#uploader' + id);
//        var content = $('<p class="title">证明资质的图片</p>
//        		<div class="queueList">
////        			<div id="dndArea" class="placeholder">
////        				<div class="filePicker">点击上传图片</div>
////        				<p >或将照片拖到这里，单次最多可选6张</p>
////        			</div>
//        		</div>
////        		<div class="statusBar" style="display:none;">
////        		     //<div class="progress"><span class="text">0%</span><span class="percentage"></span></div>
//////        			<div class="info"></div>
////        			<div class="btns">
////        				<div class="filePicker2"></div>
////        				<div class="uploadBtn">开始上传</div>
////        			</div>
////        		</div>
//        		');
    	
    	 // WebUploader实例
        uploader.push(id);
        var len = uploader.length-1;

        var 
        
        // 总体进度条
        $progress = $('<div class="progress"><span class="text">0%</span><span class="percentage"></span></div>').hide(), 
        // 文件总体选择信息。
        $info = $('<div class="info"></div>'),
        // 状态栏，包括进度和控制按钮
        $statusBar = $('<div class="statusBar" style="display:none;"><div class="btns"><div class="filePicker2"></div><div class="uploadBtn">Start Upload</div></div></div>').prepend($info).prepend($progress),
        // 上传按钮
        $upload = $statusBar.find('.uploadBtn'),
        
        // 没选择文件之前的内容。
        $placeHolder = $('<div id="dndArea" class="placeholder"><div class="filePicker">Click to upload images</div><p> the total number of images is no more than 6.</p></div>'),
        
        // 图片容器
        $queue = $('<ul class="filelist"></ul>'),
        $queuelist= $('<div class="queueList"></div>').append($placeHolder).append($queue),
        
        $wrap = $('#uploader_' +id).append($('<p class="title">'+name+'</p>')).append($queuelist).append($statusBar);
        

        // 图片容器
//        $queue = $('<ul class="filelist"></ul>')
//            .appendTo( $wrap.find('.queueList') ),

//        // 状态栏，包括进度和控制按钮
//        $statusBar = $wrap.find('.statusBar'),
//
//        // 文件总体选择信息。
//        $info = $statusBar.find('.info'),

        // 上传按钮
//        $upload = $wrap.find('.uploadBtn'),

//        // 没选择文件之前的内容。
//        $placeHolder = $wrap.find('.placeholder'),
//
//        // 总体进度条
//        $progress = $statusBar.find('.progress').hide(),

        // 添加的文件数量
        var fileCount = 0,

        // 添加的文件总大小
        //fileSize = 0,

        // 优化retina, 在retina下这个值是2
        ratio = window.devicePixelRatio || 1,

        // 缩略图大小
        thumbnailWidth = 110 * ratio,
        thumbnailHeight = 110 * ratio,

        // 可能有pedding, ready, uploading, confirm, done.
        state = 'pedding',

        // 所有文件的进度信息，key为file id
        percentages = {},

        supportTransition = (function(){
            var s = document.createElement('p').style,
                r = 'transition' in s ||
                      'WebkitTransition' in s ||
                      'MozTransition' in s ||
                      'msTransition' in s ||
                      'OTransition' in s;
            s = null;
            return r;
        })();

      

    if ( !WebUploader.Uploader.support() ) {
        alert( 'Web Uploader Your browser is not supported! If you are using IE browser, please try upgrading Flash Player');
        throw new Error( 'WebUploader does not support the browser you are using.' );
    }
    
   
    // 实例化
    uploader[len] = WebUploader.create({
    	id: id,
        pick: {
            id: '#uploader_' + id+ ' .filePicker',
            label: 'Select File'
        },
        dnd: '#uploader_'+id+' .queueList',
        paste:'#uploader_'+id+' .queueList',

        accept: {
            title: 'Images',
            extensions: 'gif,jpg,jpeg,bmp,png',
            mimeTypes: 'image/*'
        },

        // swf文件路径
        swf: '../js/ueditor/third-party/webuploader/uploader.swf',

        disableGlobalDnd: true,

        chunked: true,
        // server: 'http://webuploader.duapp.com/server/fileupload.php',
        server: "../js/ueditor/jsp/imageUp?productId="+productId +'&action=uploadimage',
        fileNumLimit: 6,
        //fileSizeLimit: 6 * 1024 * 1024,    // 200 M
        //fileSingleSizeLimit: 3 * 1024 * 1024    // 3 M
        fileSingleSizeLimit: 4 * 1024 * 100    // 400K
    });

    // 添加“添加文件”的按钮，
    uploader[len].addButton({
        id: '#uploader_' + id+' .filePicker2',
        label: 'Add File'
    });

    
    //回显图片
    if(urllist.length>0){
    	 $placeHolder.addClass( 'element-invisible' );
         $( '.filePicker2' ).removeClass( 'element-invisible');
         $queue.parent().addClass('filled');
         $queue.show();
         $statusBar.removeClass('element-invisible');
         $statusBar.show();
         uploader[len].refresh();
         
         for(var i in urllist){
        	 var $li = $( '<li>' +
                     '<p class="imgWrap"><img src="'+urllist[i]+'"><input type="hidden" name="imgUrl" value="'+id+'_'+urllist[i]+'"></p>'+
                     '</li>' ),

                 $btns = $('<div class="file-panel">' +
                     '<span class="cancel">Delete</span>' +
//                     '<span class="rotateRight">向右旋转</span>' +
//                     '<span class="rotateLeft">向左旋转</span>'+
                     '</div>').appendTo( $li ),
                 $wrap = $li.find( 'p.imgWrap' ),
                 $info = $('<p class="error"></p>');
        	 //var img = $('<img src="'+urllist[i]+'">');
             //$wrap.empty().append( img );
             
             $li.append( '<span class="success"></span>' );
             
             
             $li.appendTo( $queue );
         }
         
         $queue.find("li").on( 'mouseenter', function() {
             $(this).find(".file-panel").stop().animate({height: 30});
         });

         $queue.find("li").on( 'mouseleave', function() {
        	 $(this).find(".file-panel").stop().animate({height: 0});
         });

         $queue.on( 'click', '.file-panel span', function() {
             var index = $(this).index(),
                 deg;

             switch ( index ) {
                 case 0:
                     $(this).closest("li").remove()
                	 //uploader[len].removeFile( file );
                     return;

//                 case 1:
//                     file.rotation += 90;
//                     break;
 //
//                 case 2:
//                     file.rotation -= 90;
//                     break;
             }

             if ( supportTransition ) {
                 deg = 'rotate(' + file.rotation + 'deg)';
                 $wrap.css({
                     '-webkit-transform': deg,
                     '-mos-transform': deg,
                     '-o-transform': deg,
                     'transform': deg
                 });
             } else {
                 $wrap.css( 'filter', 'progid:DXImageTransform.Microsoft.BasicImage(rotation='+ (~~((file.rotation/90)%4 + 4)%4) +')');
             }
         });
    }
    
    // 当有文件添加进来时执行，负责view的创建
    function addFile( file ) {
        var $li = $( '<li id="' + file.id + '">' +
                '<p class="title">' + file.name + '</p>' +
                '<p class="imgWrap"></p>'+
                '<p class="progress"><span></span></p>' +
                '</li>' ),

            $btns = $('<div class="file-panel">' +
                '<span class="cancel">Delete</span>' +
//                '<span class="rotateRight">向右旋转</span>' +
//                '<span class="rotateLeft">向左旋转</span>'+
                '</div>').appendTo( $li ),
            $prgress = $li.find('p.progress span'),
            $wrap = $li.find( 'p.imgWrap' ),
            $info = $('<p class="error"></p>'),

            showError = function( code ) {
                switch( code ) {
                    case 'exceed_size':
                        text = 'The file size is beyond';
                        break;

                    case 'interrupt':
                        text = 'Upload to suspend';
                        break;

                    default:
                        text = 'Upload failed, please try again';
                        break;
                }

                $info.text( text ).appendTo( $li );
            };

        if ( file.getStatus() === 'invalid' ) {
            showError( file.statusText );
        } else {
            // @todo lazyload
            $wrap.text( 'In the preview' );
            uploader[len].makeThumb( file, function( error, src ) {
                if ( error ) {
                    $wrap.text( 'Cannot preview' );
                    return;
                }

                var img = $('<img src="'+src+'">');
                $wrap.empty().append( img );
            }, thumbnailWidth, thumbnailHeight );

            percentages[ file.id ] = [ file.size, 0 ];
            file.rotation = 0;
        }

        file.on('statuschange', function( cur, prev ) {
            if ( prev === 'progress' ) {
                $prgress.hide().width(0);
            } else if ( prev === 'queued' ) {
                //$li.off( 'mouseenter mouseleave' );
                //$btns.remove();
            }

            // 成功
            if ( cur === 'error' || cur === 'invalid' ) {
                console.log( file.statusText );
                showError( file.statusText );
                percentages[ file.id ][ 1 ] = 1;
            } else if ( cur === 'interrupt' ) {
                showError( 'interrupt' );
            } else if ( cur === 'queued' ) {
                percentages[ file.id ][ 1 ] = 0;
            } else if ( cur === 'progress' ) {
                $info.remove();
                $prgress.css('display', 'block');
            } else if ( cur === 'complete' ) {
                $li.append( '<span class="success"></span>' );
            }

            $li.removeClass( 'state-' + prev ).addClass( 'state-' + cur );
        });

        $li.on( 'mouseenter', function() {
            $btns.stop().animate({height: 30});
        });

        $li.on( 'mouseleave', function() {
            $btns.stop().animate({height: 0});
        });

        $btns.on( 'click', 'span', function() {
            var index = $(this).index(),
                deg;

            switch ( index ) {
                case 0:
                    uploader[len].removeFile( file );
                    return;

//                case 1:
//                    file.rotation += 90;
//                    break;
//
//                case 2:
//                    file.rotation -= 90;
//                    break;
            }

            if ( supportTransition ) {
                deg = 'rotate(' + file.rotation + 'deg)';
                $wrap.css({
                    '-webkit-transform': deg,
                    '-mos-transform': deg,
                    '-o-transform': deg,
                    'transform': deg
                });
            } else {
                $wrap.css( 'filter', 'progid:DXImageTransform.Microsoft.BasicImage(rotation='+ (~~((file.rotation/90)%4 + 4)%4) +')');
                // use jquery animate to rotation
                // $({
                //     rotation: rotation
                // }).animate({
                //     rotation: file.rotation
                // }, {
                //     easing: 'linear',
                //     step: function( now ) {
                //         now = now * Math.PI / 180;

                //         var cos = Math.cos( now ),
                //             sin = Math.sin( now );

                //         $wrap.css( 'filter', "progid:DXImageTransform.Microsoft.Matrix(M11=" + cos + ",M12=" + (-sin) + ",M21=" + sin + ",M22=" + cos + ",SizingMethod='auto expand')");
                //     }
                // });
            }


        });

        $li.appendTo( $queue );
    }

    // 负责view的销毁
    function removeFile( file ) {
        var $li = $('#'+file.id);

        delete percentages[ file.id ];
        updateTotalProgress();
        $li.off().find('.file-panel').off().end().remove();
    }

    function updateTotalProgress() {
        var loaded = 0,
            total = 0,
            spans = $progress.children(),
            percent;

        $.each( percentages, function( k, v ) {
            total += v[ 0 ];
            loaded += v[ 0 ] * v[ 1 ];
        } );

        percent = total ? loaded / total : 0;

        spans.eq( 0 ).text( Math.round( percent * 100 ) + '%' );
        spans.eq( 1 ).css( 'width', Math.round( percent * 100 ) + '%' );
        updateStatus();
    }

    function updateStatus() {
        var text = '', stats;

        if ( state === 'ready' ) {
//            text = '选中' + fileCount + '张图片，共' +
//                    WebUploader.formatSize( fileSize ) + '。';
        } else if ( state === 'confirm' ) {
            stats = uploader[len].getStats();
            if ( stats.uploadFailNum ) {
                text = '已成功上传' + stats.successNum+ '张照片至XX相册，'+
                    stats.uploadFailNum + '张照片上传失败，<a class="retry" href="#">重新上传</a>失败图片或<a class="ignore" href="#">忽略</a>'
            }

        } else {
            stats = uploader[len].getStats();
//            text = '共' + fileCount + '张（' +
//                    WebUploader.formatSize( fileSize )  +
//                    '），已上传' + stats.successNum + '张';

            if ( stats.uploadFailNum ) {
               // text += '，失败' + stats.uploadFailNum + '张';
                text = '失败' + stats.uploadFailNum + '张';
            }
        }

        $info.html( text );
    }

    function setState( val ) {
        var file, stats;

        if ( val === state ) {
            return;
        }

        $upload.removeClass( 'state-' + state );
        $upload.addClass( 'state-' + val );
        state = val;

        switch ( state ) {
            case 'pedding':
                $placeHolder.removeClass( 'element-invisible' );
                $queue.parent().removeClass('filled');
                $queue.hide();
                $statusBar.addClass( 'element-invisible' );
                uploader[len].refresh();
                break;

            case 'ready':
                $placeHolder.addClass( 'element-invisible' );
                $( '.filePicker2' ).removeClass( 'element-invisible');
                $queue.parent().addClass('filled');
                $queue.show();
                $statusBar.removeClass('element-invisible');
                uploader[len].refresh();
                break;

            case 'uploading':
                //$( '#filePicker2' ).addClass( 'element-invisible' );
                $progress.show();
                $upload.text( 'Pause' );
                break;

            case 'paused':
                $progress.show();
                $upload.text( 'Continue' );
                break;

            case 'confirm':
                $progress.hide();
                //$upload.text( '开始上传' ).addClass( 'disabled' );
                $upload.text( 'Start' );
                stats = uploader[len].getStats();
                if ( stats.successNum && !stats.uploadFailNum ) {
                    setState( 'finish' );
                    return;
                }
                break;
            case 'finish':
                stats = uploader[len].getStats();
                if ( stats.successNum ) {
                    //alert( '上传成功' );
                } else {
                    // 没有成功的图片，重设
                    state = 'done';
                    location.reload();
                }
                break;
        }

        updateStatus();
    }

//    uploader[len].on( 'beforeFileQueued', function( file ) {
//    	var count = $(uploader[len].options.dnd).find("li").length;
//    	var max = uploader[len].options.fileNumLimit;
//                  if ( count >= max) {
//                      //flag = false;
//                      alert( '超出最大数量限制'); 
//                  }
//       return true;
//         //return count >= max ? false : true;
//     });
    	
    uploader[len].onUploadProgress = function( file, percentage ) {
        var $li = $('#'+file.id),
            $percent = $li.find('.progress span');

        $percent.css( 'width', percentage * 100 + '%' );
        percentages[ file.id ][ 1 ] = percentage;
        updateTotalProgress();
    };

    uploader[len].onFileQueued = function( file ) {
        fileCount++;
        //fileSize += file.size;

        if ( fileCount === 1 ) {
            $placeHolder.addClass( 'element-invisible' );
            $statusBar.show();
        }

        addFile( file );
        setState( 'ready' );
        updateTotalProgress();
    };
    
    

    uploader[len].onFileDequeued = function( file ) {
        fileCount--;
        //fileSize -= file.size;

        if ( !fileCount ) {
            setState( 'pedding' );
        }

        removeFile( file );
        updateTotalProgress();

    };

    uploader[len].on( 'uploadSuccess', function( file,response ) {
        //$( '#'+file.id ).find('p.state').text('已上传');
    	var url = response.url;
    	//var id = file.id;
    	//var hidden = $('<input type="hidden" value="00_'+url+'" name="imgUrl">')
    	$( '#'+file.id ).find(".imgWrap").append($('<input type="hidden" value="'+id+'_'+url+'" name="imgUrl">'));
    	
    });
    
    uploader[len].on( 'all', function( type ) {
        var stats;
        switch( type ) {
            case 'uploadFinished':
                setState( 'confirm' );
                break;

            case 'startUpload':
                setState( 'uploading' );
                break;

            case 'stopUpload':
                setState( 'paused' );
                break;

        }
    });

    uploader[len].onError = function( code ) {
        alert( 'Eroor: ' + code );
    };

    $upload.on('click', function() {
        if ( $(this).hasClass( 'disabled' ) ) {
            return false;
        }

        if ( state === 'ready' ) {
            uploader[len].upload();
        } else if ( state === 'paused' ) {
            uploader[len].upload();
        } else if ( state === 'uploading' ) {
            uploader[len].stop();
        }
    });

    $info.on( 'click', '.retry', function() {
        uploader[len].retry();
    } );

    $info.on( 'click', '.ignore', function() {
        alert( 'todo' );
    } );

    $upload.addClass( 'state-' + state );
    updateTotalProgress();
    }    
        
//});