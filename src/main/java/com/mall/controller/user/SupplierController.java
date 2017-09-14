package com.mall.controller.user;

import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.csource.upload.UploadFileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.dubbo.common.utils.StringUtils;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.google.code.kaptcha.Producer;
import com.mall.annotation.Token;
import com.mall.category.po.TcCountry;
import com.mall.category.po.TdCatePub;
import com.mall.controller.base.BaseController;
import com.mall.customer.dto.HomeNumRecordDto;
import com.mall.customer.dto.activity.SupplierNumRecordDto;
import com.mall.customer.model.User;
import com.mall.customer.service.HomeNumRecordService;
import com.mall.customer.service.SupplierNumRecordService;
import com.mall.merchant.proxy.RemoteServiceSingleton;
import com.mall.sendemail.SendHtmlMail;
import com.mall.supplier.model.Supplier;
import com.mall.supplier.model.SupplierPartner;
import com.mall.supplier.model.SupplierProduct;
import com.mall.supplier.model.SupplierRegionSettings;
import com.mall.supplier.model.SupplierUser;
import com.mall.supplier.service.SupplierRegionService;
import com.mall.utils.Common;
import com.mall.utils.Constants;
import com.mall.utils.DES;
import com.mall.utils.MD5;

/**
 * @author wdj
 */
@Controller
@RequestMapping(value="/supplier")
public class SupplierController extends BaseController {
	
	@Autowired  
	private Producer captchaProducer = null;
	
	@Autowired
	private SupplierRegionService regionService;

	@Autowired
	private HomeNumRecordService homeNumRecordService;
	
	@Autowired
	private SupplierNumRecordService supplierNumRecordService;
	
	/**
	 * log.
	 */
	private static final Logger LOGGER = Logger.getLogger(SupplierUserController.class);
	
	
	/**
	 * 跳转注册页面.
	 * @param map map
	 * @return 添加商户
	 */
	@RequestMapping("/registUI")
	public String toRegistUI(Map<String,Object> map,HttpServletRequest request){
		 map.put("template_url", request.getContextPath()+"/supplier/downloadTemp");
		 List<TdCatePub> childrenCategoryList = new ArrayList<TdCatePub>();
		 List<TcCountry> countries = new ArrayList<TcCountry>();
		 if(RemoteServiceSingleton.getInstance().getCategoryServiceRpc()!=null){
             try {
                childrenCategoryList  = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getTopCategoryList();
                countries = RemoteServiceSingleton.getInstance().getBaseDataServiceRpc().getTcCountries();
            } catch (Exception e) {
            	LOGGER.error("获取类目失败！");
            }
         }
		 List<String> categoryNameCn = new ArrayList<String>();
		 List<String> categoryNameEn = new ArrayList<String>();
         if(!childrenCategoryList.isEmpty()){
             for (TdCatePub tdCatePub : childrenCategoryList) {
            	// tdCatePub.
                 categoryNameCn.add(tdCatePub.getPubNameCn());
                 categoryNameEn.add(tdCatePub.getPubName());
             }
         }
         List<String> callingCodeCn=new ArrayList<String>();
         List<String> callingCodeEn=new ArrayList<String>();
         List<String> countryNameEn = new ArrayList<String>();
         List<String> countryNameCn = new ArrayList<String>();
         for (TcCountry country : countries) {
             countryNameCn.add(country.getName());
             countryNameEn.add(country.getDescription());
             callingCodeCn.add(Common.isEmpty(country.getCallingcode())? "":"+"+country.getCallingcode());
        	 callingCodeEn.add(Common.isEmpty(country.getCallingcode())? "":"+"+country.getCallingcode());
        }
         String uid=UUID.randomUUID().toString();
         map.put("uid",uid);
         try {
            memcachedClient.set(uid, 60*60,uid);
        } catch (Exception e) {
        	LOGGER.error("memcachedClient获取uid报错",e);
            e.printStackTrace();
        }
         if("/en".equals(getLanguage())){
             map.put("category", JSONObject.toJSONString(categoryNameEn));
             map.put("country", countryNameEn);
             map.put("callingCode", callingCodeCn); 
         } else {
             map.put("category",JSONObject.toJSONString(categoryNameCn) );
             map.put("country", countryNameCn);
             map.put("callingCode", callingCodeEn); 
         }
		return "/user/regist";
	}
	
	
	/**
	 * 家庭账户注册页面
	 * @param map map
	 * @return 添加商户
	 */
	@RequestMapping("/registUI2")
	public String toRegistUI2(Map<String,Object> map,HttpServletRequest request,long userid){
		/**
		 * 调接口判断用户注册够不够资格
		 */
		 //查询用户是否购买家庭号6.7
        HomeNumRecordDto homeNumRecordDto;
		try {
			homeNumRecordDto = homeNumRecordService.selectRecordByUserid((int) userid);
			Integer jiaTingStatus = homeNumRecordDto.getStatus();
			if(jiaTingStatus==0){
				request.setAttribute("message","您没有资格注册 ");
				return "redirect:http://www.3qianwan.com";
			}
		} catch (Exception e1) {
			
			e1.printStackTrace();
		}
		int i = RemoteServiceSingleton.getInstance().getSupplierManagerService().selectCountUser(userid);
		if(i>=1){
			request.setAttribute("message","不能重复注册！");
			return "/user/login";
			
		}
		 map.put("template_url", request.getContextPath()+"/supplier/downloadTemp");
		 List<TdCatePub> childrenCategoryList = new ArrayList<TdCatePub>();
		 List<TcCountry> countries = new ArrayList<TcCountry>();
		 User user = RemoteServiceSingleton.getInstance().getUserService().findUserById(userid);
		 String mobile = user.getMobile();
		 request.setAttribute("moblie", mobile);
		 if(RemoteServiceSingleton.getInstance().getCategoryServiceRpc()!=null){
             try {
                childrenCategoryList  = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getTopCategoryList();
                countries = RemoteServiceSingleton.getInstance().getBaseDataServiceRpc().getTcCountries();
            } catch (Exception e) {
            	LOGGER.error("获取类目失败！");
            }
         }
		 List<String> categoryNameCn = new ArrayList<String>();
		 List<String> categoryNameEn = new ArrayList<String>();
         if(!childrenCategoryList.isEmpty()){
             for (TdCatePub tdCatePub : childrenCategoryList) {
            	// tdCatePub.
                 categoryNameCn.add(tdCatePub.getPubNameCn());
                 categoryNameEn.add(tdCatePub.getPubName());
             }
         }
         List<String> callingCodeCn=new ArrayList<String>();
         List<String> callingCodeEn=new ArrayList<String>();
         List<String> countryNameEn = new ArrayList<String>();
         List<String> countryNameCn = new ArrayList<String>();
         for (TcCountry country : countries) {
             countryNameCn.add(country.getName());
             countryNameEn.add(country.getDescription());
             callingCodeCn.add(Common.isEmpty(country.getCallingcode())? "":"+"+country.getCallingcode());
        	 callingCodeEn.add(Common.isEmpty(country.getCallingcode())? "":"+"+country.getCallingcode());
        }
         String uid=UUID.randomUUID().toString();
         map.put("uid",uid);
         try {
            memcachedClient.set(uid, 60*60,uid);
        } catch (Exception e) {
        	LOGGER.error("memcachedClient获取uid报错",e);
            e.printStackTrace();
        }
         if("/en".equals(getLanguage())){
             map.put("category", JSONObject.toJSONString(categoryNameEn));
             map.put("country", countryNameEn);
             map.put("callingCode", callingCodeCn); 
         } else {
             map.put("category",JSONObject.toJSONString(categoryNameCn) );
             map.put("country", countryNameCn);
             map.put("callingCode", callingCodeEn); 
             request.setAttribute("userid", userid);
         }
		return "/user/regist2";
	}
	
	
	
	/**
	 * 企业号注册页面
	 */
	@RequestMapping("/registUI3")
	public String toRegistUI3(Map<String,Object> map,HttpServletRequest request,long userid){
		/**
		 * 调接口判断用户注册够不够资格
		 */
		 //查询用户是否购买家庭号6.7
        HomeNumRecordDto homeNumRecordDto;
	/*	try {
			homeNumRecordDto = homeNumRecordService.selectRecordByUserid((int) userid);
			Integer jiaTingStatus = homeNumRecordDto.getStatus();
			if(jiaTingStatus==0){
				request.setAttribute("message","您没有资格注册 ");
				return "redirect:http://www.3qianwan.com";
			}
		} catch (Exception e1) {
			
			e1.printStackTrace();
		}*/
        SupplierNumRecordDto supplierNumRecordDto;
     		try {
     			supplierNumRecordDto = supplierNumRecordService.selectRecordByUserid((int) userid);
     			Integer jiaTingStatus = supplierNumRecordDto.getStatus();
     			if(jiaTingStatus==0){
     				request.setAttribute("message","您没有资格注册 ");
     				return "redirect:http://www.3qianwan.com";
     			}
     		} catch (Exception e1) {
     			
     			e1.printStackTrace();
     		}
		int i = RemoteServiceSingleton.getInstance().getSupplierManagerService().selectCountUser(userid);
		if(i>=1){
			request.setAttribute("message","不能重复注册！");
			return "/user/login";
			
		}
		 map.put("template_url", request.getContextPath()+"/supplier/downloadTemp");
		 List<TdCatePub> childrenCategoryList = new ArrayList<TdCatePub>();
		 List<TcCountry> countries = new ArrayList<TcCountry>();
		 User user = RemoteServiceSingleton.getInstance().getUserService().findUserById(userid);
		 String mobile = user.getMobile();
		 request.setAttribute("moblie", mobile);
		 if(RemoteServiceSingleton.getInstance().getCategoryServiceRpc()!=null){
             try {
                childrenCategoryList  = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getTopCategoryList();
                countries = RemoteServiceSingleton.getInstance().getBaseDataServiceRpc().getTcCountries();
            } catch (Exception e) {
            	LOGGER.error("获取类目失败！");
            }
         }
		 List<String> categoryNameCn = new ArrayList<String>();
		 List<String> categoryNameEn = new ArrayList<String>();
         if(!childrenCategoryList.isEmpty()){
             for (TdCatePub tdCatePub : childrenCategoryList) {
            	// tdCatePub.
                 categoryNameCn.add(tdCatePub.getPubNameCn());
                 categoryNameEn.add(tdCatePub.getPubName());
             }
         }
         List<String> callingCodeCn=new ArrayList<String>();
         List<String> callingCodeEn=new ArrayList<String>();
         List<String> countryNameEn = new ArrayList<String>();
         List<String> countryNameCn = new ArrayList<String>();
         for (TcCountry country : countries) {
             countryNameCn.add(country.getName());
             countryNameEn.add(country.getDescription());
             callingCodeCn.add(Common.isEmpty(country.getCallingcode())? "":"+"+country.getCallingcode());
        	 callingCodeEn.add(Common.isEmpty(country.getCallingcode())? "":"+"+country.getCallingcode());
        }
         String uid=UUID.randomUUID().toString();
         map.put("uid",uid);
         try {
            memcachedClient.set(uid, 60*60,uid);
        } catch (Exception e) {
        	LOGGER.error("memcachedClient获取uid报错",e);
            e.printStackTrace();
        }
         if("/en".equals(getLanguage())){
             map.put("category", JSONObject.toJSONString(categoryNameEn));
             map.put("country", countryNameEn);
             map.put("callingCode", callingCodeCn); 
         } else {
             map.put("category",JSONObject.toJSONString(categoryNameCn) );
             map.put("country", countryNameCn);
             map.put("callingCode", callingCodeEn); 
             request.setAttribute("userid", userid);
         }
		return "/user/regist3";
	}
	
	/** 
	* @Description:添加商户注册.
	* @param myfile MultipartFile
	* @param myfile1 MultipartFile
	* @param map map
	* @param supplier Supplier
	* @param request  HttpServletRequest
	* @return regist_success 
	*/
	@RequestMapping("/regist")
	public String regist(MultipartFile myfile,MultipartFile myfile1,String kaptcha,
			Map<String,Object> map, Supplier supplier,HttpServletRequest request,String uid,String phoneCode,MultipartFile myfile2){
		LOGGER.info("注册：supplier:"+JSON.toJSONString(supplier));
		try {
			String kaptchaExpected = memcachedClient.get(uid+Constants.KAPTCHA_SESSION_KEY);
			if(!kaptcha.toLowerCase().equals(kaptchaExpected.toLowerCase())){
				if(getLanguage().equals("/en")){
	            	request.setAttribute("message","Verification code is wrong！");
	            }else{
	            	request.setAttribute("message","验证码有误！");	
	            } 
				return "/user/regist";
			}
		} catch (Exception e) {
			LOGGER.error("注册：  memcached中取验证码出问题！",e);
		}
		if(null==myfile){ 
            request.setAttribute("isError", 1);
            if(getLanguage().equals("/en")){
            	request.setAttribute("message","Missing Upload Files");
            }else{
            	request.setAttribute("message","缺少需要上传的文件");	
            }
            LOGGER.error("注册：缺少需要上传的文件！");
            return "/user/regist";
        }else{ 
           // System.out.println( Common.getFileExt2(myfile1.getOriginalFilename()));
    		String myfileUrl="";
    		String myfile1Url="";
    		String myfile2Url="";
			try {
				myfileUrl = UploadFileUtil.uploadFile(myfile.getInputStream(),
						Common.getFileExt2(myfile.getOriginalFilename()), null);
				if(null!=myfile1&&!"".equals(Common.getFileExt2(myfile1.getOriginalFilename()))){
					myfile1Url = UploadFileUtil.uploadFile(myfile1.getInputStream(),
							Common.getFileExt2(myfile1.getOriginalFilename()), null);
				}
				if(null!=myfile2&&!"".equals(Common.getFileExt2(myfile2.getOriginalFilename()))){
					myfile2Url = UploadFileUtil.uploadFile(myfile2.getInputStream(),
							Common.getFileExt2(myfile2.getOriginalFilename()), null);
				}
			} catch (Exception e) {
				LOGGER.error("注册：上传文件到图片服务器出错！",e);
			}
        	supplier.setCompanyLegitimacyUrl(myfileUrl);
        	if(null!=myfile1&&!"".equals(Common.getFileExt2(myfile1.getOriginalFilename()))){
        	  supplier.setCompanyDetailedUrl(myfile1Url);
        	}
        	if(null!=myfile2&&!"".equals(Common.getFileExt2(myfile2.getOriginalFilename()))){
        		supplier.setLogoImgurl(myfile2Url);
        	}else{
        		supplier.setLogoImgurl("group1/M00/00/31/CgAAElgxxt-Aa7U1AAAjS6o85T0082.jpg");	//默认图片logo地址
        	}
        } 
	    SupplierUser user=new SupplierUser();
		if(!Common.isEmpty(request.getParameter("loginName"))){
			user.setIsAdmin(1);
			user.setStatus(1);
			user.setLoginName(request.getParameter("loginName"));
			user.setPassword(MD5.encrypt(request.getParameter("password")));
			
			user.setRecordPwd(request.getParameter("password"));	//记录明文，为了unicorn创建账号发送短信用
			
			Map<String, String> pmap = new LinkedHashMap<String, String>();
			int count = 1;
			if (!Common.isEmpty(request.getParameter("loginName"))) {
				pmap.put("loginName", request.getParameter("loginName"));
				count = RemoteServiceSingleton.getInstance().getSupplierUserManagerService()
						.getUserByName(pmap);
			}
			if(count==1){
			   request.setAttribute("isError", 1);
			   if(getLanguage().equals("/en")){
	            	request.setAttribute("message","UserName already exists ");
	            }else{
	            	request.setAttribute("message","用户名已存在");	
	            }
			    LOGGER.error("用户:"+request.getParameter("loginName")+"注册：用户名已存在！");
	            return "/user/regist";
			}
		}
		supplier.setPhone(phoneCode+supplier.getPhone());
		supplier.setStatus(0);
		supplier.setCreateTime(new Date());
	//	supplier.setName(request.getParameter("companyName"));
		supplier.setName(request.getParameter("companyName"));
		supplier.setFax(request.getParameter("fax"));
		if(Common.isEmpty(request.getParameter("post"))){
			supplier.setPost( Common.stringToInteger(request.getParameter("post")));
		}
		//设置pop用户为51
		supplier.setSupplyType(51);
		supplier.setType(-1);	//注册的时候默认给-1值
		supplier.setHqqPwd(MD5.encrypt(supplier.getHqqPwd()));		//红旗券支付密码
		supplier.setActiveStatus(-1);	//该企业注册未激活置为-1
		LOGGER.info("pop user regist set supplyType 51 "+user.getLoginName());
		
		User tjUser = null;
		Supplier sjSupplier = null;
		if(StringUtils.isEmpty(supplier.getSjSupplierId())){		//如果上级企业代码为空 置为邀请码用户里的supplierId
			/*tjUser = RemoteServiceSingleton.getInstance().getUserService().findUserByMobile(supplier.getUserTj());
			if(tjUser != null && StringUtils.isNotEmpty(tjUser.getSupplierId())){
				Supplier tjSupplier = RemoteServiceSingleton.getInstance().getSupplierManagerService()
						.findSupplier(Long.valueOf(tjUser.getSupplierId()));
				if(tjSupplier != null && tjSupplier.getType() == 1){		//属于子公司
					supplier.setSjSupplierId(tjSupplier.getSupplierId()+"");
				}else{
					Supplier defaultSupplier = RemoteServiceSingleton.getInstance().getSupplierManagerService()
							.getSupplierBySupplierCode("SQ69");
					if(defaultSupplier != null){
						supplier.setSjSupplierId(defaultSupplier.getSupplierId()+"");
					}
				}
			}else{
				Supplier defaultSupplier = RemoteServiceSingleton.getInstance().getSupplierManagerService()
						.getSupplierBySupplierCode("SQ69");
				if(defaultSupplier != null){
					supplier.setSjSupplierId(defaultSupplier.getSupplierId()+"");
				}
			}*/
		}else{		//不为空根据企业代码获取相对应的supplierId
			sjSupplier = RemoteServiceSingleton.getInstance().getSupplierManagerService()
					.getSupplierBySupplierCode(supplier.getSjSupplierId());
			if(sjSupplier != null){
				supplier.setSjSupplierId(sjSupplier.getSupplierId()+"");
			}
		}
/*		if(StringUtils.isEmpty(supplier.getSjSupplierId())){		//如果上级企业代码为空 置为邀请码用户里的supplierId
			tjUser = RemoteServiceSingleton.getInstance().getUserService().findUserByMobile(supplier.getUserTj());
			if(tjUser != null){
				supplier.setSjSupplierId(tjUser.getSupplierId());
			}
		}else{		//不为空根据企业代码获取相对应的supplierId
			sjSupplier = RemoteServiceSingleton.getInstance().getSupplierManagerService()
					.getSupplierBySupplierCode(supplier.getSjSupplierId());
			if(sjSupplier != null){
				supplier.setSjSupplierId(sjSupplier.getSupplierId()+"");
			}
		}*/
		Long  supplierId = RemoteServiceSingleton.getInstance().getSupplierManagerService().insert(supplier);
		
		SupplierProduct product=new SupplierProduct();
		getObjectFromRequest(product,request);
		SupplierPartner partner=new SupplierPartner();
		partner.setName(request.getParameter("p_companyName"));
		partner.setAddress(request.getParameter("p_companyName"));
		partner.setContact(request.getParameter("p_companyContact"));
		partner.setEmail(request.getParameter("p_companyMail"));
		partner.setTelephone(request.getParameter("p_companyTel"));
		RemoteServiceSingleton.getInstance().getSupplierManagerService().register(supplierId, user, product, partner);
		request.setAttribute("name", user.getLoginName());
		String name="";
		try {
			name =DES.encrypt(user.getLoginName(), Constants.CCIGMALL);
		} catch (Exception e) {
			LOGGER.error("注册：用户名回传成功页面出错!用户名："+user.getLoginName(),e);
		}
		//request.setAttribute("language",getLanguage().substring(1));
		LOGGER.info("注册成功：用户名："+user.getLoginName());
		return "redirect:/supplier/regist_success?sid="+name;
	}

	
	
	
	
	
	/** 
	* @Description:家庭号商户注册
	* @param myfile MultipartFile
	* @param myfile1 MultipartFile
	* @param map map
	* @param supplier Supplier
	* @param request  HttpServletRequest
	* @return regist_success 
	*/
	@RequestMapping("/regist2")
	public String regist2(String kaptcha,
			Map<String,Object> map, Supplier supplier,HttpServletRequest request,String uid,String phoneCode){
		int i = RemoteServiceSingleton.getInstance().getSupplierManagerService().selectCountUser(supplier.getUserId());
		if(i>=1){
			request.setAttribute("message","不能重复注册！");
			return "/user/regist2";
			
		}
		String mobile = request.getParameter("phone");
		String msgReqCode = request.getParameter("verificationCode");
		LOGGER.info("注册：supplier:"+JSON.toJSONString(supplier));
		try {
			String kaptchaExpected = memcachedClient.get(uid+Constants.KAPTCHA_SESSION_KEY);
			if(!kaptcha.toLowerCase().equals(kaptchaExpected.toLowerCase())){
				if(getLanguage().equals("/en")){
	            	request.setAttribute("message","Verification code is wrong！");
	            }else{
	            	request.setAttribute("message","验证码有误！");	
	            } 
				return "/user/regist2";
			}
			
			
			if (msgReqCode == null || "".equals(msgReqCode)) {
				logger.info("bad request msgReqCode....");
				request.setAttribute("message","请填写验证码！");
				return "/user/regist2";
			}
		
			
		} catch (Exception e) {
			LOGGER.error("注册：  memcached中取验证码出问题！",e);
		}
		Integer msgCode = null;
		String memMobile = null;
		try {
			msgCode = memcachedClient.get(Constants.SEND_REG_MESSAGE + mobile);
					
			memMobile = memcachedClient.get(Constants.SEND_REG_MESSAGE + mobile + "mobile");
			
					
		} catch (Exception e) {
			logger.info("memcache running error.." + e, e);
			
		}
		if (msgCode == null && msgReqCode!=(msgCode + "")) {
			// 校验成功
			try {
				memcachedClient.delete(Constants.SEND_REG_MESSAGE + mobile);
				memcachedClient.delete(Constants.SEND_REG_MESSAGE + mobile + "mobile");
				
				memcachedClient.setOpTimeout(5000L);
				
			} catch (Exception e) {
				logger.error("memcache running error...." + e, e);
			
			}
			request.setAttribute("message","您填写的手机接收验证码有误");
			return "/user/regist2";
		}
		
		/**
		 * 调接口判断用户注册够不够资格
		 */
		 //查询用户是否购买家庭号6.7
        HomeNumRecordDto homeNumRecordDto;
		try {
			homeNumRecordDto = homeNumRecordService.selectRecordByUserid((supplier.getUserId()).intValue());
			Integer jiaTingStatus = homeNumRecordDto.getStatus();
			if(jiaTingStatus==0){
				request.setAttribute("message","您没有资格注册 ");
				return "/user/regist2";
			}
		} catch (Exception e1) {
			
			e1.printStackTrace();
		}
        
		
		
	    SupplierUser user=new SupplierUser();
		if(!Common.isEmpty(request.getParameter("loginName"))){
			user.setIsAdmin(1);
			user.setStatus(1);
			user.setLoginName(request.getParameter("loginName"));
			user.setPassword(MD5.encrypt(request.getParameter("password")));
			
			user.setRecordPwd(request.getParameter("password"));	//记录明文，为了unicorn创建账号发送短信用
			
			Map<String, String> pmap = new LinkedHashMap<String, String>();
			int count = 1;
			if (!Common.isEmpty(request.getParameter("loginName"))) {
				pmap.put("loginName", request.getParameter("loginName"));
				count = RemoteServiceSingleton.getInstance().getSupplierUserManagerService()
						.getUserByName(pmap);
			}
			if(count==1){
			   request.setAttribute("isError", 1);
			   if(getLanguage().equals("/en")){
	            	request.setAttribute("message","UserName already exists ");
	            }else{
	            	request.setAttribute("message","用户名已存在");	
	            }
			    LOGGER.error("用户:"+request.getParameter("loginName")+"注册：用户名已存在！");
	            return "/user/regist2";
			}
		}
		supplier.setPhone(phoneCode+supplier.getPhone());
		supplier.setStatus(0);
		supplier.setCreateTime(new Date());
	//	supplier.setName(request.getParameter("companyName"));
		supplier.setName(request.getParameter("companyName"));
		supplier.setFax(request.getParameter("fax"));
		if(Common.isEmpty(request.getParameter("post"))){
			supplier.setPost( Common.stringToInteger(request.getParameter("post")));
		}
		//设置pop用户为51
		supplier.setSupplyType(51);
		supplier.setType(-1);	//注册的时候默认给-1值
		supplier.setOrganizationType(5);
		supplier.setHqqPwd(MD5.encrypt(supplier.getHqqPwd()));
		supplier.setCompanyQy("10");
		supplier.setUserId(supplier.getUserId());
		supplier.setActiveStatus(-1);	//该企业注册未激活置为-1
		LOGGER.info("pop user regist set supplyType 51 "+user.getLoginName());
		
		User tjUser = null;
		Supplier sjSupplier = null;
		if(StringUtils.isEmpty(supplier.getSjSupplierId())){		//如果上级企业代码为空 置为邀请码用户里的supplierId
			/*tjUser = RemoteServiceSingleton.getInstance().getUserService().findUserByMobile(supplier.getUserTj());
			if(tjUser != null && StringUtils.isNotEmpty(tjUser.getSupplierId())){
				Supplier tjSupplier = RemoteServiceSingleton.getInstance().getSupplierManagerService()
						.findSupplier(Long.valueOf(tjUser.getSupplierId()));
				if(tjSupplier != null && tjSupplier.getType() == 1){		//属于子公司
					supplier.setSjSupplierId(tjSupplier.getSupplierId()+"");
				}else{
					Supplier defaultSupplier = RemoteServiceSingleton.getInstance().getSupplierManagerService()
							.getSupplierBySupplierCode("SQ69");
					if(defaultSupplier != null){
						supplier.setSjSupplierId(defaultSupplier.getSupplierId()+"");
					}
				}
			}else{
				Supplier defaultSupplier = RemoteServiceSingleton.getInstance().getSupplierManagerService()
						.getSupplierBySupplierCode("SQ69");
				if(defaultSupplier != null){
					supplier.setSjSupplierId(defaultSupplier.getSupplierId()+"");
				}
			}*/
		}else{		//不为空根据企业代码获取相对应的supplierId
			sjSupplier = RemoteServiceSingleton.getInstance().getSupplierManagerService()
					.getSupplierBySupplierCode(supplier.getSjSupplierId());
			if(sjSupplier != null){
				supplier.setSjSupplierId(sjSupplier.getSupplierId()+"");
			}
		}
/*		if(StringUtils.isEmpty(supplier.getSjSupplierId())){		//如果上级企业代码为空 置为邀请码用户里的supplierId
			tjUser = RemoteServiceSingleton.getInstance().getUserService().findUserByMobile(supplier.getUserTj());
			if(tjUser != null){
				supplier.setSjSupplierId(tjUser.getSupplierId());
			}
		}else{		//不为空根据企业代码获取相对应的supplierId
			sjSupplier = RemoteServiceSingleton.getInstance().getSupplierManagerService()
					.getSupplierBySupplierCode(supplier.getSjSupplierId());
			if(sjSupplier != null){
				supplier.setSjSupplierId(sjSupplier.getSupplierId()+"");
			}
		}*/
		Long  supplierId = RemoteServiceSingleton.getInstance().getSupplierManagerService().insert(supplier);
		SupplierProduct product=new SupplierProduct();
		getObjectFromRequest(product,request);
		SupplierPartner partner=new SupplierPartner();
		partner.setName(request.getParameter("p_companyName"));
		partner.setAddress(request.getParameter("p_companyName"));
		partner.setContact(request.getParameter("p_companyContact"));
		partner.setEmail(request.getParameter("p_companyMail"));
		partner.setTelephone(request.getParameter("p_companyTel"));
		RemoteServiceSingleton.getInstance().getSupplierManagerService().register(supplierId, user, product, partner);
		request.setAttribute("name", user.getLoginName());
		String name="";
		try {
			name =DES.encrypt(user.getLoginName(), Constants.CCIGMALL);
		} catch (Exception e) {
			LOGGER.error("注册：用户名回传成功页面出错!用户名："+user.getLoginName(),e);
		}
		//request.setAttribute("language",getLanguage().substring(1));
		LOGGER.info("注册成功：用户名："+user.getLoginName());
		return "redirect:/supplier/regist_success?sid="+name;
	}
	
	
	
	/** 
	* @Description:企业号商户注册
	* @param myfile MultipartFile
	* @param myfile1 MultipartFile
	* @param map map
	* @param supplier Supplier
	* @param request  HttpServletRequest
	* @return regist_success 
	*/
	@RequestMapping("/regist3")
	public String regist3(MultipartFile myfile,MultipartFile myfile1,String kaptcha,
			Map<String,Object> map, Supplier supplier,HttpServletRequest request,String uid,String phoneCode,MultipartFile myfile2){
		LOGGER.info("注册：supplier:"+JSON.toJSONString(supplier));
		SupplierNumRecordDto supplierNumRecordDto;
 		try {
 			supplierNumRecordDto = supplierNumRecordService.selectRecordByUserid((supplier.getUserId()).intValue());
 			Integer jiaTingStatus = supplierNumRecordDto.getStatus();
 			if(jiaTingStatus==0){
 				request.setAttribute("message","您没有资格注册 ");
				return "/user/regist3";
 			}
 		} catch (Exception e1) {
 			
 			e1.printStackTrace();
 		}
		
		int i = RemoteServiceSingleton.getInstance().getSupplierManagerService().selectCountUser(supplier.getUserId());
		if(i>=1){
			request.setAttribute("message","不能重复注册或同时注册家庭号和企业号！");
			return "/user/regist3";
			
		}
		try {
			String kaptchaExpected = memcachedClient.get(uid+Constants.KAPTCHA_SESSION_KEY);
			if(!kaptcha.toLowerCase().equals(kaptchaExpected.toLowerCase())){
				if(getLanguage().equals("/en")){
	            	request.setAttribute("message","Verification code is wrong！");
	            }else{
	            	request.setAttribute("message","验证码有误！");	
	            } 
				return "/user/regist3";
			}
		} catch (Exception e) {
			LOGGER.error("注册：  memcached中取验证码出问题！",e);
		}
		
		if(null==myfile){ 
            request.setAttribute("isError", 1);
            if(getLanguage().equals("/en")){
            	request.setAttribute("message","Missing Upload Files");
            }else{
            	request.setAttribute("message","缺少需要上传的文件");	
            }
            LOGGER.error("注册：缺少需要上传的文件！");
            return "/user/regis3t";
        }else{ 
           // System.out.println( Common.getFileExt2(myfile1.getOriginalFilename()));
    		String myfileUrl="";
    		String myfile1Url="";
    		String myfile2Url="";
			try {
				myfileUrl = UploadFileUtil.uploadFile(myfile.getInputStream(),
						Common.getFileExt2(myfile.getOriginalFilename()), null);
				if(null!=myfile1&&!"".equals(Common.getFileExt2(myfile1.getOriginalFilename()))){
					myfile1Url = UploadFileUtil.uploadFile(myfile1.getInputStream(),
							Common.getFileExt2(myfile1.getOriginalFilename()), null);
				}
				if(null!=myfile2&&!"".equals(Common.getFileExt2(myfile2.getOriginalFilename()))){
					myfile2Url = UploadFileUtil.uploadFile(myfile2.getInputStream(),
							Common.getFileExt2(myfile2.getOriginalFilename()), null);
				}
			} catch (Exception e) {
				LOGGER.error("注册：上传文件到图片服务器出错！",e);
			}
        	supplier.setCompanyLegitimacyUrl(myfileUrl);
        	if(null!=myfile1&&!"".equals(Common.getFileExt2(myfile1.getOriginalFilename()))){
        	  supplier.setCompanyDetailedUrl(myfile1Url);
        	}
        	if(null!=myfile2&&!"".equals(Common.getFileExt2(myfile2.getOriginalFilename()))){
        		supplier.setLogoImgurl(myfile2Url);
        	}else{
        		supplier.setLogoImgurl("group1/M00/00/31/CgAAElgxxt-Aa7U1AAAjS6o85T0082.jpg");	//默认图片logo地址
        	}
        } 
	    SupplierUser user=new SupplierUser();
		if(!Common.isEmpty(request.getParameter("loginName"))){
			user.setIsAdmin(1);
			user.setStatus(1);
			user.setLoginName(request.getParameter("loginName"));
			user.setPassword(MD5.encrypt(request.getParameter("password")));
			
			user.setRecordPwd(request.getParameter("password"));	//记录明文，为了unicorn创建账号发送短信用
			
			Map<String, String> pmap = new LinkedHashMap<String, String>();
			int count = 1;
			if (!Common.isEmpty(request.getParameter("loginName"))) {
				pmap.put("loginName", request.getParameter("loginName"));
				count = RemoteServiceSingleton.getInstance().getSupplierUserManagerService()
						.getUserByName(pmap);
			}
			if(count==1){
			   request.setAttribute("isError", 1);
			   if(getLanguage().equals("/en")){
	            	request.setAttribute("message","UserName already exists ");
	            }else{
	            	request.setAttribute("message","用户名已存在");	
	            }
			    LOGGER.error("用户:"+request.getParameter("loginName")+"注册：用户名已存在！");
	            return "/user/regist3";
			}
		}
		supplier.setPhone(phoneCode+supplier.getPhone());
		supplier.setStatus(0);
		supplier.setCreateTime(new Date());
	//	supplier.setName(request.getParameter("companyName"));
		supplier.setName(request.getParameter("companyName"));
		supplier.setFax(request.getParameter("fax"));
		if(Common.isEmpty(request.getParameter("post"))){
			supplier.setPost( Common.stringToInteger(request.getParameter("post")));
		}
		//设置pop用户为51
		supplier.setSupplyType(51);
		supplier.setType(10);	//注册的时候默认给-1值
		supplier.setHqqPwd(MD5.encrypt(supplier.getHqqPwd()));		//红旗券支付密码
		supplier.setActiveStatus(-1);	//该企业注册未激活置为-1
		supplier.setOrganizationType(6);
		supplier.setUserId(supplier.getUserId());
		LOGGER.info("pop user regist set supplyType 51 "+user.getLoginName());
		
		User tjUser = null;
		Supplier sjSupplier = null;
		if(StringUtils.isEmpty(supplier.getSjSupplierId())){		//如果上级企业代码为空 置为邀请码用户里的supplierId
			/*tjUser = RemoteServiceSingleton.getInstance().getUserService().findUserByMobile(supplier.getUserTj());
			if(tjUser != null && StringUtils.isNotEmpty(tjUser.getSupplierId())){
				Supplier tjSupplier = RemoteServiceSingleton.getInstance().getSupplierManagerService()
						.findSupplier(Long.valueOf(tjUser.getSupplierId()));
				if(tjSupplier != null && tjSupplier.getType() == 1){		//属于子公司
					supplier.setSjSupplierId(tjSupplier.getSupplierId()+"");
				}else{
					Supplier defaultSupplier = RemoteServiceSingleton.getInstance().getSupplierManagerService()
							.getSupplierBySupplierCode("SQ69");
					if(defaultSupplier != null){
						supplier.setSjSupplierId(defaultSupplier.getSupplierId()+"");
					}
				}
			}else{
				Supplier defaultSupplier = RemoteServiceSingleton.getInstance().getSupplierManagerService()
						.getSupplierBySupplierCode("SQ69");
				if(defaultSupplier != null){
					supplier.setSjSupplierId(defaultSupplier.getSupplierId()+"");
				}
			}*/
		}else{		//不为空根据企业代码获取相对应的supplierId
			sjSupplier = RemoteServiceSingleton.getInstance().getSupplierManagerService()
					.getSupplierBySupplierCode(supplier.getSjSupplierId());
			if(sjSupplier != null){
				supplier.setSjSupplierId(sjSupplier.getSupplierId()+"");
			}
		}
/*		if(StringUtils.isEmpty(supplier.getSjSupplierId())){		//如果上级企业代码为空 置为邀请码用户里的supplierId
			tjUser = RemoteServiceSingleton.getInstance().getUserService().findUserByMobile(supplier.getUserTj());
			if(tjUser != null){
				supplier.setSjSupplierId(tjUser.getSupplierId());
			}
		}else{		//不为空根据企业代码获取相对应的supplierId
			sjSupplier = RemoteServiceSingleton.getInstance().getSupplierManagerService()
					.getSupplierBySupplierCode(supplier.getSjSupplierId());
			if(sjSupplier != null){
				supplier.setSjSupplierId(sjSupplier.getSupplierId()+"");
			}
		}*/
		Long  supplierId = RemoteServiceSingleton.getInstance().getSupplierManagerService().insert(supplier);
		
		SupplierProduct product=new SupplierProduct();
		getObjectFromRequest(product,request);
		SupplierPartner partner=new SupplierPartner();
		partner.setName(request.getParameter("p_companyName"));
		partner.setAddress(request.getParameter("p_companyName"));
		partner.setContact(request.getParameter("p_companyContact"));
		partner.setEmail(request.getParameter("p_companyMail"));
		partner.setTelephone(request.getParameter("p_companyTel"));
		RemoteServiceSingleton.getInstance().getSupplierManagerService().register(supplierId, user, product, partner);
		request.setAttribute("name", user.getLoginName());
		String name="";
		try {
			name =DES.encrypt(user.getLoginName(), Constants.CCIGMALL);
		} catch (Exception e) {
			LOGGER.error("注册：用户名回传成功页面出错!用户名："+user.getLoginName(),e);
		}
		//request.setAttribute("language",getLanguage().substring(1));
		LOGGER.info("注册成功：用户名："+user.getLoginName());
		return "redirect:/supplier/regist_success?sid="+name;
	}
	
	
	/** 
	* @Description:供应商信息表下载.
	* @param response HttpServletResponse
	* @param url   url参数 
	*/
	@RequestMapping("/regist_success")
	public String registSuccess(Map<String,Object> map,String sid){
		
		try {
			sid=sid.replaceAll(" ","+");
			sid=DES.decrypt(sid, Constants.CCIGMALL);
			 LOGGER.info("注册成功：用户名"+sid);
		} catch (Exception e) {
			 LOGGER.error("注册失败：用户名"+sid);
		}
		map.put("name", sid);
		map.put("language",getLanguage().substring(1));
	    return  "/user/regist_success";
	}
	
	/** 
	* @Description:供应商信息表下载.
	* @param response HttpServletResponse
	* @param url   url参数 
	*/
	@RequestMapping("/download")
	public void download(HttpServletResponse response,String url){
		 LOGGER.info("用户："+getCurrentUser().getLoginName()+"下载文件："+url);
		if(null!=url&&url.length()>0){
			download(response ,url,null);
		}else{
			try {
				response.getWriter().write("<script language='javascript'>alert('您要下载的文件不存在!');</script>");
			} catch (IOException e) {
				LOGGER.error("下载：您要下载的文件不存在!"+e.getMessage(),e);
			}
		}
	}
	
	@RequestMapping("/downloadTemp")
	public void downloadTemp(HttpServletRequest request, HttpServletResponse response,String url){
		LOGGER.info("用户下载文件：供应商信息表.xlsx");
        url=request.getSession().getServletContext().getRealPath("/");
        String realName="供应商信息表.xlsx";
        url=url+"modelFile/supplierInfo.xlsx";
	    if("/en".equals(getLanguage())){
		     realName="SupplierInfo.xlsx";
         }
		try{
				File f = new File(url);
	            //检查该文件是否存在
			  if(!f.exists()){
			      response.sendError(404,"File not found!");
			  }
	          //设置响应类型和响应头
	          response.setContentType("application/x-msdownload;charset=UTF-8");
	          String userAgent = getRequest().getHeader("User-Agent");  
	         if(userAgent.contains("Firefox")){
	        	    response.addHeader("Content-Disposition","attachment;filename="+
	        	    		new String(realName.getBytes("GB2312"),"ISO-8859-1"));
	          }else {
	        		response.addHeader("Content-Disposition","attachment;filename=" +
	        				URLEncoder.encode(realName, "UTF-8"));
	    		}
	         //读出文件到i/o流
	         FileInputStream fis=new FileInputStream(f);
	         BufferedInputStream buff=new BufferedInputStream(fis);
	         byte [] b=new byte[1024];//相当于我们的缓存
	         long k=0;//该值用于计算当前实际下载了多少字节
	         //从response对象中得到输出流,准备下载
	         OutputStream myout=response.getOutputStream();
	         //开始循环下载
	         while(k<f.length()){
	             int j=buff.read(b,0,1024);
	             k+=j;
	             //将b中的数据写到客户端的内存
	             myout.write(b,0,j);
	         }
	         //将写入到客户端的内存的数据,刷新到磁盘
	         myout.flush();
	         myout.close();
	         buff.close();
		} catch (FileNotFoundException e) {
			LOGGER.error("文件不存在"+e.getMessage(),e);
		} catch (IOException e) {
			LOGGER.error("下载供应商信息表出错"+e.getMessage(),e);
		}
	}
	/** 
	* @Description: 获取商户基本信息 .
	* @param map map
	* @return 基本信息页面
	*/
	@RequestMapping("/jiben")
	@Token(saveToken=true)
	public String supplierInfo(Map<String,Object> map,String message){
		LOGGER.info("用户："+getCurrentUser().getLoginName()+"访问基本信息页面");
		if(!Common.isEmpty(message)){
			map.put("message", message);
		}
		//调用 基础接口  国家
		
		Supplier supplier=RemoteServiceSingleton.getInstance().getSupplierManagerService().findSupplier(getCurrentSupplierId());
        map.put("data", supplier);
        map.put("language", getLanguage().substring(1));
        SupplierProduct product=RemoteServiceSingleton.getInstance().getSupplierManagerService().getProductBySupplierId(getCurrentSupplierId());
        map.put("product", product);
        List<TdCatePub> childrenCategoryList = new ArrayList<TdCatePub>();
		 if(RemoteServiceSingleton.getInstance().getCategoryServiceRpc()!=null){
            try {
               childrenCategoryList  = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getTopCategoryList();
           } catch (Exception e) {
        	   LOGGER.error("获取类目失败！",e);
           }
        }
		List<String> categoryNameCn = new ArrayList<String>();
		List<String> categoryNameEn = new ArrayList<String>();
        if(!childrenCategoryList.isEmpty()){
            for (TdCatePub tdCatePub : childrenCategoryList) {
                categoryNameCn.add(tdCatePub.getPubNameCn());
                categoryNameEn.add(tdCatePub.getPubName());
            }
        }
        
      //根据上级企业supplierId获取上级企业对象
		if((!StringUtils.isEmpty(supplier.getSjSupplierId())) && !supplier.getSjSupplierId().equals("0")){
			Supplier sjSupplier = RemoteServiceSingleton.getInstance().getSupplierManagerService().findSupplier(Long.valueOf(supplier.getSjSupplierId()));
			map.put("sjSupplier", sjSupplier);
		}
		User user = RemoteServiceSingleton.getInstance().getUserService().findUserBySupplierId(getCurrentSupplierId());
		map.put("user", user);
		
		//获取所有入驻区域类型
		List<SupplierRegionSettings> regionList = regionService.getAllRegionSettings();
		map.put("regionList", regionList);
        
        if("/en".equals(getLanguage())){
            map.put("category", JSONObject.toJSONString(categoryNameEn));
        } else {
            map.put("category",JSONObject.toJSONString(categoryNameCn) );
        }
        if(supplier.getOrganizationType()!=null&&supplier.getOrganizationType()==5){
        	return getLanguage()+"/user/jiben2";
        }
        if(supplier.getOrganizationType()!=null&&supplier.getOrganizationType()==6){
        	return getLanguage()+"/user/jiben3";
        }
		return getLanguage()+"/user/jiben";
	}
	
	
	
	/** 
	* @Description: 获取家庭号商户基本信息 .
	* @param map map
	* @return 基本信息页面
	*/
	@RequestMapping("/jiben2")
	@Token(saveToken=true)
	public String supplierInfo2(Map<String,Object> map,String message){
		LOGGER.info("用户："+getCurrentUser().getLoginName()+"访问基本信息页面");
		if(!Common.isEmpty(message)){
			map.put("message", message);
		}
		//调用 基础接口  国家
		
		Supplier supplier=RemoteServiceSingleton.getInstance().getSupplierManagerService().findSupplier(getCurrentSupplierId());
        map.put("data", supplier);
        map.put("language", getLanguage().substring(1));
        SupplierProduct product=RemoteServiceSingleton.getInstance().getSupplierManagerService().getProductBySupplierId(getCurrentSupplierId());
        map.put("product", product);
        List<TdCatePub> childrenCategoryList = new ArrayList<TdCatePub>();
		 if(RemoteServiceSingleton.getInstance().getCategoryServiceRpc()!=null){
            try {
               childrenCategoryList  = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getTopCategoryList();
           } catch (Exception e) {
        	   LOGGER.error("获取类目失败！",e);
           }
        }
		List<String> categoryNameCn = new ArrayList<String>();
		List<String> categoryNameEn = new ArrayList<String>();
        if(!childrenCategoryList.isEmpty()){
            for (TdCatePub tdCatePub : childrenCategoryList) {
                categoryNameCn.add(tdCatePub.getPubNameCn());
                categoryNameEn.add(tdCatePub.getPubName());
            }
        }
        
      //根据上级企业supplierId获取上级企业对象
		if((!StringUtils.isEmpty(supplier.getSjSupplierId())) && !supplier.getSjSupplierId().equals("0")){
			Supplier sjSupplier = RemoteServiceSingleton.getInstance().getSupplierManagerService().findSupplier(Long.valueOf(supplier.getSjSupplierId()));
			map.put("sjSupplier", sjSupplier);
		}
		User user = RemoteServiceSingleton.getInstance().getUserService().findUserBySupplierId(getCurrentSupplierId());
		map.put("user", user);
		
		//获取所有入驻区域类型
		List<SupplierRegionSettings> regionList = regionService.getAllRegionSettings();
		map.put("regionList", regionList);
        
        if("/en".equals(getLanguage())){
            map.put("category", JSONObject.toJSONString(categoryNameEn));
        } else {
            map.put("category",JSONObject.toJSONString(categoryNameCn) );
        }
		return getLanguage()+"/user/jiben2";
	}
	
	
	
	@RequestMapping("/jiben3")
	@Token(saveToken=true)
	public String supplierInfo3(Map<String,Object> map,String message){
		LOGGER.info("用户："+getCurrentUser().getLoginName()+"访问基本信息页面");
		if(!Common.isEmpty(message)){
			map.put("message", message);
		}
		//调用 基础接口  国家
		
		Supplier supplier=RemoteServiceSingleton.getInstance().getSupplierManagerService().findSupplier(getCurrentSupplierId());
        map.put("data", supplier);
        map.put("language", getLanguage().substring(1));
        SupplierProduct product=RemoteServiceSingleton.getInstance().getSupplierManagerService().getProductBySupplierId(getCurrentSupplierId());
        map.put("product", product);
        List<TdCatePub> childrenCategoryList = new ArrayList<TdCatePub>();
		 if(RemoteServiceSingleton.getInstance().getCategoryServiceRpc()!=null){
            try {
               childrenCategoryList  = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getTopCategoryList();
           } catch (Exception e) {
        	   LOGGER.error("获取类目失败！",e);
           }
        }
		List<String> categoryNameCn = new ArrayList<String>();
		List<String> categoryNameEn = new ArrayList<String>();
        if(!childrenCategoryList.isEmpty()){
            for (TdCatePub tdCatePub : childrenCategoryList) {
                categoryNameCn.add(tdCatePub.getPubNameCn());
                categoryNameEn.add(tdCatePub.getPubName());
            }
        }
        
      //根据上级企业supplierId获取上级企业对象
		if((!StringUtils.isEmpty(supplier.getSjSupplierId())) && !supplier.getSjSupplierId().equals("0")){
			Supplier sjSupplier = RemoteServiceSingleton.getInstance().getSupplierManagerService().findSupplier(Long.valueOf(supplier.getSjSupplierId()));
			map.put("sjSupplier", sjSupplier);
		}
		User user = RemoteServiceSingleton.getInstance().getUserService().findUserBySupplierId(getCurrentSupplierId());
		map.put("user", user);
		
		//获取所有入驻区域类型
		List<SupplierRegionSettings> regionList = regionService.getAllRegionSettings();
		map.put("regionList", regionList);
        
        if("/en".equals(getLanguage())){
            map.put("category", JSONObject.toJSONString(categoryNameEn));
        } else {
            map.put("category",JSONObject.toJSONString(categoryNameCn) );
        }
        if(supplier.getOrganizationType()!=null&&supplier.getOrganizationType()==6){
        	return getLanguage()+"/user/jiben3";
        }
		return getLanguage()+"/user/jiben3";
	}

	
	
	
	
	/** 
	* @Description:更新商户基本信息.
	* @param iconUrl ICON
	* @param map MAP
	* @param supplier  Supplier
	* @return 基本信息页面
	*/
	@RequestMapping("/update")
	@Token(validateToken=true)
	public String updateSupplier(MultipartFile myfile,MultipartFile myfile1,MultipartFile myfile2,Map<String,Object> map ,
			Supplier supplier, SupplierProduct product,HttpServletRequest request ){
		String myfileUrl="";
		String myfile1Url="";
		String myfile2Url="";
		try {
			if(null!=myfile&&!"".equals(Common.getFileExt2(myfile.getOriginalFilename()))){
				myfileUrl=UploadFileUtil.uploadFile(myfile.getInputStream(), Common.getFileExt2(myfile.getOriginalFilename()), null);
			}
			if(null!=myfile1&&!"".equals(Common.getFileExt2(myfile1.getOriginalFilename()))){
				myfile1Url=UploadFileUtil.uploadFile(myfile1.getInputStream(), Common.getFileExt2(myfile1.getOriginalFilename()), null);
			}
			if(null!=myfile2&&!"".equals(Common.getFileExt2(myfile2.getOriginalFilename()))){
				myfile2Url = UploadFileUtil.uploadFile(myfile2.getInputStream(),
						Common.getFileExt2(myfile2.getOriginalFilename()), null);
			}
			
		} catch (Exception e) {
			LOGGER.error("注册：上传文件到图片服务器出错！",e);
		}
		//资质文件备份
		if(null!=myfile&&!"".equals(Common.getFileExt2(myfile.getOriginalFilename()))){
    		supplier.setCompanyLegitimacyUrl(myfileUrl);
    	}
		//详情文件备份
		if(null!=myfile1&&!"".equals(Common.getFileExt2(myfile1.getOriginalFilename()))){
    		supplier.setCompanyDetailedUrl(myfile1Url);
    	}
		//企业logo备份
    	if(null!=myfile2&&!"".equals(Common.getFileExt2(myfile2.getOriginalFilename()))){
    		supplier.setLogoImgurlBackup(myfile2Url);
    	}
    	
		supplier.setModifyStatus(1);
		Supplier newSupplier = new Supplier();
		newSupplier = RemoteServiceSingleton.getInstance().getSupplierManagerService().findSupplier(supplier.getSupplierId());
		if(newSupplier != null && newSupplier.getStatus() == 2){	//未通过后修改信息 可以重新审核
			supplier.setStatus(1);		
		}
		int result = RemoteServiceSingleton.getInstance().getSupplierManagerService().updateBackupInfo(supplier);
		
		int updateProductStatus = 0;	//修改列表和品牌
		if(!product.getCategories().equals(product.getCategoriesBackup()) || !product.getBrand().equals(product.getBrandBackup())){
			SupplierProduct newSupplierProduct = new SupplierProduct();
			newSupplierProduct.setModifyStatus(1);	//1表示修改
			newSupplierProduct.setSupplierId(supplier.getSupplierId());
			if(!product.getCategories().equals(product.getCategoriesBackup())){
				newSupplierProduct.setCategoriesBackup(product.getCategoriesBackup());
			}
			if(!product.getBrand().equals(product.getBrandBackup())){
				newSupplierProduct.setBrandBackup(product.getBrandBackup());
			}
			updateProductStatus = RemoteServiceSingleton.getInstance().getSupplierManagerService().updateProductBackupInfo(newSupplierProduct);
		}
		
		if(result>0 || updateProductStatus>0){
			LOGGER.info("用户："+getCurrentUser().getLoginName()+"更新商户基本信息成功");
			return "redirect:/supplier/jiben?message=ok";
    	}else{
			LOGGER.error("用户："+getCurrentUser().getLoginName()+"更新商户基本信息失败！");
			return "redirect:/supplier/jiben?message=error";
		}
		
	}
	
	/** 
	* @Description:更新家庭号基本信息.
	* @param iconUrl ICON
	* @param map MAP
	* @param supplier  Supplier
	* @return 基本信息页面
	*/
	@RequestMapping("/update2")
	@Token(validateToken=true)
	public String updateSupplier(Map<String,Object> map ,
			Supplier supplier, SupplierProduct product,HttpServletRequest request ){
		
    	
		supplier.setModifyStatus(1);
		Supplier newSupplier = new Supplier();
		newSupplier = RemoteServiceSingleton.getInstance().getSupplierManagerService().findSupplier(supplier.getSupplierId());
		if(newSupplier != null && newSupplier.getStatus() == 2){	//未通过后修改信息 可以重新审核
			supplier.setStatus(1);		
		}
		int result = RemoteServiceSingleton.getInstance().getSupplierManagerService().updateInfo(supplier);
		
		int updateProductStatus = 0;	//修改列表和品牌
		/*if(!product.getCategories().equals(product.getCategoriesBackup()) || !product.getBrand().equals(product.getBrandBackup())){
			SupplierProduct newSupplierProduct = new SupplierProduct();
			newSupplierProduct.setModifyStatus(1);	//1表示修改
			newSupplierProduct.setSupplierId(supplier.getSupplierId());
			if(!product.getCategories().equals(product.getCategoriesBackup())){
				newSupplierProduct.setCategoriesBackup(product.getCategoriesBackup());
			}
			if(!product.getBrand().equals(product.getBrandBackup())){
				newSupplierProduct.setBrandBackup(product.getBrandBackup());
			}
			updateProductStatus = RemoteServiceSingleton.getInstance().getSupplierManagerService().updateProductBackupInfo(newSupplierProduct);
		}*/
		
		if(result>0 || updateProductStatus>0){
			LOGGER.info("用户："+getCurrentUser().getLoginName()+"更新商户基本信息成功");
			return "redirect:/supplier/jiben2?message=ok";
    	}else{
			LOGGER.error("用户："+getCurrentUser().getLoginName()+"更新商户基本信息失败！");
			return "redirect:/supplier/jiben2?message=error";
		}
		
	}
	

	/** 
	* @Description:验证码.
	*/
	@RequestMapping("/validateCode")
	public void validateCode(HttpServletRequest request,HttpServletResponse response,String uid){
		   response.setContentType("image/jpeg");   
	       String capText = captchaProducer.createText();   
		   try {
			   memcachedClient.set(uid+Constants.KAPTCHA_SESSION_KEY, 60,capText);
		       BufferedImage bi = captchaProducer.createImage(capText);  
		       ServletOutputStream out = response.getOutputStream();
		       ImageIO.write(bi, "jpg", out);  
			        try {  
			            out.flush();  
			        } finally {  
			            out.close();  
		        } 
		   } catch (Exception e) {
				LOGGER.error("生成验证码失败！",e);
			} 
	  }
	/** 
	* @Description:找回密码Step1
	* @param response HttpServletResponse
	*/
	@RequestMapping("/findPwdNext")
	public String findPwdNext(String username,String authCode,String uid, Map<String,Object> map){	
		map.put("uid", uid);
		if(!Common.isEmpty(username)){
			SupplierUser user= RemoteServiceSingleton.getInstance().getSupplierUserManagerService().getUserByName(username);
			if(null!=user){
				Supplier supplier= RemoteServiceSingleton.getInstance().getSupplierManagerService().findSupplier(user.getSupplierId());
			    if(null!=supplier){
			    	if(null!=supplier.getEmail()){
			    		try {
			  			  memcachedClient.set(uid,30*60,uid);
			  			  memcachedClient.set(uid+Constants.SESSION_ID,30*60,username);
			  			  memcachedClient.set(uid+Constants.SUPPLIERUSER,30*60,user);
			  			  memcachedClient.set(uid+Constants.SUPPLIER,30*60,supplier.getEmail());
			  			  map.put("username",username);
			  			  map.put("email", supplier.getEmail().charAt(0)+"******"+supplier.getEmail().substring(supplier.getEmail().indexOf("@")-1));
				  		} catch (Exception e) {
				  			LOGGER.error("用户："+username+"找回密码：memcachedClient Set uid username email报错", e);
				  		}
			    		return getLanguage()+"/user/sendMail";
			    	}
			    }else{
			    	String newUid=UUID.randomUUID().toString();
			    	map.put("uid", newUid);
			    	 if("/en".equals(getLanguage())){
			    		 map.put("message","Associated supplier information does not exist!");
			         }else{
			        	 map.put("message","关联商户信息不存在!");
			         }
			    	 LOGGER.error("用户："+username+"找回密码：关联商户信息不存在");
			    	return getLanguage()+"/user/findPwd";
			    }
			}else{
				String newUid=UUID.randomUUID().toString();
		    	map.put("uid", newUid);
				 if("/en".equals(getLanguage())){
					 map.put("message","The user information does not exist!");
		         }else{
		        	 map.put("message","用户信息不存在!");
		         }
				 LOGGER.error("用户："+username+"找回密码：用户信息不存在");
		    	return getLanguage()+"/user/findPwd";
			}
		}
	     String newUid=UUID.randomUUID().toString();
	     map.put("uid", newUid);
		 if("/en".equals(getLanguage())){
			map.put("message","login name cannot be empty !");
         }else{
        	map.put("message","用户名不能为空!");
         }
		 LOGGER.info("用户："+username+"找回密码：用户名不能为空");
    	return getLanguage()+"/user/findPwd";
	}
	/** 
	* @Description:找回密码Step1
	* @param response HttpServletResponse
	*/
	@RequestMapping("/findPwd")
	public String findPwd(Map<String,Object> map){
		String uid=UUID.randomUUID().toString();
		try {
		  memcachedClient.set(uid,30*60,uid);
		}catch (Exception e) {
			LOGGER.error("找回密码：memcachedClient Set uid报错", e);
  		}
		map.put("uid", uid);
		return getLanguage()+"/user/findPwd";
	}
	/** 
	* @Description:找回密码Step1
	* @param response HttpServletResponse
	*/
	@RequestMapping("/sendMail")
	@ResponseBody
	public String sendMail(String uid,HttpServletRequest request,Map<String,Object> map){	
		try {
			String baseUrl = request.getScheme() + "://" + request.getServerName()
					+":" + request.getServerPort()+ request.getContextPath() + "/";
			String username=memcachedClient.get(uid+Constants.SESSION_ID);
			String email=memcachedClient.get(uid+Constants.SUPPLIER);
		    String jiami= DES.encrypt(uid, Constants.CCIGMALL);
			baseUrl=baseUrl+"supplier/resetPwd?uid="+jiami;
			if(!Common.isEmpty(email)){
			  if(!"/en".equals(getLanguage())){
					String content="<table cellspacing='0' cellpadding='0' width='620' border='0' style='margin-left: 10px;'><tbody><tr><td style='font-size: 12px; line-height: 25px; padding-top: 10px;'>"
							+ "<strong>尊敬的"+username+"，您好:</strong></td></tr><tr><td style='line-height: 20px; padding-top: 0px; font-size: 12px;'> 您在三千万 点击了“忘记密码”按钮，故系统自动为您发送了这封邮件。"
							+ "您可以点击以下链接修改您的密码：<br><a target='_blank' href='"+baseUrl+"'>"
							+ ""+baseUrl+"</a></td>"
							+ " </tr><tr><td style='line-height: 20px; padding-top: 8px; font-size: 12px;'> 此链接有效期为30分钟，请在30分钟内点击链接进行修改。如果您不需要修改密码，或者您从未点击过“忘记密码”按钮，请忽略本邮件."
							+ "<br></td></tr><tr></tr><tr><td style='line-height: 20px; padding-top: 2px; font-size: 12px;'> <p>如有任何疑问，请联系三千万客服，客服热线：<span lang='EN-US' xml:lang='EN-US'>010-84932237，84937117</span></p>"
							+ "</td></tr></tbody></table>";
					SendHtmlMail.send(email, "找回密码(3QIANWAN.com)",content);
		         }else{
		        		String content="<table cellspacing='0' cellpadding='0' width='620' border='0' style='margin-left: 10px;'><tbody><tr><td style='font-size: 12px; line-height: 25px; padding-top: 10px;'>"
								+ "<strong>Dear "+username+", Hello:</strong></td></tr><tr><td style='line-height: 20px; padding-top: 0px; font-size: 12px;'> in your 3QIANWAN click on the 'forgot password' button, the system automatically send you this message."
								+ "You can click on the following link to change your password：<br><a target='_blank' href='"+baseUrl+"'>"
								+ ""+baseUrl+"</a></td>"
								+ " </tr><tr><td style='line-height: 20px; padding-top: 8px; font-size: 12px;'> this link is valid for 30 minutes, please click on the link in 30 minutes to modify."
								+ "If you do not need to modify the password, or you never click on the forgot password button, please ignore this email."
								+ "<br></td></tr><tr></tr><tr><td style='line-height: 20px; padding-top: 2px; font-size: 12px;'> <p>If you have any questions, please contact 3QIANWAN customer service, customer service hotline: <span lang='EN-US' xml:lang='EN-US'>010-84932237，84937117</span></p>"
								+ "</td></tr></tbody></table>";
						SendHtmlMail.send(email, "Find Password(3QIANWAN.com)",content);
		         }
			}
			LOGGER.info("用户："+username+"发送邮件成功");
			
		} catch (Exception e) {
			LOGGER.error("发送邮件报错", e);
			return "0";//发送邮件失败
		}
		//map.put("message", "");
		return "1";//发送邮件成功
	}
	/** 
	* @Description:找回密码Step1
	* @param response HttpServletResponse
	*/
	@RequestMapping("/sendMailSuccess")
	public String sendMailSucess(String uid, Map<String,Object> map){
		map.put("uid", uid);
		return getLanguage()+"/user/sendMail";
	}
	
	/** 
	* @Description:找回密码Step1
	* @param response HttpServletResponse
	*/
	@RequestMapping("/resetPwd")
	public String resetPwd(String uid,Map<String,Object> map){	
		if(Common.isEmpty(uid)){
			map.put("message","");//非法请求
			LOGGER.warn("找回密码：非法请求URL");
			return getLanguage()+"/user/findPwd";
		}else{
			map.put("uid",uid);
		}
		try {
			uid=uid.replaceAll(" ","+");
		    String jiemi=DES.decrypt(uid, Constants.CCIGMALL);
			System.err.println(jiemi);
			String uidStr=memcachedClient.get(jiemi);
			if(!Common.isEmpty(uidStr)){
				map.put("message",1);//正常
				memcachedClient.deleteWithNoReply(jiemi);
				LOGGER.warn("找回密码：正常跳转");
				return getLanguage()+"/user/resetPwd";
			}else{
				map.put("message",0);//请求超时或者过期
				return getLanguage()+"/user/resetPwd";
			}
		} catch (Exception e) {
			map.put("message",0);//请求超时或者过期
		}
		return getLanguage()+"/user/resetPwd";
	}
	/**
	 * 16.1.26
	 * 跳转修改 密码页面
	 * 
	 */
	@RequestMapping("/updatePwd")
	public String updatePwd(Map<String,Object> map){
		
		
		Supplier supplier=RemoteServiceSingleton.getInstance().getSupplierManagerService().findSupplier(getCurrentSupplierId());
        map.put("data", supplier);
        map.put("language", getLanguage().substring(1));
		
		return getLanguage()+"/user/updatePwd";
		
	}
	
	/** 
	* @Description:找回密码Step1
	* @param response HttpServletResponse
	*/
	@RequestMapping("/finish")
	@ResponseBody
	public String finish(String uid,String password,Map<String,Object> map){
		if(Common.isEmpty(uid)){
			return "-1";
		}else if(Common.isEmpty(password)){
			return "passwordError";
		}else{
			try {
				uid=uid.replaceAll(" ","+");
			    String jiemi=DES.decrypt(uid, Constants.CCIGMALL);
				System.err.println(jiemi);
				SupplierUser user=memcachedClient.get(jiemi+Constants.SUPPLIERUSER);
				if(null!=user){
					user.setPassword(MD5.encrypt(password));
					RemoteServiceSingleton.getInstance().getSupplierUserManagerService().update(user);
					return "ok";
				}else{
					return "timeOut";
				}
			} catch (Exception e) {
				LOGGER.error("找回密码链接超时"+e.getMessage(), e);
				return "timeOut";
			}	
		}
		
	}
	/** 
	* @Description:找回密码Step4
	* @param response HttpServletResponse
	*/
	@RequestMapping("/finishSuccess")
	public String finishSucess(String uid, Map<String,Object> map){
		map.put("uid", uid);
		return getLanguage()+"/user/finish";
	}
	/**
	 * 通过唯一的uid获取对应服务端缓存中的验证码
	 * @return String
	 */
	@RequestMapping(value="/validateNum")
	@ResponseBody
	public String validateNum(HttpServletRequest request,String uid){
		 String result = "";
		try {
		    	result = memcachedClient.get(uid+Constants.KAPTCHA_SESSION_KEY);
		    	LOGGER.info("KAPTCHA:"+result);
		} catch (Exception e) {
			LOGGER.error("找回密码验证码验证时异常"+e.getMessage(), e);
		} 
		return result; 
	 }
	
	/**
	 * 判断企业代码是否存在
	 * @param tjName
	 * @return
	 */
	@RequestMapping("/checkSupplierCodeIsExists")
	@ResponseBody
	public String checkSupplierCodeIsExists(String supplierCode) {
		int flag = 1;
		if(StringUtils.isEmpty(supplierCode)){
			flag = 0;
		}else{
			String isSupplierCodeExists = RemoteServiceSingleton.getInstance()
					.getSupplierManagerService().checkSupplierCodeIsExists(supplierCode);
			if(isSupplierCodeExists.equals("0")){		//不存在
				flag = 0;
			}else{
				Supplier sjSupplier = RemoteServiceSingleton.getInstance()
				.getSupplierManagerService().getSupplierBySupplierCode(supplierCode);
				if(sjSupplier != null){
					User sjUser = RemoteServiceSingleton.getInstance().getUserService().findUserBySupplierId(sjSupplier.getSupplierId());
					if(sjUser == null){
						flag = 2;
					}
				}
			}
		}
		return JSON.toJSONString(flag);
	}
	
	/**
	 * <p>根据企业代码获取对应公司名称</p>
	 * @param supplierCode
	 * @return
	 * @auth:zw
	 */
	@RequestMapping("/getCompanyNameBySupplierCode")
	@ResponseBody
	public String getCompanyNameBySupplierCode(String supplierCode) {
		String name = "";
		Supplier supplier = RemoteServiceSingleton.getInstance()
				.getSupplierManagerService().getSupplierBySupplierCode(supplierCode);
		if(supplier != null){		//不存在
			name = supplier.getName();
		}
		return name;
	}
	/**
	 * <p>根据邀请码获取需要展示的公司名称</p>
	 * @param mobile
	 * @return
	 * @auth:zw
	 */
	@RequestMapping("/getNameByTjUser")
	@ResponseBody
	public String getNameByTjUser(String mobile) {
		String name = "";
		String defaultSupplierCode = "SQ69";		//默认的
		User tjUser = null;
		Supplier tjSupplier = null;
		tjUser = RemoteServiceSingleton.getInstance().getUserService().findUserByMobile(mobile);
		
		if(tjUser == null || StringUtils.isEmpty(tjUser.getSupplierId())){
			tjSupplier = RemoteServiceSingleton.getInstance().getSupplierManagerService()
					.getSupplierBySupplierCode(defaultSupplierCode);
			if(!StringUtils.isEmpty(tjSupplier.getName())){
				name = tjSupplier.getName();
			}
		}else{
			tjSupplier = RemoteServiceSingleton.getInstance().getSupplierManagerService()
					.findSupplier(Long.valueOf(tjUser.getSupplierId()));
			if(tjSupplier != null && tjSupplier.getType() == 1){		//属于子公司
				if(!StringUtils.isEmpty(tjSupplier.getName())){
					name = tjSupplier.getName();
				}
			}else{
				tjSupplier = RemoteServiceSingleton.getInstance().getSupplierManagerService()
						.getSupplierBySupplierCode(defaultSupplierCode);
				if(tjSupplier == null){
					name = "";
				}else{
					if(!StringUtils.isEmpty(tjSupplier.getName())){
						name = tjSupplier.getName();
					}
				}
			}
		}
		return name;
	}
	
}
