package com.mall.controller.brand;

import java.io.ByteArrayInputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.csource.upload.UploadFileUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.mall.architect.logging.Log;
import com.mall.architect.logging.LogFactory;
import com.mall.category.api.own.MyBrandService;
import com.mall.category.po.Brand;
import com.mall.controller.base.BaseController;
import com.mall.customer.order.dto.prize.PrizeRecordDto;
import com.mall.merchant.proxy.RemoteServiceSingleton;
import com.mall.mybatis.utility.PageBean;
import com.mall.supplier.model.Supplier;
import com.mall.supplier.model.SupplierBrand;
import com.mall.supplier.model.SupplierBrandDTO;
import com.mall.utils.Constants;

import org.apache.commons.lang.StringUtils;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 品牌管理
 * @author xusq
 *
 */
@Controller
public class BrandMangerController extends BaseController {

	private static final Log LOGGER = LogFactory.getLogger(BrandMangerController.class);
	@Resource(name="myBrandService")
	private MyBrandService myBrandService;

	@RequestMapping(value="/brand/getBrand")
	public String getBrandPafe(){
		 return getLanguage() + "/brand/brand";
	}
	
	@RequestMapping(value="/brand/getBrandModel")
	public String toBrandUI(Model model,PageBean<SupplierBrandDTO> pageBean){
		
		LOGGER.info("加载供应商品牌信息！");
		
		SupplierBrandDTO brand = new SupplierBrandDTO();
		brand.setSupplierId(getCurrentSupplierId());
		
		pageBean.setParameter(brand);
		pageBean.setSortFields("brand_id");
		pageBean.setOrder("desc");
		
		
		
		PageBean<SupplierBrandDTO> pageList = new PageBean<SupplierBrandDTO>();
				
			try {
				
				pageList = RemoteServiceSingleton.getInstance().getSupplierBrandManagerService().getBrandsPageList(pageBean);
				
			} catch (Exception e) {
				
				LOGGER.error("查询品牌信息失败！！！supplierId:"+getCurrentSupplierId()+e.getMessage(), e);
			}
		
		model.addAttribute("pb", pageList);
		model.addAttribute("supplierType", getSupplierType());
		
		return  getLanguage() + "/brand/modelPage/brandModel";
	}

	@RequestMapping(value = "/brand/findBrandByCondition")
	public String findBrandByCondition(HttpServletRequest request,HttpServletResponse response, Integer page,Model model,com.ccigmall.mybatis.dwz.utility.PageBean<Brand> pageBean,String name_cn) {
		LOGGER.info("调用查询品牌列表findBrandByCondition");
		try {
			//收集参数
			Brand brand = new Brand();
			brand.setNameCn(name_cn);
//			pageBean.setOrderField("brand_id");
//			pageBean.setOrderDirection("desc");
			pageBean.setParameter(brand);
			pageBean.setNumPerPage(Constants.PAGESIZE);
			if (page != null && page != 0) {
				pageBean.setPageNum(page);
			} else {
				pageBean.setPageNum(1);
			}
			// 调用接口查询品牌
			com.ccigmall.mybatis.dwz.utility.PageBean<Brand> pageList = new com.ccigmall.mybatis.dwz.utility.PageBean<Brand>();
			pageBean=myBrandService.getSearchBrandListPage(pageBean);
			//pageList = RemoteServiceSingleton.getInstance().getSupplierBrandManagerService().getBrandsPageList(pageBean);
			request.getSession().setAttribute("pb", pageBean);
			request.getRequestDispatcher("/WEB-INF/views/zh/brand/modelPage/brandListModel.jsp").forward(request, response);
		} catch (Exception e) {
			LOGGER.error("查询品牌信息失败！！！supplierId:"+getCurrentSupplierId()+e.getMessage(), e);
		}
		return null;
	}

	@RequestMapping("/brand/toAddUI")
	public String add(Model model){
		
		
		model.addAttribute("language", getLanguage().substring(1));
		return getLanguage()+"/brand/addBrand";
	}
	
	@RequestMapping("/brand/saveBrand")
	@ResponseBody
	public String save(SupplierBrand brand,String[] imgUrl,String editorValue){
		
		
		brand.setSupplierId(getCurrentSupplierId());
		brand.setCreateBy(getCurrentUser().getLoginName());
		brand.setCreateTime(new Date());
		
		StringBuilder qualification = new StringBuilder();
		
		if(null != imgUrl && imgUrl.length > 0){
			for(int i = 0;i < imgUrl.length;i++){
				if(i>0){
					qualification.append(",");
				}
				String url = imgUrl[i];
				url = url.substring(url.indexOf("group"));
				qualification.append(url);
			}
		}
		
		
		brand.setQualification(qualification.toString());
		
		
		
		String fileUrl = "";
        if (null != editorValue) {
            byte[] picByte = editorValue.getBytes();
            try {
                ByteArrayInputStream stream = new ByteArrayInputStream(picByte);
                fileUrl = UploadFileUtil.uploadFile(stream, null, null);
                LOGGER.info("品牌介绍上传成功！！！");
            } catch (Exception e) {
                LOGGER.error("品牌介绍上传失败！！！"+e.getMessage(),e);
            }
        }
		
        brand.setDescription(fileUrl);
		
		
		long insertStatus = 0L;
		try {
			insertStatus = RemoteServiceSingleton.getInstance()
					.getSupplierBrandManagerService().insertBrand(brand);
		} catch (Exception e) {
			LOGGER.error("新建品牌失败！！！brand:"+brand.toString()+e.getMessage(), e);
		}
		
		return ""+insertStatus;
	}
	
	@RequestMapping("/brand/toEditUI")
	public String edit(Long id,Model model){
		
		SupplierBrandDTO brandDto = new SupplierBrandDTO(); 
		try {
			brandDto = RemoteServiceSingleton.getInstance().getSupplierBrandManagerService().findBrandById(id);
			
		} catch (Exception e) {
			LOGGER.error("查询品牌信息失败！！！supplierId："+getCurrentSupplierId()+",brandId:"+id+e.getMessage(), e);
		}
		
		List<String> viewUrl = new ArrayList<String>();
		
		if(null != brandDto && !"".equals(brandDto.getQualification())){
			
			String qualification = brandDto.getQualification();
			String[] urls = qualification.split(",");
			
			for (String url : urls) {
				viewUrl.add(Constants.IMAGES_VIEW1+url);
			}
			
		}
		
		String description = brandDto.getDescription();
		
		if (null != description){
			if(description.indexOf("group") != -1){
				description = UploadFileUtil.DownloadFile(description);
			}
		}
		
		brandDto.setDescription(description);
		
		
		String jsonUrl = JSON.toJSONString(viewUrl);
		
		model.addAttribute("language", getLanguage().substring(1));
		model.addAttribute("brand", brandDto);
		model.addAttribute("urls", jsonUrl);
		
		return getLanguage()+"/brand/editBrand";
	}
	
	
	
	@RequestMapping("/brand/editBrand")
	@ResponseBody
	public String update(SupplierBrand brand,String[] imgUrl,String editorValue){
		

		
		brand.setSupplierId(getCurrentSupplierId());
		brand.setCreateBy(getCurrentUser().getLoginName());
		brand.setCreateTime(new Date());
		brand.setStatus(Constants.PUBLIC_STATIC_NUM_0);
		
		StringBuilder qualification = new StringBuilder();
		
		if(null != imgUrl && imgUrl.length > 0){
			for(int i = 0;i < imgUrl.length;i++){
				if(i>0){
					qualification.append(",");
				}
				String url = imgUrl[i];
				url = url.substring(url.indexOf("group"));
				qualification.append(url);
			}
		}
		
		
		brand.setQualification(qualification.toString());
		
		String fileUrl = "";
		
        if (null != editorValue) {
        	
            byte[] picByte = editorValue.getBytes();
            
            try {
            	
                ByteArrayInputStream stream = new ByteArrayInputStream(picByte);
                fileUrl = UploadFileUtil.uploadFile(stream, null, null);
                LOGGER.info("品牌介绍上传成功！！！");
                
            } catch (Exception e) {
                LOGGER.error("品牌介绍上传失败！！！"+e.getMessage(),e);
            }
        }
		
        brand.setDescription(fileUrl);
		
		
		
		long insertStatus = 0L;
		
		
		try {
			
			
			insertStatus = RemoteServiceSingleton.getInstance()
					.getSupplierBrandManagerService().updateBrand(brand);
			
			
		} catch (Exception e) {
			LOGGER.error("新建品牌失败！！！brand:"+brand.toString()+e.getMessage(), e);
		}
		
		return ""+insertStatus;
	}
	
	
	@RequestMapping("/brand/delete")
	@ResponseBody
	public String delete(Long id,Model model){
		int isSuccess = 1;
		try {
			isSuccess = RemoteServiceSingleton.getInstance().getSupplierBrandManagerService().delete(id);
		} catch (Exception e) {
			LOGGER.error("删除品牌信息失败！！！BrandId："+id+e.getMessage(), e);
		}
		
		return "" + isSuccess;
	}
	
	@RequestMapping("/brand/bind")
	@ResponseBody
	public String bind(Long brandId,Long subSupplier,Model model){
		SupplierBrand supplierBrand = new SupplierBrand();
		supplierBrand.setBrandId(brandId);
		supplierBrand.setSubSupplierId(subSupplier);
		int updateStatus = 0;
		try {
			updateStatus = RemoteServiceSingleton.getInstance().getSupplierBrandManagerService().updateBrand(supplierBrand );
		} catch (Exception e) {
			LOGGER.error("绑定品牌信息失败！！！", e);
		}
		return ""+updateStatus;
	}
	
	@RequestMapping("/brand/getSubSupplier")
	@ResponseBody
	public String subSupplier(Model model){
		List<Supplier> subSupplers = RemoteServiceSingleton.getInstance().getSupplierManagerService().getSubSuppliersByPid(getCurrentSupplierId());
		
		
		String sub = JSON.toJSONString(subSupplers);
		LOGGER.info(sub);
		return sub;
	}
	
	@RequestMapping("/brand/isExclusiveAgent")
	@ResponseBody
	public String isExclusiveAgent(String name,Model model){
		int exclusiveAgent = RemoteServiceSingleton.getInstance().getSupplierBrandManagerService().isExclusiveAgent(name);
		return "" + exclusiveAgent;
	}
}
