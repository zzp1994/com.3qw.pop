package com.mall.utils;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.IOException;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.log4j.Logger;
import org.csource.upload.UploadFileUtil;
import org.jbarcode.JBarcode;
import org.jbarcode.encode.Code128Encoder;
import org.jbarcode.encode.InvalidAtributeException;
import org.jbarcode.paint.BaseLineTextPainter;
import org.jbarcode.paint.WidthCodedPainter;
import org.jbarcode.util.ImageUtil;

public class JBarCodeUtil {

	
	private static Logger logger= Logger.getLogger(JBarCodeUtil.class);	
	 private static final int SUFFIXLEN = 5;

	    private JBarCodeUtil() {

	    }
	
	/**
	 * 生成随机数
	 * @param length
	 * @return
	 */
	public synchronized static String getCreateRandom() {
        String currentTimeMillisStr = new Long(System.currentTimeMillis()).toString();
        String randomStr = RandomStringUtils.randomNumeric(SUFFIXLEN);

        return "C"+ currentTimeMillisStr + randomStr;
    }
	
	
	/**
	 * 利用jbarCode获取条形码图片
	 * @param barCode
	 * @return
	 */
	public static String getBarCodeUrl(String barCode){
		 JBarcode localJBarcode = new JBarcode(Code128Encoder.getInstance(), WidthCodedPainter.getInstance(), BaseLineTextPainter.getInstance());
	      localJBarcode.setShowCheckDigit(false);
	      BufferedImage localBufferedImage = null;
	      try {
			localBufferedImage = localJBarcode.createBarcode(barCode);
		} catch (InvalidAtributeException e) {
			logger.error("创建条形码图片失败！"+e.getMessage(), e);
		}

	      String url = getUrl(localBufferedImage);
	      
	      return url;
	}
	
	
	/**
	 * 将条形码图片上传至文件服务器
	 * @param localBufferedImage
	 * @return
	 */
	private static String getUrl(BufferedImage localBufferedImage) {
		byte[] encode= null;
	     try {
	    	 encode = ImageUtil.encode(localBufferedImage, "png");
		} catch (IOException e) {
			logger.error("根据条形码生成字节码失败!"+e.getMessage(),e);
		}
	     String barCodeUrl = "";
	     try {
	    	 ByteArrayInputStream inputStream = new ByteArrayInputStream(encode);
	    	 barCodeUrl = UploadFileUtil.uploadFile(inputStream, "jpg", null);
		} catch (Exception e) {
			logger.error("上传条形码至文件服务器失败！"+e.getMessage(),e);
		}
	     return barCodeUrl;
	}
}
