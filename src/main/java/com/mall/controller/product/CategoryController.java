package com.mall.controller.product;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.mall.category.po.Brand;
import com.mall.category.po.CategoryBrand;
import com.mall.category.po.MoneyUnit;
import com.mall.category.po.SubBrand;
import com.mall.category.po.TcCountry;
import com.mall.category.po.TcMeasure;
import com.mall.category.po.TdCatePub;
import com.mall.category.po.TdCatePubAttr;
import com.mall.category.po.TdCatePubAttrval;
import com.mall.controller.base.BaseController;
import com.mall.customer.model.ProductCostPriceSetting;
import com.mall.dealer.product.po.LimitNum;
import com.mall.merchant.proxy.RemoteServiceSingleton;
import com.mall.supplier.model.Supplier;
import com.mall.supplier.model.SupplierBrandDTO;
import com.mall.utils.Constants;

/**
 * 获取类目及对应的属性.
 * @author xusq
 */
@Controller
public class CategoryController extends BaseController {
	
	/**
	 * logger.
	 */
	private static final Logger LOGGER = Logger.getLogger(CategoryController.class);
	/**
	 * 进入选择目录页.
	 * @return
	 */
	@RequestMapping("/product/selectCategory")
	public String toSelectCategoryUI(Model model,String info){
		LOGGER.info("findTopCategory!!!supplierId:"+getCurrentSupplierId());
		List<TdCatePub> list = new ArrayList<TdCatePub>();
			try {
				
//				if(Constants.SUB_SUPPLIER.equals(getSupplierType())){
//					list = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getFilterTopCategoryList(getBrandsBySubSupplierId());
//				} else {
//					list = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getFilterTopCategoryList(getBrandsBySupplierId());
//				}
				//查询所有的有效类目
				list = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getFirstCategoryList();
			} catch (Exception e) {
				LOGGER.error("获取类目失败！！！"+e.getMessage(),e);
			}
		if(null != list && list.size() > 0){
			LOGGER.info(JSON.toJSONString(list));
			List<Map<String, String>> categorys = new ArrayList<Map<String,String>>();
			for (TdCatePub tdCatePub : list) {
				Map<String, String> catePub = new LinkedHashMap<String, String>();
				catePub.put("cid", tdCatePub.getCatePubId());
				catePub.put("nameCn", tdCatePub.getPubNameCn());
				catePub.put("name", tdCatePub.getPubName());
				catePub.put("leaf", tdCatePub.getLeaf()+"");
				categorys.add(catePub);
			}
			model.addAttribute("categorys", categorys);
			
		}
		if(info!=null){
			model.addAttribute("a", "1");
		}
		return getLanguage()+"/product/categoryUI";
	}
	
	@RequestMapping("/product/selectCategory2")
	public String toSelectCategoryUI2(Model model){
		LOGGER.info("findTopCategory!!!supplierId:"+getCurrentSupplierId());
		List<TdCatePub> list = new ArrayList<TdCatePub>();
			try {
				
//				if(Constants.SUB_SUPPLIER.equals(getSupplierType())){
//					list = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getFilterTopCategoryList(getBrandsBySubSupplierId());
//				} else {
//					list = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getFilterTopCategoryList(getBrandsBySupplierId());
//				}
				//查询所有的有效类目
				list = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getFirstCategoryList();
			} catch (Exception e) {
				LOGGER.error("获取类目失败！！！"+e.getMessage(),e);
			}
		if(null != list && list.size() > 0){
			LOGGER.info(JSON.toJSONString(list));
			List<Map<String, String>> categorys = new ArrayList<Map<String,String>>();
			for (TdCatePub tdCatePub : list) {
				Map<String, String> catePub = new LinkedHashMap<String, String>();
				catePub.put("cid", tdCatePub.getCatePubId());
				catePub.put("nameCn", tdCatePub.getPubNameCn());
				catePub.put("name", tdCatePub.getPubName());
				catePub.put("leaf", tdCatePub.getLeaf()+"");
				categorys.add(catePub);
			}
			model.addAttribute("categorys", categorys);
			
		}
		return getLanguage()+"/product/cateXfg";
	}
	
	/**
	 * 显示子目录.
	 * @param response HttpServletResponse
	 * @param parentCid categoryId
	 */
	@RequestMapping("/product/childCategory")
	public void childCategory(HttpServletResponse response,String parentCid){
		LOGGER.info("findChildCategory!!!supplierId:"+getCurrentSupplierId()+";parentCid:"+parentCid);
		response.setContentType("text/html;charset=UTF-8");
		List<TdCatePub> childrenCategoryList = new ArrayList<TdCatePub>();
			try {
				Object json = "[]";
				if(RemoteServiceSingleton.getInstance().getCategoryServiceRpc()!=null){
					
//					if(Constants.SUB_SUPPLIER.equals(getSupplierType())){
//						childrenCategoryList = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getFilterChildrenCategoryList(parentCid,getBrandsBySubSupplierId());
//					} else
//						childrenCategoryList = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getFilterChildrenCategoryList(parentCid,getBrandsBySupplierId());
//					}
					//查询所有有效类目
					childrenCategoryList = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getFirstChildrenCategoryList(parentCid);
				}
			
				if(null != childrenCategoryList){
					List<Map<String, String>> categorys = new ArrayList<Map<String,String>>();
					for (TdCatePub tdCatePub : childrenCategoryList) {
						Map<String, String> catePub = new LinkedHashMap<String, String>();
						catePub.put("cid", tdCatePub.getCatePubId());
						catePub.put("nameCn", tdCatePub.getPubNameCn());
						catePub.put("name", tdCatePub.getPubName());
						catePub.put("leaf", tdCatePub.getLeaf()+"");
						categorys.add(catePub);
					}
					
					json = JSONArray.toJSON(categorys);
					LOGGER.info(json.toString());
					response.getWriter().write(json.toString());
				}
			} catch (Exception e1) {
				LOGGER.error("获取子类目失败"+e1.getMessage(),e1);
			}
		
	}
	
	
	
	/**
	 *  发布商品页.
	 * @param model model
	 * @param cid categoryid
	 * @return String
	 */
	@RequestMapping("/product/toCreateUI")
	public String toProductUI(HttpServletRequest request,Model model,String cid){
		LOGGER.info("toCreateProductUI!!!supplierId:"+getCurrentSupplierId()+";categoryId:"+cid);
		TdCatePub catePub = new TdCatePub();
		List<TcMeasure> allMeasure = new ArrayList<TcMeasure>();
		List<TcCountry> countries = new ArrayList<TcCountry>();
		List<TdCatePub> cateNames = new ArrayList<TdCatePub>();
		List<MoneyUnit> momeyUnits = new ArrayList<MoneyUnit>();
        ProductCostPriceSetting pcp = null;
        List<ProductCostPriceSetting> findProductCostPriceSettingAll=null;
		try {
			
            pcp = RemoteServiceSingleton.getInstance().getProductCostPriceSettingService().findProductCostPriceSetting();
            findProductCostPriceSettingAll = RemoteServiceSingleton.getInstance().getProductCostPriceSettingService().findProductCostPriceSettingAll2();
            catePub = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().selectByPrimaryKey(cid);
            String DispId = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getCatePubDispIdByCatePubId(cid);
            catePub.setCatePubDispId(DispId);
            allMeasure = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().findAllMeasure();
            cateNames = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getCategoryNameByDigui(cid);
            countries = RemoteServiceSingleton.getInstance().getBaseDataServiceRpc().getTcCountries();
            momeyUnits = RemoteServiceSingleton.getInstance().getBaseDataServiceRpc().getMomeyUnits();
        } catch (Exception e) {
            LOGGER.error("根据类目加载属性属性值失败！！！"+e.getMessage(),e);
        }


//		Set<TdCatePubAttr> keySet = categoryAttrAndValList.keySet();
		
//		List<String> buyAttrName = new ArrayList<String>();
//		List<String> saleAttrName = new ArrayList<String>();
//		
//		for (TdCatePubAttr tdCatePubAttr : keySet) {
//			if(tdCatePubAttr.getBuyAttr()==1){
//				String buyAttrNameCn = tdCatePubAttr.getLineAttrNameCn();
//				String buyAttrNameEn = tdCatePubAttr.getLineAttrName();
//				buyAttrName.add(0, buyAttrNameCn);
//				buyAttrName.add(1, buyAttrNameEn);
//			}
//			if(tdCatePubAttr.getSaleAttr()==1){
//				String saleAttrNameCn = tdCatePubAttr.getLineAttrNameCn();
//				String saleAttrNameEn = tdCatePubAttr.getLineAttrName();
//				saleAttrName.add(0, saleAttrNameCn);
//				saleAttrName.add(1, saleAttrNameEn);
//				
//			}
//			
//		}
		Supplier supplier = getSupplier();
//		model.addAttribute("buyAttrName", buyAttrName);
//		model.addAttribute("saleAttrName", saleAttrName);
		model.addAttribute("price", momeyUnits);
		model.addAttribute("countries", countries);
		model.addAttribute("cateNames", cateNames);
		model.addAttribute("measure", allMeasure);
		model.addAttribute("catePub", catePub);
//		model.addAttribute("attrList", categoryAttrAndValList);
		model.addAttribute("language", getLanguage().substring(1));
		model.addAttribute("stime", System.currentTimeMillis());
		model.addAttribute("supplierType", getSupplierType());
		if(supplier.getOrganizationType()==null){
			model.addAttribute("costPriceMultiple", pcp.getCostPriceMultiple());
		}
		if(supplier.getOrganizationType()!=null && supplier.getOrganizationType()==6){
			model.addAttribute("costPriceMultiple", pcp.getCostPriceMultiple());
		}
		
		
		if(supplier.getOrganizationType()!=null && supplier.getOrganizationType()==5){
			//家庭号目前发布的商品
			int productCount = RemoteServiceSingleton.getInstance().getSupplierProductService().productCount(supplier.getSupplierId());
			//规定的最大发布数量
			try {
				int maxSetting = RemoteServiceSingleton.getInstance().getSqwAccountRecordService().getMaxSetting();
				if(productCount>=maxSetting){
					System.out.println("不能发布啦");
					return "redirect:/product/onSaleList";
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			model.addAttribute("costPriceMultiple", findProductCostPriceSettingAll.get(0).getCostPriceMultiple());
		
			return getLanguage()+"/product/addProductUI2";
		}
		return getLanguage()+"/product/addProductUI";
	}
	
	
	
	
	/**
	 * 发布幸福购商品
	 * @param request
	 * @param model
	 * @param cid
	 * @return
	 */
	@RequestMapping("/product/toCreateUIXf")
	public String toProductUI2(HttpServletRequest request,Model model,String cid){
		LOGGER.info("toCreateProductUI!!!supplierId:"+getCurrentSupplierId()+";categoryId:"+cid);
		TdCatePub catePub = new TdCatePub();
		List<TcMeasure> allMeasure = new ArrayList<TcMeasure>();
		List<TcCountry> countries = new ArrayList<TcCountry>();
		List<TdCatePub> cateNames = new ArrayList<TdCatePub>();
		List<MoneyUnit> momeyUnits = new ArrayList<MoneyUnit>();
        
        List<ProductCostPriceSetting> findProductCostPriceSettingAll=null;
		try {
			List<LimitNum> selectNum = RemoteServiceSingleton.getInstance().getDealerProductService().selectNum();
        	LimitNum limitNum = selectNum.get(0);
        	if(limitNum!=null)
        	{
        		model.addAttribute("limitNum", limitNum.getMaxNum());
        	}
			
            
            findProductCostPriceSettingAll = RemoteServiceSingleton.getInstance().getProductCostPriceSettingService().findProductCostPriceSettingAll3();
            catePub = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().selectByPrimaryKey(cid);
            String DispId = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getCatePubDispIdByCatePubId(cid);
            catePub.setCatePubDispId(DispId);
            allMeasure = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().findAllMeasure();
            cateNames = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getCategoryNameByDigui(cid);
            countries = RemoteServiceSingleton.getInstance().getBaseDataServiceRpc().getTcCountries();
            momeyUnits = RemoteServiceSingleton.getInstance().getBaseDataServiceRpc().getMomeyUnits();
            
        } catch (Exception e) {
            LOGGER.error("根据类目加载属性属性值失败！！！"+e.getMessage(),e);
        }


//		Set<TdCatePubAttr> keySet = categoryAttrAndValList.keySet();
		
//		List<String> buyAttrName = new ArrayList<String>();
//		List<String> saleAttrName = new ArrayList<String>();
//		
//		for (TdCatePubAttr tdCatePubAttr : keySet) {
//			if(tdCatePubAttr.getBuyAttr()==1){
//				String buyAttrNameCn = tdCatePubAttr.getLineAttrNameCn();
//				String buyAttrNameEn = tdCatePubAttr.getLineAttrName();
//				buyAttrName.add(0, buyAttrNameCn);
//				buyAttrName.add(1, buyAttrNameEn);
//			}
//			if(tdCatePubAttr.getSaleAttr()==1){
//				String saleAttrNameCn = tdCatePubAttr.getLineAttrNameCn();
//				String saleAttrNameEn = tdCatePubAttr.getLineAttrName();
//				saleAttrName.add(0, saleAttrNameCn);
//				saleAttrName.add(1, saleAttrNameEn);
//				
//			}
//			
//		}
		
//		model.addAttribute("buyAttrName", buyAttrName);
//		model.addAttribute("saleAttrName", saleAttrName);
		model.addAttribute("price", momeyUnits);
		model.addAttribute("countries", countries);
		model.addAttribute("cateNames", cateNames);
		model.addAttribute("measure", allMeasure);
		model.addAttribute("catePub", catePub);
//		model.addAttribute("attrList", categoryAttrAndValList);
		model.addAttribute("language", getLanguage().substring(1));
		model.addAttribute("stime", System.currentTimeMillis());
		model.addAttribute("supplierType", getSupplierType());
		model.addAttribute("costPriceMultiple", findProductCostPriceSettingAll.get(0).getCostPriceMultiple());
		
		
	
		return getLanguage()+"/product/UIXf";
	}
	/**
	 * 获取所有品牌
	 * @param cid
	 * @return
	 */
	@RequestMapping("/product/getBrands")
	@ResponseBody
	public String getTopBrands(String cid){
		LOGGER.info("getChildBrands!!!categoryId:"+cid+";supplierId:"+getCurrentSupplierId());
		List<Brand> onlyBrand=new ArrayList<Brand>();
		try {
			onlyBrand = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getBrandList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return JSONArray.toJSONString(onlyBrand);
	}
	
	
	@RequestMapping("/product/getBrands_old")
	@ResponseBody
	public String getTopBrands_old(String cid){
		LOGGER.info("getChildBrands!!!categoryId:"+cid+";supplierId:"+getCurrentSupplierId());
		List<Brand> brands = new ArrayList<Brand>();
		
		List<CategoryBrand> brandIds = new ArrayList<CategoryBrand>();
		try {
			
			
			
			if(Constants.SUB_SUPPLIER.equals(getSupplierType())){
				List<CategoryBrand> brandIds0 = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getBrandlistByCategoryId(cid);
				
				List<SupplierBrandDTO> supplierBrands = new ArrayList<SupplierBrandDTO>();
				
				supplierBrands = RemoteServiceSingleton.getInstance().getSupplierBrandManagerService().findSupplierBrandsBySubSupplierId(getCurrentSupplierId());
				
				for (SupplierBrandDTO supplierBrandDTO : supplierBrands) {
					Long systemBrandId = supplierBrandDTO.getSystemBrandId();
					if(null != systemBrandId  && 0 != systemBrandId ){
						for(CategoryBrand cB : brandIds0) {
							if(cB.getBrandId().equals(systemBrandId+"")){
								CategoryBrand categoryBrand = new CategoryBrand();
								categoryBrand.setCatePubId(cid);
								categoryBrand.setBrandId(""+systemBrandId);
								brandIds.add(categoryBrand);	
							}
						}
					}
				}
			} else {
				
				List<CategoryBrand> brandIds0 = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getBrandlistByCategoryId(cid);
				
				List<SupplierBrandDTO> supplierBrands = new ArrayList<SupplierBrandDTO>();
				
				supplierBrands = RemoteServiceSingleton.getInstance().getSupplierBrandManagerService().findSupplierBrandsBySupplierId(getCurrentSupplierId());
				
				for (SupplierBrandDTO supplierBrandDTO : supplierBrands) {
					Long systemBrandId = supplierBrandDTO.getSystemBrandId();
					if(null != systemBrandId  && 0 != systemBrandId ){
						for(CategoryBrand cB : brandIds0) {
							if(cB.getBrandId().equals(systemBrandId+"")){
								CategoryBrand categoryBrand = new CategoryBrand();
								categoryBrand.setCatePubId(cid);
								categoryBrand.setBrandId(""+systemBrandId);
								brandIds.add(categoryBrand);	
							}
						}
					}
				}
				
			} 
			

			
  			for (CategoryBrand cBrand : brandIds) {
				Brand brand = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getBrandByID(cBrand.getBrandId());
				if(null!=brand){
					brands.add(brand);		
				}
			}
  			
		} catch (Exception e) {
			LOGGER.error("获取主品牌失败！！！"+e.getMessage(),e);
		}
		
		List<Brand> onlyBrand = new ArrayList<Brand>();
		if(null != brands && brands.size() > 0){
			onlyBrand = removeDuplicate(brands);
		}
		
		
		return JSONArray.toJSONString(onlyBrand);
	}
	
	
	/**
	 * 品牌去重
	 * @param list
	 * @return
	 */
	private  List<Brand> removeDuplicate(List<Brand> list) {
        Set<Brand> set = new HashSet<Brand>();
        List<Brand> newList = new ArrayList<Brand>();
        for (Iterator<Brand> iter = list.iterator(); iter.hasNext();) {
        	Brand element = iter.next();
            if (set.add(element))
                newList.add(element);
        }
        return newList;
    }

	
	
	/**
	 * @param brandId brandId.
	 * @return String
	 */
	@RequestMapping("/product/getOtherBrand")
	@ResponseBody
	public String getOtherBrand(String brandId){
		LOGGER.info("getBrands!!!brandId:"+brandId+";supplierId:"+getCurrentSupplierId());
		List<SubBrand> subBrand = new ArrayList<SubBrand>();
		try {
			subBrand = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getSubBrandListByBrandId(brandId);
		} catch (Exception e) {
			LOGGER.error("获取子品牌失败！！！"+e.getMessage(),e);
		}
		return  JSONArray.toJSONString(subBrand);
	}
	/**
	 * 保存校验品牌
	 * @param brandId brandId.
	 * @return String
	 */
	@RequestMapping("/product/checkBrand")
	@ResponseBody
	public String checkBrand(String brandId,String brandName){
		LOGGER.info("getBrands!!!brandId:"+brandId+";supplierId:"+getCurrentSupplierId());
		String flag="0";	
		try {
			Brand brandDto = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getBrandByID(brandId);
			String nameCn = brandDto.getNameCn();
			if(nameCn.equals(brandName)){
				flag="1";
			}
		} catch (Exception e) {
			LOGGER.error("获取品牌失败！！！"+e.getMessage(),e);
		}
		return flag;
	}
	
/*	*//**
	 * @param brandId brandId.
	 * @return String
	 *//*
	@RequestMapping("/product/getOtherSubBrand")
	@ResponseBody
	public String getOtherSubBrand(String brandId){
		LOGGER.info("getBrands!!!brandId:"+brandId+";supplierId:"+getCurrentSupplierId());
		List<SubBrand> subBrand = new ArrayList<SubBrand>();
		try {
			subBrand = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getSubBrandListByBrandId(brandId);
		} catch (Exception e) {
			LOGGER.error("获取子品牌失败！！！"+e.getMessage(),e);
		}
		return  JSONArray.toJSONString(subBrand);
	}*/
	
	

}
