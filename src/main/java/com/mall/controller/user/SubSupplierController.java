package com.mall.controller.user;

import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.csource.upload.UploadFileUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

import com.alibaba.fastjson.JSONObject;
import com.mall.architect.logging.Log;
import com.mall.architect.logging.LogFactory;
import com.mall.category.po.TcCountry;
import com.mall.category.po.TdCatePub;
import com.mall.controller.base.BaseController;
import com.mall.merchant.proxy.RemoteServiceSingleton;
import com.mall.mybatis.utility.PageBean;
import com.mall.supplier.model.Supplier;
import com.mall.supplier.model.SupplierPartner;
import com.mall.supplier.model.SupplierProduct;
import com.mall.supplier.model.SupplierUser;
import com.mall.utils.Common;
import com.mall.utils.Constants;
import com.mall.utils.MD5;

/**
 * 子供应商管理
 * @author xusq
 *
 */
@Controller
public class SubSupplierController extends BaseController {

	private static final Log LOGGER = LogFactory.getLogger(SubSupplierController.class);
	
	@RequestMapping("/subsupplier/list")
	public String userList(Map<String, Object> map, Supplier param,
			PageBean<Supplier> paramPage, String message, HttpServletRequest request) {
		    LOGGER.info("加载子供应商信息");
			// 查询参数 当前用户的商户id (supplierId)
		    param.setParentId(getCurrentSupplierId());
			// 查询参数 分页大小
			paramPage.setPageSize(Constants.PAGE_NUM_TEN);
			// 查询参数 排序字段
			paramPage.setSortFields("supplier_id");
			// 查询参数 升序降序
			paramPage.setOrder("desc");
			// 查询对象放到 parameter中
			paramPage.setParameter(param);
			// 结果list插入PageBean
			paramPage = RemoteServiceSingleton.getInstance().getSupplierManagerService().getPageList(paramPage);
			// PageBean放入map 给前台
			map.put("page", paramPage);
			map.put("message", null==message?"":message);
			return getLanguage()+"/user/subSupplier";
		//	return getLanguage()+"/user/subSupplier";
	}
	
	
	@RequestMapping("/subsupplier/toAddUI")
	public String toAddUI(Map<String, Object> map,HttpServletRequest request){
		LOGGER.info("跳转添加子供应商页面！");
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
        }
         map.put("template_url", request.getContextPath()+"/supplier/downloadTemp");
         
         if("/en".equals(getLanguage())){
             map.put("category", JSONObject.toJSONString(categoryNameEn));
             map.put("country", countryNameEn);
             map.put("callingCode", callingCodeCn); 
         } else {
             map.put("category",JSONObject.toJSONString(categoryNameCn) );
             map.put("country", countryNameCn);
             map.put("callingCode", callingCodeEn); 
         }
		return getLanguage()+"/user/addSubSupplier";
	}
	
	
	@RequestMapping("/subsupplier/save")
	public String save(MultipartFile myfile,MultipartFile myfile1,String kaptcha,
			Map<String,Object> map, Supplier supplier,HttpServletRequest request,String uid,String phoneCode){
		   LOGGER.info("添加子供应商！");
		   String message="";
			if(null==myfile){ 
	            request.setAttribute("isError", 1);
	            if(getLanguage().equals("/en")){
	            	message="Missing Upload Certificate File!";
	            }else{
	            	message="缺少需要上传资质文件!";	
	            }
	            LOGGER.error("注册：缺少需要上传的文件!");
	            return "redirect:/subsupplier/list?message="+message;
	        }else{ 
	           // System.out.println( Common.getFileExt2(myfile1.getOriginalFilename()));
	    		String myfileUrl="";
	    		String myfile1Url="";
				try {
					myfileUrl = UploadFileUtil.uploadFile(myfile.getInputStream(),
							Common.getFileExt2(myfile.getOriginalFilename()), null);
					if(null!=myfile1&&!"".equals(Common.getFileExt2(myfile1.getOriginalFilename()))){
						myfile1Url = UploadFileUtil.uploadFile(myfile1.getInputStream(),
								Common.getFileExt2(myfile1.getOriginalFilename()), null);
					}
				} catch (Exception e) {
					LOGGER.error("注册：上传文件到图片服务器出错！",e);
					 if(getLanguage().equals("/en")){
			            	message="Server busy, please try again later!";
		             }else{
		            	message="服务器忙,请稍后再试!";	
		             }
					 return "redirect:/subsupplier/list?message="+message;
				}
	        	supplier.setCompanyLegitimacyUrl(myfileUrl);
	        	if(null!=myfile1&&!"".equals(Common.getFileExt2(myfile1.getOriginalFilename()))){
	        	  supplier.setCompanyDetailedUrl(myfile1Url);
	        	}
	        } 
			//supplier.setCompanyNature(Constants.SUB_SUPPLIER);
			
		    SupplierUser user=new SupplierUser();
			if(!Common.isEmpty(request.getParameter("loginName"))){
				user.setIsAdmin(1);
				user.setStatus(0);
				user.setLoginName(request.getParameter("loginName"));
				user.setPassword(MD5.encrypt(request.getParameter("password")));
				Map<String, String> pmap = new LinkedHashMap<String, String>();
				int count = 1;
				if (!Common.isEmpty(request.getParameter("loginName"))) {
					pmap.put("loginName", request.getParameter("loginName"));
					count = RemoteServiceSingleton.getInstance().getSupplierUserManagerService().getUserByName(pmap);
				}
				if(count==1){
				   request.setAttribute("isError", 1);
				   if(getLanguage().equals("/en")){
		            	message="UserName already exists ";
		            }else{
		            	message="用户名已存在";	
		            }
				    LOGGER.error("用户:"+request.getParameter("loginName")+"注册：用户名已存在！");
				    return "redirect:/subsupplier/list?message="+message;
				}
			}
			supplier.setCompanyNature(Constants.SUB_SUPPLIER);
			supplier.setPhone(phoneCode+supplier.getPhone());
			supplier.setStatus(Constants.PUBLIC_STATIC_NUM_0);//默认状态 0 未审核
			supplier.setType(Constants.PUBLIC_STATIC_NUM_1);//1 是子供应商
			supplier.setParentId(getCurrentSupplierId());
			supplier.setCreateTime(new Date());
			supplier.setName(request.getParameter("companyName"));
			supplier.setFax(request.getParameter("fax"));
			if(!Common.isEmpty(request.getParameter("post"))){
				supplier.setPost( Common.stringToInteger(request.getParameter("post")));
			}
			Long  supplierId = RemoteServiceSingleton.getInstance().getSupplierManagerService().insert(supplier);
			SupplierProduct product=new SupplierProduct();
			getObjectFromRequest(product,request);
			if(supplierId>0){
				int rs= RemoteServiceSingleton.getInstance().getSupplierManagerService().register(supplierId, user, product,new SupplierPartner());
				if(rs>0){
					 LOGGER.info("注册成功：用户名："+user.getLoginName());
					 return "redirect:/subsupplier/list";
					
				}else{
					 if(getLanguage().equals("/en")){
			            	message="Server busy, please try again later!";
		             }else{
		            	message="服务器忙,请稍后再试!";	
		             }
					 LOGGER.info("注册失败：用户信息插入失败 用户名："+user.getLoginName());
					 return "redirect:/subsupplier/list?message="+message;	
				}
			}else{
				 if(getLanguage().equals("/en")){
		            message="Server busy, please try again later!";
	             }else{
	            	message="服务器忙,请稍后再试!";	
	             }
				 LOGGER.info("注册失败：商户信息插入失败 companyName："+request.getParameter("companyName"));
				 return "redirect:/subsupplier/list?message="+message;
			}
	}
	
	@RequestMapping("/subsupplier/toEditUI")
	public String toEditUI(Map<String, Object> map,Long id){
		LOGGER.info("用户："+getCurrentUser().getLoginName()+"跳转修改子供应商页面");
		Supplier supplier = RemoteServiceSingleton.getInstance().getSupplierManagerService().findSupplier(id);
        map.put("data", supplier);
        map.put("language", getLanguage().substring(1));
        SupplierProduct product=RemoteServiceSingleton.getInstance().getSupplierManagerService().getProductBySupplierId(id);
        map.put("product", product);
        SupplierUser admin =RemoteServiceSingleton.getInstance().getSupplierManagerService().findAdminUserByMerchantId(id);
        map.put("user", admin);
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
        	 if(country.getName().equals(supplier.getCountryArea())&&"/en".equals(getLanguage())){
        		 supplier.setCountryArea(country.getDescription());
        	 }
             countryNameCn.add(country.getName());
             if(country.getDescription().equals(supplier.getCountryArea())&&!"/en".equals(getLanguage())){
        		 supplier.setCountryArea(country.getName());
        	 }
             countryNameEn.add(country.getDescription());
             callingCodeCn.add(Common.isEmpty(country.getCallingcode())? "":"+"+country.getCallingcode());
        	 callingCodeEn.add(Common.isEmpty(country.getCallingcode())? "":"+"+country.getCallingcode());
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
	//	return getLanguage()+"/user/jiben";
		return getLanguage()+"/user/editSubSupplier";
	}
	@RequestMapping("/subsupplier/update")
	public String updateSupplier(Map<String,Object> map ,HttpServletRequest request,
			Supplier supplier, SupplierProduct product,String phoneCode){
		
		LOGGER.info("用户："+getCurrentUser().getLoginName()+"更新商户基本信息");
		
		
		String message="";
		MultipartFile myfile =null;
		MultipartFile myfile1=null;
		if(request instanceof MultipartRequest){
			MultipartHttpServletRequest multiRequest=(MultipartHttpServletRequest)request;
			myfile=multiRequest.getFile("myfile"); 
			myfile1=multiRequest.getFile("myfile1"); 
		}
		if(null!=myfile&&!Common.isEmpty(myfile.getOriginalFilename())){ 
    		String myfileUrl="";
			try {
				myfileUrl = UploadFileUtil.uploadFile(myfile.getInputStream(),
						Common.getFileExt2(myfile.getOriginalFilename()), null);
			} catch (Exception e) {
				LOGGER.error("资质文件上传文件服务器失败：源文件:"+myfile.getName()+"生成文件路径:"+myfileUrl);
				 if(getLanguage().equals("/en")){
		            message="Server busy, please try again later!";
	             }else{
	            	message="服务器忙,请稍后再试!";	
	             }
				 return "redirect:/subsupplier/list?message="+message;
			}
        	supplier.setCompanyLegitimacyUrl(myfileUrl);
        } 
		if(null!=myfile1&&!Common.isEmpty(myfile1.getOriginalFilename())){
			String myfile1Url="";
			try {
				myfile1Url = UploadFileUtil.uploadFile(myfile1.getInputStream(),
						Common.getFileExt2(myfile1.getOriginalFilename()), null);
			} catch (Exception e) {
				LOGGER.error("详情文件上传文件服务器失败：源文件:"+myfile1.getName()+"生成文件路径:"+myfile1Url);
				 if(getLanguage().equals("/en")){
		            message="Server busy, please try again later!";
	             }else{
	            	message="服务器忙,请稍后再试!";	
	             }
				 return "redirect:/subsupplier/list?message="+message;
			}
			supplier.setCompanyDetailedUrl(myfile1Url);
		}
		supplier.setCompanyNature(Constants.SUB_SUPPLIER);
		//supplier.setPost(null==supplier.getPost()?0:supplier.getPost());
		supplier.setPhone(phoneCode+supplier.getPhone());
		product.setSupplierId(supplier.getSupplierId());
		
		if(!Common.isEmpty(request.getParameter("companyName"))){
			supplier.setName(request.getParameter("companyName"));
		}
		if(!Common.isEmpty(request.getParameter("post"))){
			supplier.setPost( Common.stringToInteger(request.getParameter("post")));
		}
		
		SupplierUser user=new SupplierUser();
		user.setUserId(Long.valueOf(request.getParameter("userId")));
		user.setLoginName(request.getParameter("loginName").trim());;
		//getObjectFromRequest(user,request);
		user.setPassword(MD5.encrypt(request.getParameter("password").trim()));
		int result =RemoteServiceSingleton.getInstance().getSupplierManagerService().updateSupplierBaseInfo(supplier, product,user);
		if(result>0){
			LOGGER.info("用户："+getCurrentUser().getLoginName()+"更新商户基本信息成功");
		     return "redirect:/subsupplier/list";
    	}
		else{
			LOGGER.error("用户："+getCurrentUser().getLoginName()+"更新商户基本信息失败！");
			 if(getLanguage().equals("/en")){
		            message="Update SubSupplier BaseInfo Faild!";
	             }else{
	            	message="更新子供应商信息失败!";	
	             }
				 return "redirect:/subsupplier/list?message="+message;
		}
		
	}
	@RequestMapping("/subsupplier/toViewUI")
	public String toViewUI(Map<String, Object> map,Long id){
		LOGGER.info("用户："+getCurrentUser().getLoginName()+"跳转查看子供应商页面");
		Supplier supplier = RemoteServiceSingleton.getInstance().getSupplierManagerService().findSupplier(id);
        map.put("data", supplier);
        map.put("language", getLanguage().substring(1));
        SupplierProduct product=RemoteServiceSingleton.getInstance().getSupplierManagerService().getProductBySupplierId(id);
        map.put("product", product);
        SupplierUser admin =RemoteServiceSingleton.getInstance().getSupplierManagerService().findAdminUserByMerchantId(id);
        map.put("user", admin);
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
        	 if(country.getName().equals(supplier.getCountryArea())&&"/en".equals(getLanguage())){
        		 supplier.setCountryArea(country.getDescription());
        	 }
            
             if(country.getDescription().equals(supplier.getCountryArea())&&!"/en".equals(getLanguage())){
        		 supplier.setCountryArea(country.getName());
        	 }
             countryNameCn.add(country.getName());
             countryNameEn.add(country.getDescription());
             callingCodeCn.add(Common.isEmpty(country.getCallingcode())? "":"+"+country.getCallingcode());
        	 callingCodeEn.add(Common.isEmpty(country.getCallingcode())? "":"+"+country.getCallingcode());
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
		return getLanguage()+"/user/viewSubSupplier";
	}
	
	@RequestMapping("/subsupplier/delete")
	@ResponseBody
	public String delete(Long id){
		int rs=0;
		try {
			RemoteServiceSingleton.getInstance().getSupplierManagerService().deleteALL(id);
			rs=1;
		} catch (Exception e) {
		 	LOGGER.error("deleteALL！id="+id,e);
		}
		return rs+"";
	}
	
}
