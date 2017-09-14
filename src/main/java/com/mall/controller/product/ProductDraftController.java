package com.mall.controller.product;

import java.io.ByteArrayInputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import net.sf.json.JSONArray;

import org.csource.upload.UploadFileUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mall.architect.logging.Log;
import com.mall.architect.logging.LogFactory;
import com.mall.category.po.Brand;
import com.mall.category.po.MoneyUnit;
import com.mall.category.po.SubBrand;
import com.mall.category.po.TcCountry;
import com.mall.category.po.TcMeasure;
import com.mall.category.po.TdCatePub;
import com.mall.category.po.TdCatePubAttr;
import com.mall.category.po.TdCatePubAttrval;
import com.mall.controller.base.BaseController;
import com.mall.merchant.proxy.RemoteServiceSingleton;
import com.mall.mybatis.utility.PageBean;
import com.mall.supplier.product.dto.SupplierProductAttrDTO;
import com.mall.supplier.product.dto.SupplierProductObjectDTO;
import com.mall.supplier.product.dto.SupplierProductSkuDTO;
import com.mall.supplier.product.exception.SupplierProException;
import com.mall.supplier.product.po.SupplierProduct;
import com.mall.supplier.product.po.SupplierProductAttach;
import com.mall.supplier.product.po.SupplierProductAttrval;
import com.mall.supplier.product.po.SupplierProductBuyAttrval;
import com.mall.supplier.product.po.SupplierProductDetail;
import com.mall.supplier.product.po.SupplierProductPrice;
import com.mall.supplier.product.po.SupplierProductSaleSetting;
import com.mall.supplier.product.po.SupplierProductSku;
import com.mall.supplier.product.po.SupplierProductSkuAttrval;
import com.mall.supplier.product.po.SupplierProductWholesaleRange;
import com.mall.utils.Common;
import com.mall.utils.Constants;
import com.mall.utils.CopyBeanUtil;
import com.mall.utils.DateUtil;
import com.mall.utils.JBarCodeUtil;
import com.mall.utils.MD5;


/**
 * 商品草稿箱
 * @author xusq
 *
 */
@Controller
public class ProductDraftController extends BaseController {

	private static final Log LOGGER = LogFactory.getLogger(ProductDraftController.class);
	
	
	/**
	 * 保存草稿信息
	 * @param objectVO
	 * @param cost
	 * @param start
	 * @param fristPhone
	 * @param subPhone
	 * @param pic
	 * @param buyIndex
	 * @param saleIndex
	 * @param productPic
	 * @param minNum
	 * @param saleVal
	 * @param buyVal
	 * @param pname
	 * @param brandId
	 * @param subBrandId
	 * @param skuCode
	 * @param barCodeImg
	 * @param imgUrl
	 * @param buyName
	 * @param saleName
	 * @param auto
	 * @param priceType
	 * @param fobPort
	 * @param cifPort
	 * @param editorValue
	 * @return
	 */
	@RequestMapping("/product/saveDraft")
	@ResponseBody
	public String saveDraft(SupplierProductObjectDTO objectVO, Integer cost, Long[] start,
            String fristPhone, String subPhone, BigDecimal[] pic,
            Integer buyIndex, Long saleIndex, BigDecimal[] productPic,
            Long minNum, Long[] saleVal, Long[] buyVal, String pname,
            String brandId, String subBrandId, String skuCode[],String[] barCodeImg,
            String[] imgUrl, String[] buyName, String[] saleName,Integer auto,Integer priceType,String fobPort,String cifPort,
            String editorValue){
		LOGGER.info("修改草稿！！！supplierId:"+getCurrentSupplierId());
		 /**  
         * 设置展示属性的图片url
         */
        String issavestatuinfo = null;

        try {
        	
        	
        	List<SupplierProductAttach> attachs = new ArrayList<SupplierProductAttach>();
        	
        	
        	List<String> BuyAttrValUrl = new ArrayList<String>();
        	
        	
        	List<Integer> buyMap = new ArrayList<Integer>();
            Map<Integer, List<SupplierProductBuyAttrval>> map =
                    new LinkedHashMap<Integer, List<SupplierProductBuyAttrval>>();  
        	
        	if(null != imgUrl && imgUrl.length > 0){
        		
	        	/**
	        	 * 设置商品资质
	        	 */
	        	
	        	 for (int x = 0; x < imgUrl.length; x++) {
	        		 
	                 String[] prodImg = imgUrl[x].split("_");
	                 StringBuffer sb = new StringBuffer();
	                 for (int i = 1; i < prodImg.length; i++) {
	                     if (i > 1) {
	                         sb.append("_");
	                     }
	                     sb.append(prodImg[i]);
	                 } 
	                 
	                 if("00".equals(prodImg[0])){
	                	 
	                	 SupplierProductAttach prodQualification = new SupplierProductAttach();
	                	 String qualification = sb.toString();
	                	 qualification = qualification.substring(qualification.indexOf("group"));
	                	 prodQualification.setFileurl(qualification);
	                	 prodQualification.setType(Constants.PRODUCT_QUALIFICATION);
	                	 attachs.add(prodQualification);
	                	 
	                 } else {
	                	 BuyAttrValUrl.add(imgUrl[x]);
	                 }
	                 
	        	 }
	        	
	            
	            if (BuyAttrValUrl != null && BuyAttrValUrl.size() > 0) {
	                for (int x = 0; x < BuyAttrValUrl.size(); x++) {
	                    String[] split = BuyAttrValUrl.get(x).split("_");
	                    Integer index = Integer.parseInt(split[0]);
	                    buyMap.add(index);
	
	                    List<SupplierProductBuyAttrval> list = map.get(index);
	
	                    if (list != null && list.size() > 0) {
	                        SupplierProductBuyAttrval buyAttrval = new SupplierProductBuyAttrval();
	                        StringBuffer sb = new StringBuffer();
	
	                        for (int i = 1; i < split.length; i++) {
	                            if (i > 1) {
	                                sb.append("_");
	                            }
	                            sb.append(split[i]);
	                        }
	
	                        String prodImgurl = sb.toString();
	                        prodImgurl = prodImgurl.substring(prodImgurl.indexOf("group"));
	                        buyAttrval.setIstate(Constants.PRODUCT_STATUS_SUCCESS);
	                        buyAttrval.setImgurl(prodImgurl);
	                        list.add(buyAttrval);
	
	                    } else {
	
	                        list = new ArrayList<SupplierProductBuyAttrval>();
	                        SupplierProductBuyAttrval buyAttrval = new SupplierProductBuyAttrval();
	                        StringBuffer sb = new StringBuffer();
	                        for (int i = 1; i < split.length; i++) {
	                            if (i > 1) {
	                                sb.append("_");
	                            }
	                            sb.append(split[i]);
	                        }
	
	                        String prodImgurl = sb.toString();
	                        prodImgurl = prodImgurl.substring(prodImgurl.indexOf("group"));
	                        buyAttrval.setIstate(Constants.PRODUCT_STATUS_SUCCESS);
	                        buyAttrval.setImgurl(prodImgurl);
	                        list.add(buyAttrval);
	                        map.put(index, list);
	                    }
	                }
	            } else {
	                LOGGER.error("展示属性图片为空！！！");
	                throw new Exception("展示属性图片为空！！！");
	            }
            
        	}

            /**
             * 商品基本信息
             */
            objectVO.getSupplierProductBase().setProductname(pname);
            objectVO.getSupplierProductBaseEn().setProductname(pname);

            
            LOGGER.info("insertSkuInfo!!!");
            /**
             * sku信息
             */
            List<SupplierProductSkuDTO> productSkuVOs = new ArrayList<SupplierProductSkuDTO>();
            SupplierProductSaleSetting productSaleSetting = objectVO.getSupplierProductSaleSetting();
            List<SupplierProductWholesaleRange> wholesaleRanges = new ArrayList<SupplierProductWholesaleRange>();
            
            
            if(!Constants.DOMESTIC_DEALER.equals(getSupplierType())){
	            // 1按梯度家报价 2按sku报价
	            if (null != cost&&cost == 2) {
	               
	            	
	            	
	            	Integer skuSize = 0;
	            	if(null != buyVal){
	            		skuSize = buyVal.length > 0 ? buyVal.length : saleVal.length;
	            	}
	            	
	            	
	            	if (null != skuSize && skuSize > 0){
		                for (int i = 0; i < buyVal.length; i++) {
		
		                    SupplierProductSkuDTO skuVO = new SupplierProductSkuDTO();
		                    SupplierProductSku productSku = new SupplierProductSku();
		                  //TODO  
		                    String skuCodeNum = "";
		                    String barCodeImage = "";
		                    if(null!=auto&&1==auto){
		                    	skuCodeNum = JBarCodeUtil.getCreateRandom();
		                    	barCodeImage = JBarCodeUtil.getBarCodeUrl(skuCodeNum);
		                    	LOGGER.info("系统自动生成验证码："+skuCodeNum+";BarCodeUrl："+barCodeImage);
		                    } else {
		                    	
		                    	if(null != skuCode && skuCode.length > 0){
		                    		skuCodeNum = skuCode[i];
		                    	}
		                    	
		                    	if(null != barCodeImg && barCodeImg.length > 0){
		                    		barCodeImage = barCodeImg[i].substring(barCodeImg[i].indexOf("group"));
		                    	}
		                    }
		                    
		                    productSku.setSkuCode(skuCodeNum);
		                    
		                    productSku.setBarCodeImage(barCodeImage); 
		                    
		                    productSku.setCreateDate(new Date());
		                    productSku.setSaleStatus(Constants.PRODUCT_STATUS_SUCCESS);
		                    
		                  if(null != buyName && null != saleName){
		                	  
		                	  productSku.setSkuNameCn(buyName[i] + saleName[i]);
		                	  productSku.setSkuNameEn(buyName[i] + saleName[i]);
		                  }
		
		                    skuVO.setSupplierProductSku(productSku);
		                    List<SupplierProductSkuAttrval> supplierProductSkuAttrvals = 
		                            new ArrayList<SupplierProductSkuAttrval>();
		                    SupplierProductSkuAttrval buyAttrval = new SupplierProductSkuAttrval();
		                    buyAttrval.setAttrId(Long.parseLong("" + buyIndex));
		                    
		                    if(null != buyVal && buyVal.length >0){
		                    	buyAttrval.setAttrValId(buyVal[i]);
		                    	buyAttrval.setAttrvalNameCn(buyName[i]);
		                    }
		                    
		                    
		                    buyAttrval.setSupplierid(getCurrentSupplierId());
		                    
		                    supplierProductSkuAttrvals.add(buyAttrval);
		
		                    if (null != saleVal && saleVal.length > 0) {
		                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
		                        saleAttrval.setAttrId(saleIndex);
		                        saleAttrval.setAttrValId(saleVal[i]);
		                        saleAttrval.setSubsupplierid("");
		                        saleAttrval.setAttrvalNameCn(saleName[i]);
		                        supplierProductSkuAttrvals.add(saleAttrval);
		                    }
		
		                    skuVO.setSupplierProductSkuAttrvals(supplierProductSkuAttrvals);
		                    
		                    
		                    // TODO
			            	if(null != productPic && productPic.length > 0){
			            		
				                productSaleSetting
				                        .setMaxSellerPrice(Common.getMax2(productPic));
				                productSaleSetting
				                        .setMinSellerPrice(Common.getMin2(productPic));
				                productSaleSetting.setMinWholesaleQty(minNum);
			                
			
			                    SupplierProductPrice price = new SupplierProductPrice();
			                    price.setSupplierprice(productPic[i]);
			                    skuVO.setSupplierProductPriceMap(price);
			            	}
		                    productSkuVOs.add(skuVO);
		                }
	            	}
	            }
	
	            // 按照图梯度家设置价格
	            if (null != cost && cost == 1) {
	            	

	            	Integer skuSize = 0;
	            	if(null != buyVal){
	            		skuSize = buyVal.length > 0 ? buyVal.length : saleVal.length;
	            	
	            	}
	            	
	            	
	            	if (null != skuSize && skuSize > 0){
	
		                for (int i = 0; i < skuSize; i++) {
		
		                    SupplierProductSkuDTO skuVO = new SupplierProductSkuDTO();
		                    SupplierProductSku productSku = new SupplierProductSku();
		                    
		                    //TODO
		                    String skuCodeNum = "";
		                    String barCodeImage = "";
		                    if(null!=auto&&1==auto){
		                    	skuCodeNum = JBarCodeUtil.getCreateRandom();
		                    	barCodeImage = JBarCodeUtil.getBarCodeUrl(skuCodeNum);
		                    	LOGGER.info("系统自动生成验证码："+skuCodeNum+";BarCodeUrl："+barCodeImage);
		                    } else {
		                    	
		                    	if(null != skuCode && skuCode.length > 0){
		                    		skuCodeNum = skuCode[i];
		                    	}
		                    	
		                    	if(null != barCodeImg && barCodeImg.length > 0){
		                    		barCodeImage = barCodeImg[i].substring(barCodeImg[i].indexOf("group"));
		                    	}
		                    }
		                    
		                    
		                    
		                    productSku.setSkuCode(skuCodeNum);
		                    productSku.setBarCodeImage(barCodeImage); 
		                    
		                    productSku.setCreateDate(new Date());
		                    productSku.setSaleStatus(Constants.PRODUCT_STATUS_SUCCESS);
		                    productSku.setIstate(Constants.PRODUCT_STATUS_SUCCESS);
		                    
		                    if(null != buyName && null != saleName){
			                    productSku.setSkuNameCn(buyName[i] + saleName[i]);
			                    productSku.setSkuNameEn(buyName[i] + saleName[i]);
		                    }
		                    
		                    skuVO.setSupplierProductSku(productSku);
		
		                    List<SupplierProductSkuAttrval> supplierProductSkuAttrvals =
		                            new ArrayList<SupplierProductSkuAttrval>();
		
		                    SupplierProductSkuAttrval buyAttrval = new SupplierProductSkuAttrval();
		                    buyAttrval.setAttrId(Long.parseLong("" + buyIndex));
		                    
		                    if(null != buyVal && buyVal.length > 0){
		                    	buyAttrval.setAttrValId(buyVal[i]);
		                    	buyAttrval.setAttrvalNameCn(buyName[i]);
		                    }
		                    
		                    
		                    buyAttrval.setSupplierid(getCurrentSupplierId());
		                    supplierProductSkuAttrvals.add(buyAttrval);
		
		                    if (null != saleVal && saleVal.length > 0) {
		                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
		                        saleAttrval.setAttrId(saleIndex);
		                        saleAttrval.setAttrValId(saleVal[i]);
		                        saleAttrval.setSubsupplierid("");
		                        saleAttrval.setAttrvalNameCn(saleName[i]);
		                        supplierProductSkuAttrvals.add(saleAttrval);
		                    }
		
		                    skuVO.setSupplierProductSkuAttrvals(supplierProductSkuAttrvals);
		                    
		                    if(null != pic && pic.length > 0){
			                    SupplierProductPrice price = new SupplierProductPrice();
			                    price.setSupplierprice(Common.getMax2(pic));
			                    skuVO.setSupplierProductPriceMap(price);
		                    }
		                    productSkuVOs.add(skuVO);
		                }
	            	}
	                
	                
	                // 设置梯度价格
	                
	                
	                if(null != pic && pic.length > 0){
	            		
	            		productSaleSetting.setMaxSellerPrice(Common.getMax2(pic));
	            		productSaleSetting.setMinSellerPrice(Common.getMin2(pic));
	            		productSaleSetting.setMinWholesaleQty(start[0]);
	            		
	            		
		                for (int i = 0; i < pic.length; i++) {
		                	
		                	
		                    SupplierProductWholesaleRange range = new SupplierProductWholesaleRange();
		                    
		                    Long startQty = start[i] == null ? 0 : start[i];
		                    
		                    range.setStartQty(startQty);
		                    Long endQty = 0L;
		                    
		                    if (i + 1 < pic.length) {
		                    	
		                        endQty = (start[i + 1] == null ? 0 : start[i + 1])  - 1;
		                    }
		
		                    if (i == pic.length - 1) {
		                        endQty = 0L;
		                    }
		
		                    range.setEndQty(endQty);
		                    range.setDiscountType("0");
		                    range.setDiscount(pic[i] == null ? new BigDecimal(0) : pic[i]);
		                    wholesaleRanges.add(range);
		                }
	                }
	
	            }
            }
            
   
            //TODO 国内经销商不设置价格信息
            if(Constants.DOMESTIC_DEALER.equals(getSupplierType())){
            	
            	objectVO.getSupplierProduct().setProdType(Constants.PRODUCT_TYPE);
            	objectVO.getSupplierProductDetail().setPriceType(Constants.PRODUCT_PRICE_TYPE_DEALER);
            	objectVO.getSupplierProductDetail().setOrderType(Constants.PRODUCT_STATUS_SUCCESS);
            	
            	Integer skuSize  = 0;
            	if(null != buyVal){
            		skuSize = buyVal.length > 0 ? buyVal.length : saleVal.length;
            	}
            	
            	
            	if (null != skuSize && skuSize > 0){
	            	for (int i = 0; i < skuSize; i++) {
	
	                    SupplierProductSkuDTO skuVO = new SupplierProductSkuDTO();
	                    SupplierProductSku productSku = new SupplierProductSku();
	                    
	                    //TODO
	                    String skuCodeNum = "";
	                    String barCodeImage = "";
	                    if(null!=auto&&1==auto){
	                    	skuCodeNum = JBarCodeUtil.getCreateRandom();
	                    	barCodeImage = JBarCodeUtil.getBarCodeUrl(skuCodeNum);
	                    	LOGGER.info("系统自动生成验证码："+skuCodeNum+";BarCodeUrl："+barCodeImage);
	                    } else {
	                    	if(null != skuCode && skuCode.length > 0){
	                    		skuCodeNum = skuCode[i];
	                    	}
	                    	
	                    	if(null != barCodeImg && barCodeImg.length > 0){
	                    		barCodeImage = barCodeImg[i].substring(barCodeImg[i].indexOf("group"));
	                    	}
	                    }
	                    
	                    
	                    
	                    productSku.setSkuCode(skuCodeNum);
	                    productSku.setBarCodeImage(barCodeImage); 
	                    
	                    productSku.setCreateDate(new Date());
	                    productSku.setSaleStatus(Constants.PRODUCT_STATUS_SUCCESS);
	                    productSku.setIstate(Constants.PRODUCT_STATUS_SUCCESS);
	                    
	                    if(null != buyName && null != saleName ){
	                    	productSku.setSkuNameCn(buyName[i] + saleName[i]);
	                    	productSku.setSkuNameEn(buyName[i] + saleName[i]);
	                    }
	                    
	                    skuVO.setSupplierProductSku(productSku);
	
	                    List<SupplierProductSkuAttrval> supplierProductSkuAttrvals =
	                            new ArrayList<SupplierProductSkuAttrval>();
	
	                    SupplierProductSkuAttrval buyAttrval = new SupplierProductSkuAttrval();
	                    buyAttrval.setAttrId(Long.parseLong("" + buyIndex));
	                    
	                    if(null != buyVal && buyVal.length > 0 ){
	                    	buyAttrval.setAttrValId(buyVal[i]);
	                    	buyAttrval.setAttrvalNameCn(buyName[i]);
	                    }
	                    
	                    buyAttrval.setSupplierid(getCurrentSupplierId());
	                    supplierProductSkuAttrvals.add(buyAttrval);
	
	                    if (saleVal != null && saleVal.length > 0) {
	                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
	                        saleAttrval.setAttrId(saleIndex);
	                        saleAttrval.setAttrValId(saleVal[i]);
	                        saleAttrval.setSubsupplierid("");
	                        saleAttrval.setAttrvalNameCn(saleName[i]);
	                        supplierProductSkuAttrvals.add(saleAttrval);
	                    }
	
	                    skuVO.setSupplierProductSkuAttrvals(supplierProductSkuAttrvals);
	                    SupplierProductPrice price = new SupplierProductPrice();
	                    skuVO.setSupplierProductPriceMap(price);
	                    productSkuVOs.add(skuVO);
	                }
            	}
            	
            }
            
            

            //设置sku图片信息
            for (int x = 0; x < objectVO.getSupplierProductAttrDTOs().size(); x++) {
                if (objectVO.getSupplierProductAttrDTOs().get(x)
                        .getSupplierProductAttr().getBuyAttr() == 1) {
                    objectVO.getSupplierProductAttrDTOs().get(x).setMap(map);
                }
            }

            objectVO.setSupplierProductSkuDTOs(productSkuVOs);
            objectVO.setSupplierProductSaleSetting(productSaleSetting);
            
            if (!Constants.DOMESTIC_DEALER.equals(getSupplierType())){
            	objectVO.setSupplierProductWholesaleRanges(wholesaleRanges);
            }
            

            /**
             * 商品核心信息
             */
            objectVO.getSupplierProduct().setAuditReason(Constants.PRODUCT_STATUS_SUCCESS);

            objectVO.getSupplierProduct().setSuppliername(
                    getSupplier().getName());
            objectVO.getSupplierProduct().setOperator(""+getCurrentUserId());
            
            
            if (null != subBrandId && !"".equals(subBrandId)) {
            	
                try {
                    Brand firstBrand = RemoteServiceSingleton.getInstance()
                            .getCategoryServiceRpc().getBrandByID(brandId);
                    SubBrand subBrand = RemoteServiceSingleton.getInstance()
                            .getCategoryServiceRpc()
                            .getSubBrandByid(subBrandId);
                    objectVO.setBrand(firstBrand);
                    objectVO.setSubBrand(subBrand);
                    objectVO.getSupplierProduct().setBrandId(subBrandId);
                    LOGGER.info("设置品牌！！！subBrandId=" + subBrandId);
                } catch (Exception e) {
                    LOGGER.error("获取品牌失败！！！" + e.getMessage(),e);
                    throw new Exception("获取品牌失败！！！" + e.getMessage(), e);
                }
                
            } else {
            	
                try {
                    Brand firstBrand = RemoteServiceSingleton.getInstance()
                            .getCategoryServiceRpc().getBrandByID(brandId);
                    objectVO.setBrand(firstBrand);
                    objectVO.getSupplierProduct().setBrandId(brandId);
                    LOGGER.info("设置品牌！！！brandId=" + brandId);
                } catch (Exception e) {
                    LOGGER.error("获取品牌失败！！！"+e.getMessage(),e);
                    throw new Exception("获取品牌失败！！！" + e.getMessage(), e);
                }
                
            }
            
            
            objectVO.getSupplierProduct().setSupplierid(getCurrentSupplierId());
            objectVO.getSupplierProduct().setSourcetype("1");
            objectVO.getSupplierProduct().setNamemd5(MD5.encrypt(pname));

            // 设置主图
            String imageUrl = saveProdImgUrl(BuyAttrValUrl);

            objectVO.getSupplierProduct().setImageurl(imageUrl);

            /**
             * 图文详情
             */
            SupplierProductAttach attach = new SupplierProductAttach();
            String fileUrl = "";
            if (null != editorValue) {
                byte[] picByte = editorValue.getBytes();
                try {
                    ByteArrayInputStream stream = new ByteArrayInputStream(picByte);
                    fileUrl = UploadFileUtil.uploadFile(stream, null, null);
                    LOGGER.info("图文详情上传成功！！！");
                } catch (Exception e) {
                    LOGGER.error("图文详情上传失败！！！"+e.getMessage(),e);
                    throw new Exception("图文详情上传失败！！！" + e.getMessage(), e);
                }
            }

            attach.setFileurl(fileUrl);
            attach.setType(Constants.PRODUCT_DESCRIPTIONS);
            attachs.add(attach);
            objectVO.setSupplierProductAttachs(attachs);
            
            SupplierProductDetail productDetail = objectVO.getSupplierProductDetail();
            
          //设置售后电话
            String servicePhone = null;
            if (!Common.isEmpty(fristPhone)) {
                servicePhone = "39-" + fristPhone + "-" + subPhone;
                productDetail.setSalesCalls(servicePhone);
            }
            
            if(!Constants.DOMESTIC_DEALER.equals(getSupplierType())&&null!=priceType){
            	if(0==priceType){
            		productDetail.setPriceType(Constants.PRODUCT_PRICE_TYPE_FOB);
            		productDetail.setPortName(fobPort);
            	} else if(1==priceType) {
            		productDetail.setPriceType(Constants.PRODUCT_PRICE_TYPE_CIF);
            		productDetail.setPortName(cifPort);
            	} else if(2==priceType){
            		productDetail.setPriceType(Constants.PRODUCT_PRICE_TYPE_EXW);
            	} else {
            		throw new Exception("价格类型有误！！！");
            	}
            }
            
            
            
            
            

            // 去除属性值为空的属性
            //TODO
            SupplierProductObjectDTO productObjectVO = CopyBeanUtil.copy(objectVO, buyMap);
            // 标识是中文还是英文
            if ("/en".equals(getLanguage()) || "/en" == getLanguage()) {
                productObjectVO.getSupplierProduct().setMnemonicCode("2");
            } else {
                productObjectVO.getSupplierProduct().setMnemonicCode("1");
            }

            

            productObjectVO.setSupplierid(getCurrentSupplierId());
            productObjectVO.setSubsupplierid("");
            
            if (null != RemoteServiceSingleton.getInstance().getSupplierProductService()) {
                try {
                    // TODO
                	LOGGER.info("保存草稿...");
                	RemoteServiceSingleton.getInstance().getSupplierDraftProductService().saveDraftProduct(productObjectVO);   
                    LOGGER.info("保存商品草稿成功!!!");
                    issavestatuinfo = "1";

                } catch (SupplierProException e) {
                    LOGGER.error("保存商品失败！！！supplierId:"+getCurrentSupplierId()+"productName:" + pname + e.getMessage(),e);
                    issavestatuinfo = "0";
                }
            }

        } catch (Exception e) {
            LOGGER.error("商品保存出错  msg:" + e.getMessage(),e);
            issavestatuinfo = "0";
        }
        return issavestatuinfo;
	}
	
	
	
	
	
	
	 /**
     * 设置商品主图.
     * @param imgUrl
     *            imgurl
     * @return url
     */
    private String saveProdImgUrl(List<String> imgUrl) {
    	
        String imageUrl = "";
        if (null != imgUrl && imgUrl.size() > 0) {
            String[] strArr = imgUrl.get(0).split("_");
            StringBuffer buffer = new StringBuffer();
            for (int i = 1; i < strArr.length; i++) {
                if (i > 1) {
                    buffer.append("_");
                }
                buffer.append(strArr[i]);
            }
            imageUrl = buffer.toString();
            imageUrl = imageUrl.substring(imageUrl.indexOf("group"));
            LOGGER.info("设置主图imgurl:"+imageUrl);
        } else {
            LOGGER.error("设置主图失败！！！imageUrl:"+imageUrl);
        }
        return imageUrl;
    }
    
    
    
    
    /**
     * 加载草稿箱页面
     * @return
     */
    @RequestMapping("/product/draftList")
    public String toDraft(){
    	
    	return getLanguage()+"/product/draftList";
    }
    
    
    @RequestMapping("/product/getProductDrafts")
    public String draftModel(Integer page,Model model){
    	
    	if(null == page){
    		page = 1;
    	}
    	
    	PageBean<SupplierProduct>  pageBean = new PageBean<SupplierProduct>(page);
    	
    	
    	
    	SupplierProduct parameter = new SupplierProduct();
    	parameter.setSupplierid(getCurrentSupplierId());
    	
    	pageBean.setPageSize(Constants.PAGE_NUM_TEN);
    	pageBean.setPage(page);
		pageBean.setOrder("DESC");
		pageBean.setSortFields("CREATEDDATE");
	    pageBean.setParameter(parameter);
	    
    	
		PageBean<SupplierProduct> products = RemoteServiceSingleton.getInstance().getSupplierDraftProductService().findDraftProducts(pageBean);
		
		List<SupplierProduct> result = products.getResult();
		
		if(null != result && result.size() > 0 ){
			for (SupplierProduct supplierProduct : result) {
				String imgURL = supplierProduct.getImageurl();
				
				if (!imgURL.startsWith("http") || !imgURL.startsWith("Http")) {
                    imgURL = Constants.IMAGES_VIEW1 + imgURL;
                    supplierProduct.setImageurl(imgURL);
                }
			}
		}
    	
    	model.addAttribute("pb", products);
    	model.addAttribute("supplierId", getCurrentSupplierId());
    	return getLanguage()+"/product/modelPage/draftModel";
    }
    
    
    @RequestMapping("/product/deleteDraft")
    @ResponseBody
    public String deleteDraft(Long id){
    	
    	String status = "1";
    	
    	try {
			RemoteServiceSingleton.getInstance().getSupplierDraftProductService().deleteDraftProductById(id, "");
		} catch (Exception e) {
			
			status = "0";
			LOGGER.error("删除草稿信息异常！productId="+id + e.getMessage(), e);
		}
    	return status;
    }
    
    
    
    @RequestMapping("/product/toDraftEdit")
    public String toEditUI(Long productId,Model model){
    	
    	 Map<TdCatePubAttr, List<TdCatePubAttrval>> categoryAttrAndValList = new LinkedHashMap<TdCatePubAttr, List<TdCatePubAttrval>>();
         
         
         SupplierProductObjectDTO proObjVo = new SupplierProductObjectDTO();
         
         List<TcMeasure> allMeasure = new ArrayList<TcMeasure>();
         List<TcCountry> countries = new ArrayList<TcCountry>();
         List<TdCatePub> cateNames = new ArrayList<TdCatePub>();
         List<MoneyUnit> momeyUnits = new ArrayList<MoneyUnit>();
         
         try {
         	
         	
             allMeasure = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().findAllMeasure();
             
             proObjVo = RemoteServiceSingleton.getInstance().getSupplierDraftProductService().findDraftProductById(productId, "");
             
             String categoryId = proObjVo.getSupplierProduct().getCatePubId();
             
             categoryAttrAndValList = RemoteServiceSingleton.getInstance().getCategoryServiceRpc()
                     .getCategoryAttrAndValList(categoryId);
             
             countries = RemoteServiceSingleton.getInstance().getBaseDataServiceRpc().getTcCountries();
             
             cateNames = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getCategoryNameByDigui(categoryId);
             
             momeyUnits = RemoteServiceSingleton.getInstance().getBaseDataServiceRpc().getMomeyUnits();
             
             
         } catch (Exception e) {
         	
             LOGGER.error("获取商品信息失败productId"+productId+";supplierId:"+getCurrentSupplierId() + e.getMessage(),e);
             return "/error/notFind";
         }

         Long supplierid = proObjVo.getSupplierProduct().getSupplierid();
         
         Long currentSupplierId = getCurrentSupplierId();
         
         if (currentSupplierId.equals(supplierid)) {

         	ProductService serviceController = new ProductService();
         	
         	
             // 属性和属性值回显
             List<SupplierProductAttrDTO> productAttrVOs = proObjVo
                     .getSupplierProductAttrDTOs();
             List<SupplierProductAttrDTO> pageAttrs = serviceController.showAttrAndAttrVal(
                     categoryAttrAndValList, productAttrVOs);

             // 图片回显
             List<LinkedHashMap<String, Object>> imgUrl = imgShow(pageAttrs);

             JSONArray returnImgUrlAndName = JSONArray.fromObject(imgUrl);
             
             logger.info("sku图片信息："+returnImgUrlAndName.toString());

             // 价格或者sku回显
             List<SupplierProductWholesaleRange> supplierProductWholesaleRanges =
                     proObjVo.getSupplierProductWholesaleRanges();

             Map<String, Object> productPic = new LinkedHashMap<String, Object>();
             List<Long> countList = new ArrayList<Long>();
             List<BigDecimal> picList = new ArrayList<BigDecimal>();

             if (supplierProductWholesaleRanges != null && supplierProductWholesaleRanges.size() > 0) {
                 for (SupplierProductWholesaleRange supplierProductWholesaleRange : supplierProductWholesaleRanges) {
                     Long startQty = supplierProductWholesaleRange.getStartQty();
                     countList.add(startQty);
                     BigDecimal discountPic = supplierProductWholesaleRange
                             .getDiscount();
                     picList.add(discountPic);
                 }

                 productPic.put("type", 0);
                 productPic.put("start", countList);
                 productPic.put("pic", picList);
             } else {
                 // 按照sku的价格回显
                 List<Object> skusPic = serviceController.showSkuPic(proObjVo);
                 productPic.put("type", 1);
                 productPic.put("start", 0);
                 productPic.put("pic", skusPic);
             }
             JSONArray jsonProductPic = JSONArray.fromObject(productPic);
             
             logger.info("sku价格信息："+jsonProductPic.toString());

             proObjVo.setSupplierProductAttrDTOs(pageAttrs);

             // 图文详情和资质图片
             
             String fileurl = "";
             List<SupplierProductAttach> productAttachs = proObjVo.getSupplierProductAttachs();
             String attch = "";
             Long prodAttachId = 0L;
             List<String> qualification = new ArrayList<String>();
             for (SupplierProductAttach supplierProductAttach : productAttachs) {
             	if(Constants.PRODUCT_DESCRIPTIONS == supplierProductAttach.getType()){
             		fileurl = supplierProductAttach.getFileurl();
             		prodAttachId = supplierProductAttach.getProductattachid();
             		attch = UploadFileUtil.DownloadFile(fileurl);
             	}
             	
             	if(supplierProductAttach.getType() == Constants.PRODUCT_QUALIFICATION){
             		qualification.add(Constants.IMAGES_VIEW1+supplierProductAttach.getFileurl());
             	}
 			}
             
             JSONArray qualificationUrl = JSONArray.fromObject(qualification);
             

             
             //将默认日期设置为null
         	Date receiveDate = null;
         	Date deliverDate = null;
         	String[] areaAndNum = null;
             if(null != proObjVo.getSupplierProductDetail()){
            	 
             	receiveDate = proObjVo.getSupplierProductDetail().getReceiveDate();
             	deliverDate = proObjVo.getSupplierProductDetail().getDeliverDate();
             	
             	 if(DateUtil.getDateYear(receiveDate)==1999){
                  	proObjVo.getSupplierProductDetail().setReceiveDate(null);
                  }
                  if(DateUtil.getDateYear(deliverDate)==1999){
                  	proObjVo.getSupplierProductDetail().setDeliverDate(null);
                  }
                  
                  
                  String salesCalls = proObjVo.getSupplierProductDetail().getSalesCalls();
                  areaAndNum = salesCalls.split("-");
             	
             }


             JSONArray skusCode = JSONArray.fromObject(serviceController.showSkuCode(proObjVo));
             
             
             
             
             
             Set<TdCatePubAttr> keySet = categoryAttrAndValList.keySet();
             List<String> buyAttrName = new ArrayList<String>();
     		List<String> saleAttrName = new ArrayList<String>();
     		
     		for (TdCatePubAttr tdCatePubAttr : keySet) {
     			if(tdCatePubAttr.getBuyAttr()==1){
     				String buyAttrNameCn = tdCatePubAttr.getLineAttrNameCn();
     				String buyAttrNameEn = tdCatePubAttr.getLineAttrName();
     				buyAttrName.add(0, buyAttrNameCn);
     				buyAttrName.add(1, buyAttrNameEn);
     			}
     			if(tdCatePubAttr.getSaleAttr()==1){
     				String saleAttrNameCn = tdCatePubAttr.getLineAttrNameCn();
     				String saleAttrNameEn = tdCatePubAttr.getLineAttrName();
     				saleAttrName.add(0, saleAttrNameCn);
     				saleAttrName.add(1, saleAttrNameEn);
     				
     			}
     			
     		}
     		
     		
     		
	     	model.addAttribute("supplierType", getSupplierType());
	 		model.addAttribute("price", momeyUnits);
	     	model.addAttribute("prodAttachId", prodAttachId);
	     	model.addAttribute("buyAttrName", buyAttrName);
	    	model.addAttribute("saleAttrName", saleAttrName);
	        model.addAttribute("qualificationUrl", qualificationUrl);
	        model.addAttribute("cateNames", cateNames);
	        model.addAttribute("phoneNumber", areaAndNum);
	        model.addAttribute("skusCode", skusCode);
	        model.addAttribute("language", getLanguage().substring(1));
	        model.addAttribute("measure", allMeasure);
	        model.addAttribute("countries", countries);
	        model.addAttribute("attch", attch);
	        model.addAttribute("proObj", proObjVo);
	        model.addAttribute("jsonImg", returnImgUrlAndName);
	        model.addAttribute("skuPriceAndCount", jsonProductPic);
             
             return getLanguage() + "/product/editDraftProd";
         } else {
             return "/error/notFind";
         }
       
    }
    
    
    
    /**
     * 图片回显.
     * 
     * @param pageAttrs
     *            页面显示属性属性值
     * @return 图片list
     */
    public List<LinkedHashMap<String, Object>> imgShow(
            List<SupplierProductAttrDTO> pageAttrs) {

        List<LinkedHashMap<String, Object>> imgUrl = new ArrayList<LinkedHashMap<String, Object>>();
        LinkedHashMap<String, Object> imgList = null;
        List<String> urlList = null;

        for (int i = 0; i < pageAttrs.size(); i++) {

            List<SupplierProductAttrval> getSupplierProductAttrvals = pageAttrs
                    .get(i).getSupplierProductAttrvals();
            if (null != getSupplierProductAttrvals) {
                for (int j = 0; j < getSupplierProductAttrvals.size(); j++) {
                    String lineAttrvalNameCn = "";
                    if ("/en".equals(getLanguage())) {
                        lineAttrvalNameCn = getSupplierProductAttrvals.get(j)
                                .getLineAttrvalName();
                    } else {
                        lineAttrvalNameCn = getSupplierProductAttrvals.get(j)
                                .getLineAttrvalNameCn();
                    }
                    Map<Integer, List<SupplierProductBuyAttrval>> map2 = pageAttrs
                            .get(i).getMap();
                    List<SupplierProductBuyAttrval> list = new ArrayList<SupplierProductBuyAttrval>();

                    Short buyAttr = pageAttrs.get(i).getSupplierProductAttr().getBuyAttr();
                    Boolean isProdAttr = pageAttrs.get(i).getSupplierProductAttrvals().get(j).getIsProdAttr();
                    
                    if(null != buyAttr && buyAttr == 1){
	                    if (map2 != null) {
	                        list = map2.get(j);
	                        urlList = new ArrayList<String>();
	                        imgList = new LinkedHashMap<String, Object>();
	
	                        if(isProdAttr){
	                        	if (list != null && list.size() > 0) {
	                        		
		                            for (SupplierProductBuyAttrval supplierProductBuyAttrval : list) {
		                                String imgurl = Constants.IMAGES_VIEW1
		                                        + supplierProductBuyAttrval.getImgurl();
		
		                                urlList.add(imgurl);
		                            }
	                        	}
	                        	
	                        	imgList.put("1", lineAttrvalNameCn);
	                            imgList.put("2", j + "");
	                            imgList.put("3", urlList);
	                            imgUrl.add(imgList);
	                        }
	
	                   } 
                    }
                }
            }
        }
        return imgUrl;
    }
    
    
    
    @RequestMapping("/product/updateDraft")
    @ResponseBody
    public String updateDraft(SupplierProductObjectDTO objectVO, Integer cost, Long[] start,
            String fristPhone, String subPhone, BigDecimal[] pic,
            Integer buyIndex, Long saleIndex, BigDecimal[] productPic,
            Long minNum, Long[] saleVal, Long[] buyVal, String pname,
            String brandId, String subBrandId, String skuCode[],String[] barCodeImg,
            String[] imgUrl, String[] buyName, String[] saleName,Integer auto,Integer priceType,String fobPort,String cifPort,
            String editorValue){
		LOGGER.info("保存草稿！！！supplierId:"+getCurrentSupplierId());
		 /**  
         * 设置展示属性的图片url
         */
        String issavestatuinfo = null;

        try {
        	
        	
        	List<SupplierProductAttach> attachs = new ArrayList<SupplierProductAttach>();
        	
        	
        	List<String> BuyAttrValUrl = new ArrayList<String>();
        	
        	
        	List<Integer> buyMap = new ArrayList<Integer>();
            Map<Integer, List<SupplierProductBuyAttrval>> map =
                    new LinkedHashMap<Integer, List<SupplierProductBuyAttrval>>();  
        	
        	if(null != imgUrl && imgUrl.length > 0){
        		
	        	/**
	        	 * 设置商品资质
	        	 */
	        	
	        	 for (int x = 0; x < imgUrl.length; x++) {
	        		 
	                 String[] prodImg = imgUrl[x].split("_");
	                 StringBuffer sb = new StringBuffer();
	                 for (int i = 1; i < prodImg.length; i++) {
	                     if (i > 1) {
	                         sb.append("_");
	                     }
	                     sb.append(prodImg[i]);
	                 } 
	                 
	                 if("00".equals(prodImg[0])){
	                	 
	                	 SupplierProductAttach prodQualification = new SupplierProductAttach();
	                	 String qualification = sb.toString();
	                	 qualification = qualification.substring(qualification.indexOf("group"));
	                	 prodQualification.setFileurl(qualification);
	                	 prodQualification.setType(Constants.PRODUCT_QUALIFICATION);
	                	 attachs.add(prodQualification);
	                	 
	                 } else {
	                	 BuyAttrValUrl.add(imgUrl[x]);
	                 }
	                 
	        	 }
	        	
	            
	            if (BuyAttrValUrl != null && BuyAttrValUrl.size() > 0) {
	                for (int x = 0; x < BuyAttrValUrl.size(); x++) {
	                    String[] split = BuyAttrValUrl.get(x).split("_");
	                    Integer index = Integer.parseInt(split[0]);
	                    buyMap.add(index);
	
	                    List<SupplierProductBuyAttrval> list = map.get(index);
	
	                    if (list != null && list.size() > 0) {
	                        SupplierProductBuyAttrval buyAttrval = new SupplierProductBuyAttrval();
	                        StringBuffer sb = new StringBuffer();
	
	                        for (int i = 1; i < split.length; i++) {
	                            if (i > 1) {
	                                sb.append("_");
	                            }
	                            sb.append(split[i]);
	                        }
	
	                        String prodImgurl = sb.toString();
	                        prodImgurl = prodImgurl.substring(prodImgurl.indexOf("group"));
	                        buyAttrval.setIstate(Constants.PRODUCT_STATUS_SUCCESS);
	                        buyAttrval.setImgurl(prodImgurl);
	                        list.add(buyAttrval);
	
	                    } else {
	
	                        list = new ArrayList<SupplierProductBuyAttrval>();
	                        SupplierProductBuyAttrval buyAttrval = new SupplierProductBuyAttrval();
	                        StringBuffer sb = new StringBuffer();
	                        for (int i = 1; i < split.length; i++) {
	                            if (i > 1) {
	                                sb.append("_");
	                            }
	                            sb.append(split[i]);
	                        }
	
	                        String prodImgurl = sb.toString();
	                        prodImgurl = prodImgurl.substring(prodImgurl.indexOf("group"));
	                        buyAttrval.setIstate(Constants.PRODUCT_STATUS_SUCCESS);
	                        buyAttrval.setImgurl(prodImgurl);
	                        list.add(buyAttrval);
	                        map.put(index, list);
	                    }
	                }
	            } else {
	                LOGGER.error("展示属性图片为空！！！");
	                throw new Exception("展示属性图片为空！！！");
	            }
            
        	}

            /**
             * 商品基本信息
             */
            objectVO.getSupplierProductBase().setProductname(pname);
            objectVO.getSupplierProductBaseEn().setProductname(pname);

            
            LOGGER.info("insertSkuInfo!!!");
            /**
             * sku信息
             */
            List<SupplierProductSkuDTO> productSkuVOs = new ArrayList<SupplierProductSkuDTO>();
            SupplierProductSaleSetting productSaleSetting = objectVO.getSupplierProductSaleSetting();
            List<SupplierProductWholesaleRange> wholesaleRanges = new ArrayList<SupplierProductWholesaleRange>();
            
            
            if(!Constants.DOMESTIC_DEALER.equals(getSupplierType())){
	            // 1按梯度家报价 2按sku报价
	            if (null != cost&&cost == 2) {
	               
	            	
	            	
	            	Integer skuSize = 0;
	            	if(null != buyVal){
	            		skuSize = buyVal.length > 0 ? buyVal.length : saleVal.length;
	            	}
	            	
	            	
	            	if (null != skuSize && skuSize > 0){
		                for (int i = 0; i < buyVal.length; i++) {
		
		                    SupplierProductSkuDTO skuVO = new SupplierProductSkuDTO();
		                    SupplierProductSku productSku = new SupplierProductSku();
		                  //TODO  
		                    String skuCodeNum = "";
		                    String barCodeImage = "";
		                    if(null!=auto&&1==auto){
		                    	skuCodeNum = JBarCodeUtil.getCreateRandom();
		                    	barCodeImage = JBarCodeUtil.getBarCodeUrl(skuCodeNum);
		                    	LOGGER.info("系统自动生成验证码："+skuCodeNum+";BarCodeUrl："+barCodeImage);
		                    } else {
		                    	
		                    	if(null != skuCode && skuCode.length > 0){
		                    		skuCodeNum = skuCode[i];
		                    	}
		                    	
		                    	if(null != barCodeImg && barCodeImg.length > 0){
		                    		barCodeImage = barCodeImg[i].substring(barCodeImg[i].indexOf("group"));
		                    	}
		                    }
		                    
		                    productSku.setSkuCode(skuCodeNum);
		                    
		                    productSku.setBarCodeImage(barCodeImage); 
		                    
		                    productSku.setCreateDate(new Date());
		                    productSku.setSaleStatus(Constants.PRODUCT_STATUS_SUCCESS);
		                    
		                  if(null != buyName && null != saleName){
		                	  
		                	  productSku.setSkuNameCn(buyName[i] + saleName[i]);
		                	  productSku.setSkuNameEn(buyName[i] + saleName[i]);
		                  }
		
		                    skuVO.setSupplierProductSku(productSku);
		                    List<SupplierProductSkuAttrval> supplierProductSkuAttrvals = 
		                            new ArrayList<SupplierProductSkuAttrval>();
		                    SupplierProductSkuAttrval buyAttrval = new SupplierProductSkuAttrval();
		                    buyAttrval.setAttrId(Long.parseLong("" + buyIndex));
		                    
		                    if(null != buyVal && buyVal.length >0){
		                    	buyAttrval.setAttrValId(buyVal[i]);
		                    	buyAttrval.setAttrvalNameCn(buyName[i]);
		                    }
		                    
		                    
		                    buyAttrval.setSupplierid(getCurrentSupplierId());
		                    
		                    supplierProductSkuAttrvals.add(buyAttrval);
		
		                    if (null != saleVal && saleVal.length > 0) {
		                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
		                        saleAttrval.setAttrId(saleIndex);
		                        saleAttrval.setAttrValId(saleVal[i]);
		                        saleAttrval.setSubsupplierid("");
		                        saleAttrval.setAttrvalNameCn(saleName[i]);
		                        supplierProductSkuAttrvals.add(saleAttrval);
		                    }
		
		                    skuVO.setSupplierProductSkuAttrvals(supplierProductSkuAttrvals);
		                    
		                    
		                    // TODO
			            	if(null != productPic && productPic.length > 0){
			            		
				                productSaleSetting
				                        .setMaxSellerPrice(Common.getMax2(productPic));
				                productSaleSetting
				                        .setMinSellerPrice(Common.getMin2(productPic));
				                productSaleSetting.setMinWholesaleQty(minNum);
			                
			
			                    SupplierProductPrice price = new SupplierProductPrice();
			                    price.setSupplierprice(productPic[i]);
			                    skuVO.setSupplierProductPriceMap(price);
			            	}
		                    productSkuVOs.add(skuVO);
		                }
	            	}
	            }
	
	            // 按照图梯度家设置价格
	            if (null != cost && cost == 1) {
	            	

	            	Integer skuSize = 0;
	            	if(null != buyVal){
	            		skuSize = buyVal.length > 0 ? buyVal.length : saleVal.length;
	            	
	            	}
	            	
	            	
	            	if (null != skuSize && skuSize > 0){
	
		                for (int i = 0; i < skuSize; i++) {
		
		                    SupplierProductSkuDTO skuVO = new SupplierProductSkuDTO();
		                    SupplierProductSku productSku = new SupplierProductSku();
		                    
		                    //TODO
		                    String skuCodeNum = "";
		                    String barCodeImage = "";
		                    if(null!=auto&&1==auto){
		                    	skuCodeNum = JBarCodeUtil.getCreateRandom();
		                    	barCodeImage = JBarCodeUtil.getBarCodeUrl(skuCodeNum);
		                    	LOGGER.info("系统自动生成验证码："+skuCodeNum+";BarCodeUrl："+barCodeImage);
		                    } else {
		                    	
		                    	if(null != skuCode && skuCode.length > 0){
		                    		skuCodeNum = skuCode[i];
		                    	}
		                    	
		                    	if(null != barCodeImg && barCodeImg.length > 0){
		                    		barCodeImage = barCodeImg[i].substring(barCodeImg[i].indexOf("group"));
		                    	}
		                    }
		                    
		                    
		                    
		                    productSku.setSkuCode(skuCodeNum);
		                    productSku.setBarCodeImage(barCodeImage); 
		                    
		                    productSku.setCreateDate(new Date());
		                    productSku.setSaleStatus(Constants.PRODUCT_STATUS_SUCCESS);
		                    productSku.setIstate(Constants.PRODUCT_STATUS_SUCCESS);
		                    
		                    if(null != buyName && null != saleName){
			                    productSku.setSkuNameCn(buyName[i] + saleName[i]);
			                    productSku.setSkuNameEn(buyName[i] + saleName[i]);
		                    }
		                    
		                    skuVO.setSupplierProductSku(productSku);
		
		                    List<SupplierProductSkuAttrval> supplierProductSkuAttrvals =
		                            new ArrayList<SupplierProductSkuAttrval>();
		
		                    SupplierProductSkuAttrval buyAttrval = new SupplierProductSkuAttrval();
		                    buyAttrval.setAttrId(Long.parseLong("" + buyIndex));
		                    
		                    if(null != buyVal && buyVal.length > 0){
		                    	buyAttrval.setAttrValId(buyVal[i]);
		                    	buyAttrval.setAttrvalNameCn(buyName[i]);
		                    }
		                    
		                    
		                    buyAttrval.setSupplierid(getCurrentSupplierId());
		                    supplierProductSkuAttrvals.add(buyAttrval);
		
		                    if (null != saleVal && saleVal.length > 0) {
		                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
		                        saleAttrval.setAttrId(saleIndex);
		                        saleAttrval.setAttrValId(saleVal[i]);
		                        saleAttrval.setSubsupplierid("");
		                        saleAttrval.setAttrvalNameCn(saleName[i]);
		                        supplierProductSkuAttrvals.add(saleAttrval);
		                    }
		
		                    skuVO.setSupplierProductSkuAttrvals(supplierProductSkuAttrvals);
		                    
		                    if(null != pic && pic.length > 0){
			                    SupplierProductPrice price = new SupplierProductPrice();
			                    price.setSupplierprice(Common.getMax2(pic));
			                    skuVO.setSupplierProductPriceMap(price);
		                    }
		                    productSkuVOs.add(skuVO);
		                }
	            	}
	                
	                
	                // 设置梯度价格
	                
	                
	                if(null != pic && pic.length > 0){
	            		
	            		productSaleSetting.setMaxSellerPrice(Common.getMax2(pic));
	            		productSaleSetting.setMinSellerPrice(Common.getMin2(pic));
	            		productSaleSetting.setMinWholesaleQty(start[0]);
	            		
	            		
		                for (int i = 0; i < pic.length; i++) {
		                	
		                	
		                    SupplierProductWholesaleRange range = new SupplierProductWholesaleRange();
		                    
		                    Long startQty = start[i] == null ? 0 : start[i];
		                    
		                    range.setStartQty(startQty);
		                    Long endQty = 0L;
		                    
		                    if (i + 1 < pic.length) {
		                    	
		                        endQty = (start[i + 1] == null ? 0 : start[i + 1])  - 1;
		                    }
		
		                    if (i == pic.length - 1) {
		                        endQty = 0L;
		                    }
		
		                    range.setEndQty(endQty);
		                    range.setDiscountType("0");
		                    range.setDiscount(pic[i] == null ? new BigDecimal(0) : pic[i]);
		                    wholesaleRanges.add(range);
		                }
	                }
	
	            }
            }
            
   
            //TODO 国内经销商不设置价格信息
            if(Constants.DOMESTIC_DEALER.equals(getSupplierType())){
            	
            	objectVO.getSupplierProduct().setProdType(Constants.PRODUCT_TYPE);
            	objectVO.getSupplierProductDetail().setPriceType(Constants.PRODUCT_PRICE_TYPE_DEALER);
            	objectVO.getSupplierProductDetail().setOrderType(Constants.PRODUCT_STATUS_SUCCESS);
            	
            	Integer skuSize  = 0;
            	if(null != buyVal){
            		skuSize = buyVal.length > 0 ? buyVal.length : saleVal.length;
            	}
            	
            	
            	if (null != skuSize && skuSize > 0){
	            	for (int i = 0; i < skuSize; i++) {
	
	                    SupplierProductSkuDTO skuVO = new SupplierProductSkuDTO();
	                    SupplierProductSku productSku = new SupplierProductSku();
	                    
	                    //TODO
	                    String skuCodeNum = "";
	                    String barCodeImage = "";
	                    if(null!=auto&&1==auto){
	                    	skuCodeNum = JBarCodeUtil.getCreateRandom();
	                    	barCodeImage = JBarCodeUtil.getBarCodeUrl(skuCodeNum);
	                    	LOGGER.info("系统自动生成验证码："+skuCodeNum+";BarCodeUrl："+barCodeImage);
	                    } else {
	                    	if(null != skuCode && skuCode.length > 0){
	                    		skuCodeNum = skuCode[i];
	                    	}
	                    	
	                    	if(null != barCodeImg && barCodeImg.length > 0){
	                    		barCodeImage = barCodeImg[i].substring(barCodeImg[i].indexOf("group"));
	                    	}
	                    }
	                    
	                    
	                    
	                    productSku.setSkuCode(skuCodeNum);
	                    productSku.setBarCodeImage(barCodeImage); 
	                    
	                    productSku.setCreateDate(new Date());
	                    productSku.setSaleStatus(Constants.PRODUCT_STATUS_SUCCESS);
	                    productSku.setIstate(Constants.PRODUCT_STATUS_SUCCESS);
	                    
	                    if(null != buyName && null != saleName ){
	                    	productSku.setSkuNameCn(buyName[i] + saleName[i]);
	                    	productSku.setSkuNameEn(buyName[i] + saleName[i]);
	                    }
	                    
	                    skuVO.setSupplierProductSku(productSku);
	
	                    List<SupplierProductSkuAttrval> supplierProductSkuAttrvals =
	                            new ArrayList<SupplierProductSkuAttrval>();
	
	                    SupplierProductSkuAttrval buyAttrval = new SupplierProductSkuAttrval();
	                    buyAttrval.setAttrId(Long.parseLong("" + buyIndex));
	                    
	                    if(null != buyVal && buyVal.length > 0 ){
	                    	buyAttrval.setAttrValId(buyVal[i]);
	                    	buyAttrval.setAttrvalNameCn(buyName[i]);
	                    }
	                    
	                    buyAttrval.setSupplierid(getCurrentSupplierId());
	                    supplierProductSkuAttrvals.add(buyAttrval);
	
	                    if (saleVal != null && saleVal.length > 0) {
	                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
	                        saleAttrval.setAttrId(saleIndex);
	                        saleAttrval.setAttrValId(saleVal[i]);
	                        saleAttrval.setSubsupplierid("");
	                        saleAttrval.setAttrvalNameCn(saleName[i]);
	                        supplierProductSkuAttrvals.add(saleAttrval);
	                    }
	
	                    skuVO.setSupplierProductSkuAttrvals(supplierProductSkuAttrvals);
	                    SupplierProductPrice price = new SupplierProductPrice();
	                    skuVO.setSupplierProductPriceMap(price);
	                    productSkuVOs.add(skuVO);
	                }
            	}
            	
            }
            
            

            //设置sku图片信息
            for (int x = 0; x < objectVO.getSupplierProductAttrDTOs().size(); x++) {
                if (objectVO.getSupplierProductAttrDTOs().get(x)
                        .getSupplierProductAttr().getBuyAttr() == 1) {
                    objectVO.getSupplierProductAttrDTOs().get(x).setMap(map);
                }
            }

            objectVO.setSupplierProductSkuDTOs(productSkuVOs);
            objectVO.setSupplierProductSaleSetting(productSaleSetting);
            
            if (!Constants.DOMESTIC_DEALER.equals(getSupplierType())){
            	objectVO.setSupplierProductWholesaleRanges(wholesaleRanges);
            }
            

            /**
             * 商品核心信息
             */
            objectVO.getSupplierProduct().setAuditReason(Constants.PRODUCT_STATUS_SUCCESS);

            objectVO.getSupplierProduct().setSuppliername(
                    getSupplier().getName());
            objectVO.getSupplierProduct().setOperator(""+getCurrentUserId());
            
            
            if (null != subBrandId && !"".equals(subBrandId)) {
            	
                try {
                    Brand firstBrand = RemoteServiceSingleton.getInstance()
                            .getCategoryServiceRpc().getBrandByID(brandId);
                    SubBrand subBrand = RemoteServiceSingleton.getInstance()
                            .getCategoryServiceRpc()
                            .getSubBrandByid(subBrandId);
                    objectVO.setBrand(firstBrand);
                    objectVO.setSubBrand(subBrand);
                    objectVO.getSupplierProduct().setBrandId(subBrandId);
                    LOGGER.info("设置品牌！！！subBrandId=" + subBrandId);
                } catch (Exception e) {
                    LOGGER.error("获取品牌失败！！！" + e.getMessage(),e);
                    throw new Exception("获取品牌失败！！！" + e.getMessage(), e);
                }
                
            } else {
            	
                try {
                    Brand firstBrand = RemoteServiceSingleton.getInstance()
                            .getCategoryServiceRpc().getBrandByID(brandId);
                    objectVO.setBrand(firstBrand);
                    objectVO.getSupplierProduct().setBrandId(brandId);
                    LOGGER.info("设置品牌！！！brandId=" + brandId);
                } catch (Exception e) {
                    LOGGER.error("获取品牌失败！！！"+e.getMessage(),e);
                    throw new Exception("获取品牌失败！！！" + e.getMessage(), e);
                }
                
            }
            
            objectVO.getSupplierProduct().setProductid(objectVO.getProductId());
            objectVO.getSupplierProduct().setSupplierid(getCurrentSupplierId());
            objectVO.getSupplierProduct().setSourcetype("1");
            objectVO.getSupplierProduct().setNamemd5(MD5.encrypt(pname));

            // 设置主图
            String imageUrl = saveProdImgUrl(BuyAttrValUrl);

            objectVO.getSupplierProduct().setImageurl(imageUrl);

            /**
             * 图文详情
             */
            SupplierProductAttach attach = new SupplierProductAttach();
            String fileUrl = "";
            if (null != editorValue) {
                byte[] picByte = editorValue.getBytes();
                try {
                    ByteArrayInputStream stream = new ByteArrayInputStream(picByte);
                    fileUrl = UploadFileUtil.uploadFile(stream, null, null);
                    LOGGER.info("图文详情上传成功！！！");
                } catch (Exception e) {
                    LOGGER.error("图文详情上传失败！！！"+e.getMessage(),e);
                    throw new Exception("图文详情上传失败！！！" + e.getMessage(), e);
                }
            }

            attach.setFileurl(fileUrl);
            attach.setType(Constants.PRODUCT_DESCRIPTIONS);
            attachs.add(attach);
            objectVO.setSupplierProductAttachs(attachs);
            
            SupplierProductDetail productDetail = objectVO.getSupplierProductDetail();
            
          //设置售后电话
            String servicePhone = null;
            if (!Common.isEmpty(fristPhone)) {
                servicePhone = "39-" + fristPhone + "-" + subPhone;
                productDetail.setSalesCalls(servicePhone);
            }
            
            if(!Constants.DOMESTIC_DEALER.equals(getSupplierType())&&null!=priceType){
            	if(0==priceType){
            		productDetail.setPriceType(Constants.PRODUCT_PRICE_TYPE_FOB);
            		productDetail.setPortName(fobPort);
            	} else if(1==priceType) {
            		productDetail.setPriceType(Constants.PRODUCT_PRICE_TYPE_CIF);
            		productDetail.setPortName(cifPort);
            	} else if(2==priceType){
            		productDetail.setPriceType(Constants.PRODUCT_PRICE_TYPE_EXW);
            	} else {
            		throw new Exception("价格类型有误！！！");
            	}
            }
            
            
            
            
            

            // 去除属性值为空的属性
            //TODO
            SupplierProductObjectDTO productObjectVO = CopyBeanUtil.copy(objectVO, buyMap);
            // 标识是中文还是英文
            if ("/en".equals(getLanguage()) || "/en" == getLanguage()) {
                productObjectVO.getSupplierProduct().setMnemonicCode("2");
            } else {
                productObjectVO.getSupplierProduct().setMnemonicCode("1");
            }


            productObjectVO.setSupplierid(getCurrentSupplierId());
            productObjectVO.setSubsupplierid("");
            
            if (null != RemoteServiceSingleton.getInstance().getSupplierProductService()) {
                try {
                    // TODO
                	LOGGER.info("保存草稿...");
                	RemoteServiceSingleton.getInstance().getSupplierDraftProductService().updateDraftProduct(productObjectVO);   
                    LOGGER.info("保存商品草稿成功!!!");
                    issavestatuinfo = "1";

                } catch (SupplierProException e) {
                    LOGGER.error("保存商品失败！！！supplierId:"+getCurrentSupplierId()+"productName:" + pname + e.getMessage(),e);
                    issavestatuinfo = "0";
                }
            }

        } catch (Exception e) {
            LOGGER.error("商品保存出错  msg:" + e.getMessage(),e);
            issavestatuinfo = "0";
        }
        return issavestatuinfo;
	}
    
    
}
