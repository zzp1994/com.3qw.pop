package com.mall.controller.user;

import com.alibaba.fastjson.JSON;
import com.google.code.kaptcha.Producer;
import com.mall.architect.logging.Log;
import com.mall.architect.logging.LogFactory;
import com.mall.controller.base.BaseController;
import com.mall.customer.model.User;
import com.mall.customer.model.VirementSetting;
import com.mall.customer.service.SqwAccountRecordService;
import com.mall.customer.service.UserService;
import com.mall.customer.service.VirementSettingService;
import com.mall.supplier.model.Supplier;
import com.mall.supplier.model.SupplierUser;
import com.mall.supplier.service.SupplierManagerService;
import com.mall.utils.MD5;
import com.mall.utils.SendSMSUtil;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.awt.image.BufferedImage;
import java.math.BigDecimal;

/**
 * 企业转企业个人红旗券
 *
 * @author xusq
 */
@Controller
@RequestMapping(value = "/company")
public class CompanyVirementSettingController extends BaseController {

    private static final Log LOGGER = LogFactory.getLogger(CompanyVirementSettingController.class);

    @Autowired
    private UserService userService;

    @Autowired
    private SqwAccountRecordService sqwAccountRecordService;

    @Autowired
    private VirementSettingService virementSettingService;

    @Autowired
    private SupplierManagerService supplierManagerService;

    @Autowired
    private Producer captchaProducer = null;

    private static final String COMPANY_VIREMENT_VALIDATE_CODE = "com.mall.controller.user.company.virement."; // 发送验证码
    private static final String COMPANY_VIREMENT_SEND_MESSAGE = "com.mall.controller.user.company.virement.message."; // 发送验证码
    private static final int COMPANY_VIREMENT_VALIDATE_CODE_EXPIRY = 59 * 1 * 1000;
    private static final int COMPANY_VIREMENT_SEND_MESSAGE_EXPIRY = 59 * 1 * 1000;

    /** virement setting -------------------------------------------------- */

    /**
     * @Description:验证码.
     */
    @RequestMapping("/validateCode")
    public void validateCode(HttpServletRequest request, HttpServletResponse response, String phone) {
        response.setContentType("image/jpeg");
        String capText = captchaProducer.createText();
        try {
            String memcachedKey = COMPANY_VIREMENT_VALIDATE_CODE + phone;
            memcachedClient.set(memcachedKey,
                    COMPANY_VIREMENT_VALIDATE_CODE_EXPIRY,
                    capText);
            BufferedImage bi = captchaProducer.createImage(capText);
            ServletOutputStream out = response.getOutputStream();
            ImageIO.write(bi, "jpg", out);
            try {
                out.flush();
            } finally {
                out.close();
            }
        } catch (Exception e) {
            LOGGER.error("生成验证码失败！", e);
        }
    }

    /**
     * 通过唯一的uid获取对应服务端缓存中的验证码
     *
     * @return String
     */
    @RequestMapping(value = "/getValidateCode", method = RequestMethod.POST)
    @ResponseBody
    public String getValidateCode(HttpServletRequest request, String phone) {
        String result = "";
        try {
            String memcachedKey = COMPANY_VIREMENT_VALIDATE_CODE + phone;
            result = memcachedClient.get(memcachedKey);
            LOGGER.info("Company Virement auth_Code = " + result);
        } catch (Exception e) {
            LOGGER.error("找回密码验证码验证时异常" + e.getMessage(), e);
        }
        return StringUtils.isEmpty(result) ? "__" : result;
    }

    /**
     * 转账设置跳转
     *
     * @return ModelAndView
     */
    @RequestMapping(value = "/virementSetting", method = RequestMethod.GET)
    public ModelAndView virementSetting(String virementCode) {
        /**
         * code
         * 0. 正确
         * 1. 输入信息有误,可以操作
         * 2. 信息不正确,不能操作
         * 3. 转账超过限制,不能操作
         * 4. 系统忙
         */
        SupplierUser supplierUser = getCurrentUser();
        Long supplierId = supplierUser.getSupplierId();
        Supplier supplier = getSupplier();

        ModelAndView mav = new ModelAndView();
        mav.setViewName("zh/product/companyVirement");
        if (StringUtils.isNotEmpty(virementCode) && virementCode.equals("0")) {
            mav.addObject("code", virementCode);
            mav.addObject("message", "转账成功!");
        }

        // check company id
        if (null == supplierId || supplierId == 0) {
            mav.addObject("massage", "企业信息不存在,请重新登录!");
            mav.addObject("code", "2");
            return mav;
        }
        
        if(supplier.getOrganizationType()!=null && supplier.getOrganizationType()==5){
        	User user2 = userService.findUserById(supplier.getUserId());
        	if (null == user2) {
                mav.addObject("massage", "家庭号个人账号不存在,请绑定后再操作!");
                mav.addObject("code", "2");
                return mav;
            }
            mav.addObject("phone", user2.getMobile());
            mav.addObject("trueName", user2.getRealName());
        	
        }
        if(supplier.getOrganizationType()!=null && supplier.getOrganizationType()==6){
        	User user2 = userService.findUserById(supplier.getUserId());
        	if (null == user2) {
                mav.addObject("massage", "家庭号个人账号不存在,请绑定后再操作!");
                mav.addObject("code", "2");
                return mav;
            }
            mav.addObject("phone", user2.getMobile());
            mav.addObject("trueName", user2.getRealName());
        	
        }
        // check company's user id
        if(supplier.getOrganizationType()==null){
        	User user = userService.findUserBySupplierId(supplierId);
            if (null == user) {
                mav.addObject("massage", "企业个人账号不存在,请绑定后再操作!");
                mav.addObject("code", "2");
                return mav;
            }
            mav.addObject("phone", user.getMobile());
            mav.addObject("trueName", user.getRealName());
        }
        

        // check password
        String payPwd = supplierManagerService.getHqqPayPwd(String.valueOf(supplierId));
        if (null == payPwd || payPwd.isEmpty()) {
            mav.addObject("message", "支付密码为空,请设置后再操作!");
            mav.addObject("code", "2");
            return mav;
        }

        // query virementSetting
        VirementSetting virementSetting = null;
        try {
            virementSetting = virementSettingService.findVirementSetting();
            if (null == virementSetting || virementSetting.getVirementFeeUpperLimitDay() == 0) {
                mav.addObject("massage", "未设置转账上限,请设置后再操作!");
                mav.addObject("code", "2");
                return mav;
            }
        } catch (Exception e) {
            logger.error(" Exception : suppilerId=" + supplierId, e);
            mav.addObject("massage", "系统忙,请稍后再试!");
            return mav;
        }

        // query today transfer account
//        BigDecimal todayTransferAccount = null;
//        try {
//            todayTransferAccount = sqwAccountRecordService.getQiyeHaveTransferDayBalance(supplierId);
//        } catch (Exception e) {
//            logger.error(" Exception : suppilerId=" + supplierId, e);
//            mav.addObject("massage", "系统忙,请稍后再试!");
//            return mav;
//        }

        // check transfer upper limit
//        if (todayTransferAccount.doubleValue() >= virementSetting.getVirementFeeUpperLimitDay()) {
//            mav.addObject("massage", "今日转账数额已经超过限制,请明日再试!");
//            mav.addObject("code", "2");
//            return mav;
//        } else {
        mav.addObject("code", "0");
//            mav.addObject("todayRestAccount", virementSetting.getVirementFeeUpperLimitDay() - todayTransferAccount.doubleValue());
        mav.addObject("todayRestAccount", 0);
        return mav;
//        }
    }

    /**
     * 转账保存
     *
     * @return ModelAndView
     */
    @RequestMapping(value = "/virementSaving", method = RequestMethod.POST)
    public ModelAndView virementSaving(Double virementPrice,
                                       String memo,
                                       String virementPassword,
                                       String authCode) {
        /**
         * code
         * 0. 正确
         * 1. 输入信息有误,可以操作
         * 2. 信息不正确,不能操作
         * 3. 转账超过限制,不能操作
         * 4. 系统忙
         */
        ModelAndView mav = new ModelAndView();
        mav.setViewName("zh/product/companyVirement");

        SupplierUser supplierUser = getCurrentUser();
        Long supplierId = supplierUser.getSupplierId();
        Supplier supplier = getSupplier();
        
        User user = null;
        User user2=null;
        User user3=null;
        
        if(supplier.getOrganizationType()==null){
        	user = userService.findUserBySupplierId(supplierId);
        	 // check company's user id
           
        	if (null == user) {
                mav.addObject("massage", "企业个人账号不存在,请绑定后再操作!");
                mav.addObject("code", "2");
                return mav;
            }
        	mav.addObject("phone", user.getMobile());
            mav.addObject("trueName", user.getRealName());
        	
        }
        if(supplier.getOrganizationType()!=null && supplier.getOrganizationType()==5){
        	user2 = userService.findUserById(supplier.getUserId());
        	
        	if (null == user2) {
                mav.addObject("massage", "企业个人账号不存在,请绑定后再操作!");
                mav.addObject("code", "2");
                return mav;
            }
        	mav.addObject("phone", user2.getMobile());
            mav.addObject("trueName", user2.getRealName());
        }
        if(supplier.getOrganizationType()!=null && supplier.getOrganizationType()==6){
        	user3 = userService.findUserById(supplier.getUserId());
        	
        	if (null == user3) {
                mav.addObject("massage", "企业个人账号不存在,请绑定后再操作!");
                mav.addObject("code", "2");
                return mav;
            }
        	mav.addObject("phone", user3.getMobile());
            mav.addObject("trueName", user3.getRealName());
        }
        
        

        // check price
        if (virementPrice <= 0 || virementPrice > Integer.MAX_VALUE) {
            mav.addObject("message", "转账红旗券, 请输入正确红旗券!");
            mav.addObject("code", "1");
            return mav;
        }

        // 查询红旗券 余额
        BigDecimal hqjBalance = null;
        try {
            hqjBalance = sqwAccountRecordService.getQiyeAccountRecordBalance(supplierId, 1);
        } catch (Exception e) {
            LOGGER.error(" Error: uesr_id=" + user.getUserId(), e);
            mav.addObject("message", "系统错误!");
            mav.addObject("code", "1");
            return mav;
        }

        // 验证红旗券额度 与 转账费用之间的关系
        if (virementPrice > hqjBalance.doubleValue()) {
            mav.addObject("message", "您的红旗券额度不足!");
            mav.addObject("code", "1");
            return mav;
        }

//        // 查询转账限制
//        VirementSetting virementSetting = null;
//        try {
//            virementSetting = virementSettingService.findVirementSetting();
//        } catch (Exception e) {
//            LOGGER.error(" Error: uesr_id=" + user.getUserId(), e);
//            mav.addObject("message", "系统错误!");
//            mav.addObject("code", "1");
//            return mav;
//        }
//
//        // 验证单笔转账 限制
//        if (virementPrice > virementSetting.getVirementFeeUpperLimitDeal()) {
//            mav.addObject("message", "红旗券单笔转账不能超过" + virementSetting.getVirementFeeUpperLimitDeal() + ",请重新设置!");
//            mav.addObject("code", "2");
//            return mav;
//        }

        // check password
        String payPwd = supplierManagerService.getHqqPayPwd(String.valueOf(supplierId));
        if (null == payPwd || payPwd.isEmpty()) {
            mav.addObject("message", "支付密码为空,请设置后再操作!");
            mav.addObject("code", "2");
            return mav;
        }

        String pwdMd5 = MD5.encrypt(virementPassword);
        if (!payPwd.equalsIgnoreCase(pwdMd5)) {
            mav.addObject("code", -1);
            mav.addObject("message", "支付密码不正确,请重新输入!");
            mav.addObject("code", "1");
            return mav;
        }

        String msg = null;
        try {
        	int transferStatus=0;
        	if(supplier.getOrganizationType()==null){
        		transferStatus = sqwAccountRecordService.transferAccountFromQiyeToUser(
                        supplierId,
                        user.getUserId(),
                        new BigDecimal(virementPrice),
                        new Integer(1),
                        memo,
                        String.valueOf(System.currentTimeMillis()));
        		
        	}
        	if(supplier.getOrganizationType()!=null && supplier.getOrganizationType()==5){
        		transferStatus = sqwAccountRecordService.transferAccountFromQiyeToUser(
                        supplierId,
                        user2.getUserId(),
                        new BigDecimal(virementPrice),
                        new Integer(1),
                        memo,
                        String.valueOf(System.currentTimeMillis()));
        		
        	}
        	if(supplier.getOrganizationType()!=null && supplier.getOrganizationType()==6){
        		transferStatus = sqwAccountRecordService.transferAccountFromQiyeToUser(
                        supplierId,
                        user3.getUserId(),
                        new BigDecimal(virementPrice),
                        new Integer(1),
                        memo,
                        String.valueOf(System.currentTimeMillis()));
        		
        	}
        	 switch (transferStatus) {
             case 0:
                 mav.clear();
                 mav.setViewName("redirect:/company/virementSetting?virementCode=0");
                 mav.addObject("code", "0");
                 break;
             case 1:
                 mav.addObject("massage", "转账红旗券, 请输入正确红旗券!");
                 mav.addObject("code", "1");
                 break;
             case 2:
                 mav.addObject("massage", "您的账户红旗券余额不足，无法支付转账手续费，请您重新操作!");
                 mav.addObject("code", "1");
                 break;
             case 5:
                 mav.addObject("massage", "转账红旗券, 超过单笔限额!");
                 mav.addObject("code", "1");
                 break;
             case 6:
                 mav.addObject("massage", "转账红旗券,超过当前转账限额!");
                 mav.addObject("code", "1");
                 break;
             case 7:
                 mav.addObject("massage", "企业账户不存在!");
                 mav.addObject("code", "2");
                 break;
             default:
                 mav.addObject("massage", "系统忙,请稍后再试!");
                 mav.addObject("code", "1");
         }
            
            
           
        } catch (Exception e) {
            logger.error(" Exception : suppilerId=" + supplierId, e);
            msg = "系统忙,请稍后再试!";
        }
        return mav;
    }

    /** forget password -------------------------------------------------- */
    /**
     * 忘记密码 跳转
     *
     * @return ModelAndView
     */
    @RequestMapping(value = "/forgotVirementPassword", method = RequestMethod.GET)
    public ModelAndView forgotVirementPassword(String code) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("zh/product/forgetVirementPassword");
        if (StringUtils.isNotEmpty(code) && code.equals("0")) {
            mav.addObject("code", code);
            mav.addObject("message", "密码修改成功!");
        }

        // check company's user id
        User user = userService.findUserBySupplierId(getCurrentUser().getSupplierId());
       
       
        Supplier supplier = getSupplier();
        
       
        if(supplier.getOrganizationType()!=null && supplier.getOrganizationType()==5){
        	 User user2 = userService.findUserById(supplier.getUserId());
        	if (null == user2) {
                mav.addObject("massage", "家庭号个人账号不存在,请绑定后再操作!");
                mav.addObject("code", "2");
                return mav;
            }
            mav.addObject("phone", user2.getMobile());
            mav.addObject("trueName", user2.getRealName());
        	
        }
        if(supplier.getOrganizationType()!=null && supplier.getOrganizationType()==6){
       	 User user2 = userService.findUserById(supplier.getUserId());
       	if (null == user2) {
               mav.addObject("massage", "家庭号个人账号不存在,请绑定后再操作!");
               mav.addObject("code", "2");
               return mav;
           }
           mav.addObject("phone", user2.getMobile());
           mav.addObject("trueName", user2.getRealName());
       	
       }
        if(supplier.getOrganizationType()==null){
        	 if (null == user) {
                 mav.addObject("massage", "企业个人账号不存在,请绑定后再操作!");
                 return mav;
             }
        	   mav.addObject("phone", user.getMobile());
               mav.addObject("trueName", user.getRealName());
              
        }
        return mav;
    }

    /**
     * 保存密码
     *
     * @return ModelAndView
     */
    @RequestMapping(value = "/savingVirementPassword", method = RequestMethod.POST)
    public ModelAndView savingVirementPassword(String newPassword,
                                               String newPasswordCfm,
                                               String authCode,
                                               RedirectAttributesModelMap modelMap) {

        ModelAndView mav = new ModelAndView();
        mav.setViewName("zh/product/forgetVirementPassword");
        mav.addObject("code", "-1");
        String msg = null;

        SupplierUser supplierUser = getCurrentUser();
        Long supplierId = supplierUser.getSupplierId();
        Supplier supplier = getSupplier();
        

        if(supplier.getOrganizationType()==null){
        	// check company's user id
            User user = userService.findUserBySupplierId(getCurrentUser().getSupplierId());
            if (null == user) {
                mav.addObject("massage", "企业个人账号不存在,请绑定后再操作!");
                return mav;
            }
            mav.addObject("phone", user.getMobile());
            mav.addObject("trueName", user.getRealName());
        	
        }
        
        

        // check password
        if (!newPasswordCfm.equals(newPassword)) {
            msg = "支付密码不相等,请重新输入!";
            mav.addObject("message", msg);
            return mav;
        }

        String newPasswordMd5 = MD5.encrypt(newPassword);
        int status = supplierManagerService.updateHqqPwdBySupplierId(supplierId.toString(), newPasswordMd5);
        switch (status) {
            case 1:
                mav.addObject("message", "密码修改成功!");
                mav.addObject("code", "0");
                break;
            default:
                msg = "密码修改失败!";

        }
        return mav;
    }

    /**
     * 安全码验证
     *
     * @return ModelAndView
     */
    @RequestMapping(value = "/sendSecurityCode", method = RequestMethod.GET)
    @ResponseBody
    public String sendSecurityCode(String phone) {

        // will be modify
        // phone = "13910151440";
        // will be modify

        if (phone == null || "".equals(phone)) {
            return JSON.toJSONString(0);
        }
        String memKey = COMPANY_VIREMENT_SEND_MESSAGE + phone;

//        Integer msgCodeOld = 0;
//        try {
//            msgCodeOld = memcachedClient.get(memKey);
//        } catch (Exception e) {
//            LOGGER.info("memcacheClient get  error" + e, e);
//            return "";
//        }

//        if (null != msgCodeOld) {
//            LOGGER.info("send message too frequent。。");
//            return "2"; // 已经发送过验证码 请勿重复发送
//        }

        Integer msgCodeNew = SendSMSUtil.sendMessage(phone);
        if (msgCodeNew != null) {
            try {
                LOGGER.info("phone :" + phone + "---msgCode:" + msgCodeNew);
                // catch msgCode
                memcachedClient.set(memKey, COMPANY_VIREMENT_SEND_MESSAGE_EXPIRY, msgCodeNew);
            } catch (Exception e) {
                LOGGER.info("send message error...." + phone);
            }
            return "0"; // 发送成功
        }
        return "1"; // 其他错误
    }

    /**
     * 安全码
     *
     * @return ModelAndView
     */
    @RequestMapping(value = "/checkSecurityCode", method = RequestMethod.POST)
    @ResponseBody
    public String checkSecurityCode(String phone, String inputCode) {

        // will be modify
        // phone = "13910151440";
        // will be modify

        Integer msgCode = null;
        String memKey = COMPANY_VIREMENT_SEND_MESSAGE + phone;
        try {
            msgCode = memcachedClient.get(memKey);
        } catch (Exception e) {
            LOGGER.info("memcache running error.." + e, e);
            return "1";
        }

        // 比对传入的验证码和缓存中的验证码是否一致
        if (!String.valueOf(msgCode).equals(inputCode)) {
            try {
                memcachedClient.delete(memKey);
            } catch (Exception e) {
                e.printStackTrace();
                return "1";
            }
            return "2";
        }

        // 校验成功
        try {
            memcachedClient.delete(memKey);
        } catch (Exception e) {
            LOGGER.error("memcache running error...." + e, e);
            return "1";
        }

        LOGGER.info("校验成功  mobile :" + phone);
        return "0";
    }
}
