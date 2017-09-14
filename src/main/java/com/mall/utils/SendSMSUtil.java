package com.mall.utils;

import com.mall.sendMessage.SendSMS;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

/**
 * 发送验证码工具类
 *
 * @author dell003
 */
public class SendSMSUtil {

    /**
     * slf4j log4j
     */
    private static Logger logger = LoggerFactory.getLogger(SendSMSUtil.class);

    /**
     * 发送验证码
     *
     * @param mobile 手机号 多个之间用(英文逗号 ',') 隔开
     * @return randNum 六位验证码
     */
    public final static Integer sendMessage(final String mobile) {
        final int randNum = generateCaptcha();
        String content = "三千万商城提示您，您的验证码是：" + randNum + "。验证码1分钟有效，超时请重新获取。";
        SendSMS.send("d5g6mvjqsm", content, mobile, "1");
        return randNum;

    }

    /**
     * 生成验证码
     *
     * @return
     */
    private synchronized static int generateCaptcha() {
        return new Random().nextInt(899999) + 100000;
    }

    /**
     * 获取当前时间的时间戳串
     *
     * @param (format)
     * @return String Timestamp
     */
    public static String getNowStamp() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        return sdf.format(new Date());
    }
}
