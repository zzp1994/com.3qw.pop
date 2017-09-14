package com.mall.controller.product;

import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;

import java.io.IOException;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.csource.upload.UploadFileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.alibaba.fastjson.JSON;
import com.baidu.ueditor.ActionEnter;
import com.mall.category.po.Brand;
import com.mall.category.po.SubBrand;
import com.mall.category.po.TdCatePub;
import com.mall.controller.base.BaseController;
import com.mall.customer.dto.HomeNumRecordDto;
import com.mall.customer.order.dto.ThirdPartyMessage;
import com.mall.customer.service.HomeNumRecordService;
import com.mall.dealer.product.api.DealerProductSkuService;
import com.mall.dealer.product.dto.DealerPordUpdateTateDto;
import com.mall.dealer.product.dto.DealerProductObjectDTO;
import com.mall.dealer.product.dto.DealerProductSelectConDTO;
import com.mall.dealer.product.dto.DealerProductShowDTO;
import com.mall.dealer.product.dto.DealerProductSkuShowDTO;
import com.mall.dealer.product.dto.DealerProductTabExportDTO;
import com.mall.dealer.product.dto.PurchasePriceDto;
import com.mall.dealer.product.dto.SKUAuditExportDTO;
import com.mall.dealer.product.po.DealerProduct;

import com.mall.dealer.product.po.PurchasePricePO;
import com.mall.merchant.proxy.RemoteServiceSingleton;
import com.mall.mybatis.utility.PageBean;
import com.mall.supplier.model.Supplier;
import com.mall.supplier.product.api.B2cProductDetailService;
import com.mall.supplier.product.api.SupplierProductAuditService;
import com.mall.supplier.product.dto.SupplierProductAttrDTO;
import com.mall.supplier.product.dto.SupplierProductObjectDTO;
import com.mall.supplier.product.dto.SupplierProductSelectConDTO;
import com.mall.supplier.product.dto.SupplierProductShowDTO;
import com.mall.supplier.product.dto.SupplierProductSkuDTO;
import com.mall.supplier.product.exception.SupplierProException;
import com.mall.supplier.product.po.B2cProductDetail;
import com.mall.supplier.product.po.SupplierProduct;
import com.mall.supplier.product.po.SupplierProductAttach;
import com.mall.supplier.product.po.SupplierProductAttr;
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
import com.mall.utils.FormatBigDecimal;
import com.mall.utils.JBarCodeUtil;
import com.mall.utils.MD5;

/**
 * 发布商品.
 *
 * @author xusq
 */
@Controller
public class ProductController extends BaseController {
	@Autowired
	private HomeNumRecordService homeNumRecordService;

	@Autowired
	private B2cProductDetailService b2cProductDetailService;

	@Autowired
	private SupplierProductAuditService supplierProductAuditService;
	
	@Autowired
	private DealerProductSkuService dealerProductSkuService;

	/**
	 * .
	 */
	private static final Logger LOGGER = Logger
			.getLogger(ProductController.class);

	@RequestMapping("/product/previewProd")
	@ResponseBody
	public String toPreviewProd() {

		return getLanguage() + "/product/previewProd";
	}

	@RequestMapping("/product/descriptionBrand")
	@ResponseBody
	public String findBrandDescription(String sysBrandId) {

		String description = RemoteServiceSingleton
				.getInstance()
				.getSupplierBrandManagerService()
				.findDescriptionBySysBrandId(getCurrentSupplierId(), sysBrandId);

		if (null != description) {
			if (description.indexOf("group") != -1) {
				description = UploadFileUtil.DownloadFile(description);
			}
		}

		return description;
	}

	/**
	 * .
	 *
	 * @param objectVO
	 *            objectVO
	 * @param cost
	 *            sku报价2、梯度价1
	 * @param start
	 *            梯度数量
	 * @param pic
	 *            梯度价
	 * @param buyIndex
	 *            展示属性index
	 * @param saleIndex
	 *            规格属性index
	 * @param productPic
	 *            sku报价是商品的价格
	 * @param saleVal
	 *            规格属性值
	 * @param buyVal
	 *            购买属性值
	 * @param pname
	 *            商品名称
	 * @param brandId
	 *            主品牌id
	 * @param subBrandId
	 *            子品牌id
	 * @param imgUrl
	 *            展示属性url
	 * @param buyName
	 *            购买属性属性名
	 * @param saleName
	 *            规格属性属性名
	 * @param editorValue
	 *            图文详情
	 * @return String
	 */
	@RequestMapping("/product/add")
	@ResponseBody
	public String saveProduct(HttpServletRequest request,
			SupplierProductObjectDTO objectVO, Integer cost,
			String[] attrRows,String[] saleAttrRows,String[] attrOrd,String[] attrName,
			Long[] start, String fristPhone, String subPhone, BigDecimal[] pic,
			Integer buyIndex, Integer saleIndex, Integer saleIndex2, Integer saleIndex3, Integer saleIndex4, 
			BigDecimal[] productPic,
			Long minNum, Long[] saleVal, Long[] saleVal2, Long[] saleVal3, Long[] saleVal4, Long[] buyVal, String pname,
			String brandId, String subBrandId, String skuCode[],
			String[] barCodeImg, String[] imgUrl, String[] buyName,
			String[] saleName, String[] saleName2,String[] saleName3,String[] saleName4,
			String[]unitPrice,String[]domesticPrice,String[]bestoayPrice,String[]productCode,Integer auto, Integer priceType, String fobPort,
			String[] hqj,String[] fhed,String cifPort, String editorValue) {

		LOGGER.info("enter_addProduct_Mothod=supplierId:"
				+ getCurrentSupplierId());

		Long productId = objectVO.getProductId();

		if (null != productId) {
			try {
				RemoteServiceSingleton.getInstance()
						.getSupplierDraftProductService()
						.deleteDraftProductById(productId, "");
			} catch (Exception e) {
				LOGGER.info("不是草稿商品pid：" + productId);
			}
		}

    	List<SupplierProductAttrDTO> attrDTOs = new ArrayList<SupplierProductAttrDTO>();
    	//普通属性
    	if(attrRows!=null && attrRows.length>0){
    		for(int i=0;i<attrRows.length;i++){
        		SupplierProductAttrDTO attrDto = new SupplierProductAttrDTO();
        		SupplierProductAttr attr = new SupplierProductAttr();
        		List<SupplierProductAttrval> listAttrval = new ArrayList<SupplierProductAttrval>();
        		String type = request.getParameter("type"+attrRows[i]);
        		attr.setType(Short.valueOf(type));
        		attr.setAttrNameCn(attrName[i]);
        		attr.setAttrName(attrName[i]);
        		attr.setBuyAttr(Short.valueOf("0"));
        		attr.setSaleAttr(Short.valueOf("0"));
        		attr.setIsneed(Short.valueOf("-1"));
        		attr.setSortval(Integer.parseInt(attrOrd[i]));
        		String[] attrvals = request.getParameterValues("attrval"+attrRows[i]);
        		for (String val : attrvals) {
        			if(val!=null && "".equals(val)){
        				val = "-";
        			}
        			SupplierProductAttrval attrval = new SupplierProductAttrval();
            		attrval.setAttrNameCn(attrName[i]);
        			attrval.setAttrName(attrName[i]);
        			attrval.setLineAttrvalName(val);
        			attrval.setLineAttrvalNameCn(val);
        			attrval.setIstate(Short.valueOf("1"));
        			listAttrval.add(attrval);
    			}
        		attrDto.setSupplierProductAttr(attr);
        		attrDto.setSupplierProductAttrvals(listAttrval);
        		attrDTOs.add(attrDto);
        	}
    	}
    	//展示属性
    	String buyAttrname = request.getParameter("buyAttrName");
    	int a = 0;
    	if(buyAttrname!=null && !"".equals(buyAttrname)){
    		SupplierProductAttrDTO attrDto = new SupplierProductAttrDTO();
    		SupplierProductAttr attr = new SupplierProductAttr();
    		List<SupplierProductAttrval> listAttrval = new ArrayList<SupplierProductAttrval>();
    		attr.setType(Short.valueOf("2"));
    		attr.setAttrNameCn(buyAttrname);
    		attr.setAttrName(buyAttrname);
    		attr.setBuyAttr(Short.valueOf("1"));
    		attr.setSaleAttr(Short.valueOf("0"));
    		attr.setIsneed(Short.valueOf("1"));
    		attr.setSortval(1);
    		String[] buyAttrvals = request.getParameterValues("buyAttrval");
    		
    		if(buyAttrvals.length>1){
    			for(int i=0;i<buyAttrvals.length;i++){
    				if(buyAttrvals[0].equals(buyAttrvals[1])){
    					a=1;
    				}
        			
        		}
    		}
    		for (String val : buyAttrvals) {
    			if(val!=null && "".equals(val)){
    				val = "-";
    			}
    			SupplierProductAttrval attrval = new SupplierProductAttrval();
        		attrval.setAttrNameCn(buyAttrname);
    			attrval.setAttrName(buyAttrname);
    			attrval.setLineAttrvalName(val);
    			attrval.setLineAttrvalNameCn(val);
    			attrval.setIstate(Short.valueOf("1"));
    			listAttrval.add(attrval);
			}
    		attrDto.setSupplierProductAttr(attr);
    		attrDto.setSupplierProductAttrvals(listAttrval);
    		buyIndex=attrDTOs.size();
    		attrDTOs.add(attrDto);
    		
    	}
    	
    	//规格属性
    	String saleAttrname = request.getParameter("saleAttrName0");
    	if(saleAttrname!=null && !"".equals(saleAttrname)){
    		SupplierProductAttrDTO attrDto = new SupplierProductAttrDTO();
    		SupplierProductAttr attr = new SupplierProductAttr();
    		List<SupplierProductAttrval> listAttrval = new ArrayList<SupplierProductAttrval>();
    		attr.setType(Short.valueOf("2"));
    		attr.setAttrNameCn(saleAttrname);
    		attr.setAttrName(saleAttrname);
    		attr.setBuyAttr(Short.valueOf("0"));
    		attr.setSaleAttr(Short.valueOf("1"));
    		attr.setIsneed(Short.valueOf("1"));
    		attr.setSortval(1);
    		String[] saleAttrvals = request.getParameterValues("saleAttrval0");
    		for (String val : saleAttrvals) {
    			if(val!=null && "".equals(val)){
    				val = "-";
    			}
    			SupplierProductAttrval attrval = new SupplierProductAttrval();
        		attrval.setAttrNameCn(saleAttrname);
    			attrval.setAttrName(saleAttrname);
    			attrval.setLineAttrvalName(val);
    			attrval.setLineAttrvalNameCn(val);
    			attrval.setIstate(Short.valueOf("1"));
    			listAttrval.add(attrval);
			}
    		attrDto.setSupplierProductAttr(attr);
    		attrDto.setSupplierProductAttrvals(listAttrval);
    		saleIndex=attrDTOs.size();
    		attrDTOs.add(attrDto);
    	}
    	
    	//规格属性
    	String saleAttrname2 = request.getParameter("saleAttrName1");
    	if(saleAttrname2!=null && !"".equals(saleAttrname2)){
    		SupplierProductAttrDTO attrDto = new SupplierProductAttrDTO();
    		SupplierProductAttr attr = new SupplierProductAttr();
    		List<SupplierProductAttrval> listAttrval = new ArrayList<SupplierProductAttrval>();
    		attr.setType(Short.valueOf("1"));
    		attr.setAttrNameCn(saleAttrname2);
    		attr.setAttrName(saleAttrname2);
    		attr.setBuyAttr(Short.valueOf("0"));
    		attr.setSaleAttr(Short.valueOf("1"));
    		attr.setIsneed(Short.valueOf("1"));
    		attr.setSortval(2);
    		String[] saleAttrvals = request.getParameterValues("saleAttrval1");
    		for (String val : saleAttrvals) {
    			if(val!=null && "".equals(val)){
    				val = "-";
    			}
    			SupplierProductAttrval attrval = new SupplierProductAttrval();
        		attrval.setAttrNameCn(saleAttrname2);
    			attrval.setAttrName(saleAttrname2);
    			attrval.setLineAttrvalName(val);
    			attrval.setLineAttrvalNameCn(val);
    			attrval.setIstate(Short.valueOf("1"));
    			listAttrval.add(attrval);
			}
    		attrDto.setSupplierProductAttr(attr);
    		attrDto.setSupplierProductAttrvals(listAttrval);
    		saleIndex2=attrDTOs.size();
    		attrDTOs.add(attrDto);
    	}
    	//规格属性
    	String saleAttrname3 = request.getParameter("saleAttrName2");
    	if(saleAttrname3!=null && !"".equals(saleAttrname3)){
    		SupplierProductAttrDTO attrDto = new SupplierProductAttrDTO();
    		SupplierProductAttr attr = new SupplierProductAttr();
    		List<SupplierProductAttrval> listAttrval = new ArrayList<SupplierProductAttrval>();
    		attr.setType(Short.valueOf("1"));
    		attr.setAttrNameCn(saleAttrname3);
    		attr.setAttrName(saleAttrname3);
    		attr.setBuyAttr(Short.valueOf("0"));
    		attr.setSaleAttr(Short.valueOf("1"));
    		attr.setIsneed(Short.valueOf("1"));
    		attr.setSortval(3);
    		String[] saleAttrvals = request.getParameterValues("saleAttrval2");
    		for (String val : saleAttrvals) {
    			if(val!=null && "".equals(val)){
    				val = "-";
    			}
    			SupplierProductAttrval attrval = new SupplierProductAttrval();
        		attrval.setAttrNameCn(saleAttrname3);
    			attrval.setAttrName(saleAttrname3);
    			attrval.setLineAttrvalName(val);
    			attrval.setLineAttrvalNameCn(val);
    			attrval.setIstate(Short.valueOf("1"));
    			listAttrval.add(attrval);
			}
    		attrDto.setSupplierProductAttr(attr);
    		attrDto.setSupplierProductAttrvals(listAttrval);
    		saleIndex3=attrDTOs.size();
    		attrDTOs.add(attrDto);
    	}
    	//规格属性
    	String saleAttrname4 = request.getParameter("saleAttrName3");
    	if(saleAttrname4!=null && !"".equals(saleAttrname4)){
    		SupplierProductAttrDTO attrDto = new SupplierProductAttrDTO();
    		SupplierProductAttr attr = new SupplierProductAttr();
    		List<SupplierProductAttrval> listAttrval = new ArrayList<SupplierProductAttrval>();
    		attr.setType(Short.valueOf("1"));
    		attr.setAttrNameCn(saleAttrname4);
    		attr.setAttrName(saleAttrname4);
    		attr.setBuyAttr(Short.valueOf("0"));
    		attr.setSaleAttr(Short.valueOf("1"));
    		attr.setIsneed(Short.valueOf("1"));
    		attr.setSortval(4);
    		String[] saleAttrvals = request.getParameterValues("saleAttrval3");
    		for (String val : saleAttrvals) {
    			if(val!=null && "".equals(val)){
    				val = "-";
    			}
    			SupplierProductAttrval attrval = new SupplierProductAttrval();
        		attrval.setAttrNameCn(saleAttrname4);
    			attrval.setAttrName(saleAttrname4);
    			attrval.setLineAttrvalName(val);
    			attrval.setLineAttrvalNameCn(val);
    			attrval.setIstate(Short.valueOf("1"));
    			listAttrval.add(attrval);
			}
    		attrDto.setSupplierProductAttr(attr);
    		attrDto.setSupplierProductAttrvals(listAttrval);
    		saleIndex4=attrDTOs.size();
    		attrDTOs.add(attrDto);
    	}
    	objectVO.setSupplierProductAttrDTOs(attrDTOs);
 
		
		/**
		 * 设置展示属性的图片url
		 */
		String issavestatuinfo = null;

		try {

			List<SupplierProductAttach> attachs = new ArrayList<SupplierProductAttach>();

			/**
			 * 设置商品资质
			 */
			List<String> BuyAttrValUrl = new ArrayList<String>();

			for (int x = 0; x < imgUrl.length; x++) {

				String[] prodImg = imgUrl[x].split("_");
				StringBuffer sb = new StringBuffer();

				for (int i = 1; i < prodImg.length; i++) {

					if (i > 1) {
						sb.append("_");
					}

					sb.append(prodImg[i]);

				}

				if ("00".equals(prodImg[0])) {

					SupplierProductAttach prodQualification = new SupplierProductAttach();
					String qualification = sb.toString();
					qualification = qualification.substring(qualification
							.indexOf("group"));
					prodQualification.setFileurl(qualification);
					prodQualification.setType(Constants.PRODUCT_QUALIFICATION);
					attachs.add(prodQualification);

				} else {
					BuyAttrValUrl.add(imgUrl[x]);
				}

			}

			List<Integer> buyMap = new ArrayList<Integer>();
			Map<Integer, List<SupplierProductBuyAttrval>> map = new LinkedHashMap<Integer, List<SupplierProductBuyAttrval>>();

			if (null != BuyAttrValUrl && BuyAttrValUrl.size() > 0) {

				for (int x = 0; x < BuyAttrValUrl.size(); x++) {

					String[] split = BuyAttrValUrl.get(x).split("_");
					Integer index = Integer.parseInt(split[0].substring(10, split[0].length()));//buyAttrval1
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
						prodImgurl = prodImgurl.substring(prodImgurl
								.indexOf("group"));
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
						prodImgurl = prodImgurl.substring(prodImgurl
								.indexOf("group"));
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
			SupplierProductSaleSetting productSaleSetting = objectVO
					.getSupplierProductSaleSetting();
			List<SupplierProductWholesaleRange> wholesaleRanges = new ArrayList<SupplierProductWholesaleRange>();

			if (!Constants.DOMESTIC_DEALER.equals(getSupplierType())) {
				// 1按梯度家报价 2按sku报价
				if (null != cost && cost == 2) {
					// TODO
					productSaleSetting.setMaxSellerPrice(Common
							.getMax2(productPic));
					productSaleSetting.setMinSellerPrice(Common
							.getMin2(productPic));
					productSaleSetting.setMinWholesaleQty(minNum);

					for (int i = 0; i < buyVal.length; i++) {

						SupplierProductSkuDTO skuVO = new SupplierProductSkuDTO();
						SupplierProductSku productSku = new SupplierProductSku();
						// todo
						String skuCodeNum = "";
						String barCodeImage = "";
						if (null != auto && 1 == auto) {

							skuCodeNum = JBarCodeUtil.getCreateRandom();
							barCodeImage = JBarCodeUtil
									.getBarCodeUrl(skuCodeNum);

							LOGGER.info("系统自动生成验证码：" + skuCodeNum
									+ ";BarCodeUrl：" + barCodeImage);

						} else {

							skuCodeNum = skuCode[i];
							barCodeImage = barCodeImg[i]
									.substring(barCodeImg[i].indexOf("group"));

						}

						productSku.setSkuCode(skuCodeNum);

						productSku.setBarCodeImage(barCodeImage);

						productSku.setCreateDate(new Date());
						productSku.setSaleStatus(Constants.PRODUCT_STATUS_SUCCESS);
						if(buyName != null && buyName.length>0){
							buyName[i] = !"".equals(buyName[i])? buyName[i]:"-";
						}
						if(saleName != null && saleName.length>0){
							saleName[i] = !"".equals(saleName[i])? saleName[i]:"-";
						}
						String saleN2 = "";
	                    if(saleName2 !=null && saleName2.length>0){
	                    	saleN2=saleName2[i];
	                    }
	                    String saleN3 = "";
	                    if(saleName3 !=null && saleName3.length>0){
	                    	saleN3=saleName3[i];
	                    }
	                    String saleN4 = "";
	                    if(saleName4 !=null && saleName4.length>0){
	                    	saleN4=saleName4[i];
	                    }
	                    productSku.setSkuNameCn(buyName[i] + saleName[i] + saleN2 + saleN3 + saleN4);
	                    productSku.setSkuNameEn(buyName[i] + saleName[i] + saleN2 + saleN3 + saleN4);
	
						//商品货号
						if(productCode[i]!=null){	
							productSku.setProductCode(productCode[i]);
						}
						skuVO.setSupplierProductSku(productSku);

						List<SupplierProductSkuAttrval> supplierProductSkuAttrvals = new ArrayList<SupplierProductSkuAttrval>();
						SupplierProductSkuAttrval buyAttrval = new SupplierProductSkuAttrval();

						buyAttrval.setAttrId(Long.parseLong("" + buyIndex));
						buyAttrval.setAttrValId(buyVal[i]);
						buyAttrval.setSupplierid(getCurrentSupplierId());
						buyAttrval.setAttrvalNameCn(buyName[i]);

						supplierProductSkuAttrvals.add(buyAttrval);

						if (saleVal != null && saleVal.length > 0) {
	                    	
	                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
	                        
	                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex));
	                        saleAttrval.setAttrValId(saleVal[i]);
	                        saleAttrval.setSubsupplierid("");
	                        saleAttrval.setAttrvalNameCn(saleName[i]);
	                        
	                        supplierProductSkuAttrvals.add(saleAttrval);
	                    }
	                    if (saleVal2 != null && saleVal2.length > 0) {
	                    	
	                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
	                        
	                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex2));
	                        saleAttrval.setAttrValId(Long.valueOf(String.valueOf(saleVal2[i]).substring(1, String.valueOf(saleVal2[i]).length())));
	                        saleAttrval.setSubsupplierid("");
	                        saleAttrval.setAttrvalNameCn(saleName2[i]);
	                        
	                        supplierProductSkuAttrvals.add(saleAttrval);
	                    }
	                    if (saleVal3 != null && saleVal3.length > 0) {
	                    	
	                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
	                        
	                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex3));
	                        saleAttrval.setAttrValId(Long.valueOf(String.valueOf(saleVal3[i]).substring(1, String.valueOf(saleVal3[i]).length())));
	                        saleAttrval.setSubsupplierid("");
	                        saleAttrval.setAttrvalNameCn(saleName3[i]);
	                        
	                        supplierProductSkuAttrvals.add(saleAttrval);
	                    }
	                    if (saleVal4 != null && saleVal4.length > 0) {
	                    	
	                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
	                        
	                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex4));
	                        saleAttrval.setAttrValId(Long.valueOf(String.valueOf(saleVal4[i]).substring(1, String.valueOf(saleVal4[i]).length())));
	                        saleAttrval.setSubsupplierid("");
	                        saleAttrval.setAttrvalNameCn(saleName4[i]);
	                        
	                        supplierProductSkuAttrvals.add(saleAttrval);
	                    }

						skuVO.setSupplierProductSkuAttrvals(supplierProductSkuAttrvals);
						SupplierProductPrice price = new SupplierProductPrice();
						price.setSupplierprice(productPic[i]);
						skuVO.setSupplierProductPriceMap(price);
						productSkuVOs.add(skuVO);
					}
				}

				// 按照图梯度家设置价格
				if (null != cost && cost == 1) {

					productSaleSetting.setMaxSellerPrice(Common.getMax2(pic));
					productSaleSetting.setMinSellerPrice(Common.getMin2(pic));
					productSaleSetting.setMinWholesaleQty(start[0]);

					for (int i = 0; i < buyVal.length; i++) {

						SupplierProductSkuDTO skuVO = new SupplierProductSkuDTO();
						SupplierProductSku productSku = new SupplierProductSku();

						// todo
						String skuCodeNum = "";
						String barCodeImage = "";

						if (null != auto && 1 == auto) {

							skuCodeNum = JBarCodeUtil.getCreateRandom();
							barCodeImage = JBarCodeUtil
									.getBarCodeUrl(skuCodeNum);

							LOGGER.info("系统自动生成验证码：" + skuCodeNum
									+ ";BarCodeUrl：" + barCodeImage);

						} else {

							skuCodeNum = skuCode[i];
							barCodeImage = barCodeImg[i]
									.substring(barCodeImg[i].indexOf("group"));

						}

						productSku.setSkuCode(skuCodeNum);
						productSku.setBarCodeImage(barCodeImage);

						productSku.setCreateDate(new Date());
						productSku
								.setSaleStatus(Constants.PRODUCT_STATUS_SUCCESS);
						productSku.setIstate(Constants.PRODUCT_STATUS_SUCCESS);
						if(buyName != null && buyName.length>0){
							buyName[i] = !"".equals(buyName[i])? buyName[i]:"-";
						}
						if(saleName != null && saleName.length>0){
							saleName[i] = !"".equals(saleName[i])? saleName[i]:"-";
						}
						String saleN2 = "";
	                    if(saleName2 !=null && saleName2.length>0){
	                    	saleN2=saleName2[i];
	                    }
	                    String saleN3 = "";
	                    if(saleName3 !=null && saleName3.length>0){
	                    	saleN3=saleName3[i];
	                    }
	                    String saleN4 = "";
	                    if(saleName4 !=null && saleName4.length>0){
	                    	saleN4=saleName4[i];
	                    }
	                    productSku.setSkuNameCn(buyName[i] + saleName[i] + saleN2 + saleN3 + saleN4);
	                    productSku.setSkuNameEn(buyName[i] + saleName[i] + saleN2 + saleN3 + saleN4);
	                    //商品货号
						if(productCode[i]!=null){	
							productSku.setProductCode(productCode[i]);
						}
						skuVO.setSupplierProductSku(productSku);

						List<SupplierProductSkuAttrval> supplierProductSkuAttrvals = new ArrayList<SupplierProductSkuAttrval>();

						SupplierProductSkuAttrval buyAttrval = new SupplierProductSkuAttrval();
						buyAttrval.setAttrId(Long.parseLong("" + buyIndex));
						buyAttrval.setAttrValId(buyVal[i]);
						buyAttrval.setSupplierid(getCurrentSupplierId());
						buyAttrval.setAttrvalNameCn(buyName[i]);
						supplierProductSkuAttrvals.add(buyAttrval);

						if (saleVal != null && saleVal.length > 0) {
	                    	
	                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
	                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex));
	                        saleAttrval.setAttrValId(saleVal[i]);
	                        saleAttrval.setSubsupplierid("");
	                        saleAttrval.setAttrvalNameCn(saleName[i]);
	                        supplierProductSkuAttrvals.add(saleAttrval);
	                    }
	                    if (saleVal2 != null && saleVal2.length > 0) {
	                    	
	                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
	                        
	                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex2));
	                        saleAttrval.setAttrValId(Long.valueOf(String.valueOf(saleVal2[i]).substring(1, String.valueOf(saleVal2[i]).length())));
	                        saleAttrval.setSubsupplierid("");
	                        saleAttrval.setAttrvalNameCn(saleName2[i]);
	                        
	                        supplierProductSkuAttrvals.add(saleAttrval);
	                    }
	                    if (saleVal3 != null && saleVal3.length > 0) {
	                    	
	                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
	                        
	                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex3));
	                        saleAttrval.setAttrValId(Long.valueOf(String.valueOf(saleVal3[i]).substring(1, String.valueOf(saleVal3[i]).length())));
	                        saleAttrval.setSubsupplierid("");
	                        saleAttrval.setAttrvalNameCn(saleName3[i]);
	                        
	                        supplierProductSkuAttrvals.add(saleAttrval);
	                    }
	                    if (saleVal4 != null && saleVal4.length > 0) {
	                    	
	                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
	                        
	                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex4));
	                        saleAttrval.setAttrValId(Long.valueOf(String.valueOf(saleVal4[i]).substring(1, String.valueOf(saleVal4[i]).length())));
	                        saleAttrval.setSubsupplierid("");
	                        saleAttrval.setAttrvalNameCn(saleName4[i]);
	                        
	                        supplierProductSkuAttrvals.add(saleAttrval);
	                    }

						skuVO.setSupplierProductSkuAttrvals(supplierProductSkuAttrvals);
						SupplierProductPrice price = new SupplierProductPrice();
						price.setSupplierprice(Common.getMax2(pic));
						skuVO.setSupplierProductPriceMap(price);
						productSkuVOs.add(skuVO);
					}

					// 设置梯度价格
					for (int i = 0; i < pic.length; i++) {

						SupplierProductWholesaleRange range = new SupplierProductWholesaleRange();
						range.setStartQty(start[i]);
						Long endQty = 0L;

						if (i + 1 < pic.length) {

							endQty = start[i + 1] - 1;
						}

						if (i == pic.length - 1) {

							endQty = 0L;
						}

						range.setEndQty(endQty);
						range.setDiscountType("0");
						range.setDiscount(pic[i]);
						wholesaleRanges.add(range);
					}

				}
			}

			// TODO 国内经销商不设置价格信息
			if (Constants.DOMESTIC_DEALER.equals(getSupplierType())) {

				objectVO.getSupplierProduct().setProdType(
						Constants.PRODUCT_TYPE);
				objectVO.getSupplierProductDetail().setPriceType(
						Constants.PRODUCT_PRICE_TYPE_DEALER);
				objectVO.getSupplierProductDetail().setOrderType(
						Constants.PRODUCT_STATUS_SUCCESS);

				for (int i = 0; i < buyVal.length; i++) {

					SupplierProductSkuDTO skuVO = new SupplierProductSkuDTO();
					SupplierProductSku productSku = new SupplierProductSku();

					// todo
					String skuCodeNum = "";
					String barCodeImage = "";

					if (null != auto && 1 == auto) {

						skuCodeNum = JBarCodeUtil.getCreateRandom();
						barCodeImage = JBarCodeUtil.getBarCodeUrl(skuCodeNum);

						LOGGER.info("系统自动生成验证码：" + skuCodeNum + ";BarCodeUrl："
								+ barCodeImage);

					} else {
						skuCodeNum = skuCode[i];
						barCodeImage = barCodeImg[i].substring(barCodeImg[i]
								.indexOf("group"));
					}

					productSku.setSkuCode(skuCodeNum);
					productSku.setBarCodeImage(barCodeImage);

					productSku.setCreateDate(new Date());
					productSku.setSaleStatus(Constants.PRODUCT_STATUS_SUCCESS);
					productSku.setIstate(Constants.PRODUCT_STATUS_SUCCESS);
					String saleN2 = "";
                    if(saleName2 !=null && saleName2.length>0){
                    	saleN2=saleName2[i];
                    }
                    String saleN3 = "";
                    if(saleName3 !=null && saleName3.length>0){
                    	saleN3=saleName3[i];
                    }
                    String saleN4 = "";
                    if(saleName4 !=null && saleName4.length>0){
                    	saleN4=saleName4[i];
                    }
                    if(buyName != null && buyName.length>0){
						buyName[i] = !"".equals(buyName[i])? buyName[i]:"-";
					}
					if(saleName != null && saleName.length>0){
						saleName[i] = !"".equals(saleName[i])? saleName[i]:"-";
					}
					productSku.setSkuNameCn(buyName[i] + saleName[i] + saleN2 + saleN3 + saleN4);
                    productSku.setSkuNameEn(buyName[i] + saleName[i] + saleN2 + saleN3 + saleN4);
                    //商品货号
					if(productCode[i]!=null){	
						productSku.setProductCode(productCode[i]);
					}
					skuVO.setSupplierProductSku(productSku);

					List<SupplierProductSkuAttrval> supplierProductSkuAttrvals = new ArrayList<SupplierProductSkuAttrval>();

					SupplierProductSkuAttrval buyAttrval = new SupplierProductSkuAttrval();
					buyAttrval.setAttrId(Long.parseLong("" + buyIndex));
					buyAttrval.setAttrValId(buyVal[i]);
					buyAttrval.setSupplierid(getCurrentSupplierId());
					buyAttrval.setAttrvalNameCn(buyName[i]);
					supplierProductSkuAttrvals.add(buyAttrval);

					if (saleVal != null && saleVal.length > 0) {
                    	
                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex));
                        saleAttrval.setAttrValId(saleVal[i]);
                        saleAttrval.setSubsupplierid("");
                        saleAttrval.setAttrvalNameCn(saleName[i]);
                        supplierProductSkuAttrvals.add(saleAttrval);
                    }                    
                    if (saleVal2 != null && saleVal2.length > 0) {
                    	
                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex2));
                        saleAttrval.setAttrValId(Long.valueOf(String.valueOf(saleVal2[i]).substring(1, String.valueOf(saleVal2[i]).length())));
                        saleAttrval.setSubsupplierid("");
                        saleAttrval.setAttrvalNameCn(saleName2[i]);
                        supplierProductSkuAttrvals.add(saleAttrval);
                    }
                    if (saleVal3 != null && saleVal3.length > 0) {
                    	
                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex3));
                        saleAttrval.setAttrValId(Long.valueOf(String.valueOf(saleVal3[i]).substring(1, String.valueOf(saleVal3[i]).length())));
                        saleAttrval.setSubsupplierid("");
                        saleAttrval.setAttrvalNameCn(saleName3[i]);
                        supplierProductSkuAttrvals.add(saleAttrval);
                    }
                    if (saleVal4 != null && saleVal4.length > 0) {
                    	
                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex4));
                        saleAttrval.setAttrValId(Long.valueOf(String.valueOf(saleVal4[i]).substring(1, String.valueOf(saleVal4[i]).length())));
                        saleAttrval.setSubsupplierid("");
                        saleAttrval.setAttrvalNameCn(saleName4[i]);
                        supplierProductSkuAttrvals.add(saleAttrval);
                    }

					skuVO.setSupplierProductSkuAttrvals(supplierProductSkuAttrvals);
					SupplierProductPrice price = new SupplierProductPrice();
					skuVO.setSupplierProductPriceMap(price);
					productSkuVOs.add(skuVO);
				}

			}

			// 设置sku图片信息
			for (int x = 0; x < objectVO.getSupplierProductAttrDTOs().size(); x++) {

				if (objectVO.getSupplierProductAttrDTOs().get(x)
						.getSupplierProductAttr().getBuyAttr() == 1) {

					objectVO.getSupplierProductAttrDTOs().get(x).setMap(map);

				}
			}

			objectVO.setSupplierProductSkuDTOs(productSkuVOs);
			objectVO.setSupplierProductSaleSetting(productSaleSetting);

			if (!Constants.DOMESTIC_DEALER.equals(getSupplierType())) {

				objectVO.setSupplierProductWholesaleRanges(wholesaleRanges);
			}

			/**
			 * 商品核心信息
			 */
			objectVO.getSupplierProduct().setAuditReason(
					Constants.PRODUCT_STATUS_SUCCESS);

			objectVO.getSupplierProduct().setSuppliername(
					getSupplier().getName());
			objectVO.getSupplierProduct().setOperator("" + getCurrentUserId());

			if (subBrandId != null && !"".equals(subBrandId)) {

				try {

					Brand firstBrand = RemoteServiceSingleton.getInstance()
							.getCategoryServiceRpc().getBrandByID(brandId);
					SubBrand subBrand = RemoteServiceSingleton.getInstance()
							.getCategoryServiceRpc()
							.getSubBrandByid(subBrandId);
					objectVO.setBrand(firstBrand);
					objectVO.setSubBrand(subBrand);
					objectVO.getSupplierProduct().setBrandId(subBrandId);

					LOGGER.info("设置品牌成功！！！subBrandId=" + subBrandId);

				} catch (Exception e) {

					LOGGER.error("获取品牌失败！！！" + e.getMessage(), e);

					throw new Exception("获取品牌失败！！！" + e.getMessage(), e);
				}

			} else {

				try {

					Brand firstBrand = RemoteServiceSingleton.getInstance()
							.getCategoryServiceRpc().getBrandByID(brandId);
					objectVO.setBrand(firstBrand);
					objectVO.getSupplierProduct().setBrandId(brandId);
					LOGGER.info("设置品牌成功！！！brandId=" + brandId);

				} catch (Exception e) {

					LOGGER.error("获取品牌失败！！！" + e.getMessage(), e);
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
				if(editorValue.indexOf("detail_inner.css")==-1){
	            	String startStr="<link rel=\"stylesheet\" href=\"http://static.3qianwan.com/commons/css/detail_inner.css\" type=\"text/css\"><div class='detail_inner' >";
	            	String endStr="</div>";
	            	editorValue=startStr+editorValue+endStr;
	            }
				byte[] picByte = editorValue.getBytes();
				try {

					ByteArrayInputStream stream = new ByteArrayInputStream(
							picByte);
					fileUrl = UploadFileUtil.uploadFile(stream, null, null);
					LOGGER.info("图文详情上传成功！！！");

				} catch (Exception e) {

					LOGGER.error("图文详情上传失败！！！" + e.getMessage(), e);
					throw new Exception("图文详情上传失败！！！" + e.getMessage(), e);
				}
			}

			attach.setFileurl(fileUrl);
			attach.setType(Constants.PRODUCT_DESCRIPTIONS);
			attachs.add(attach);
			objectVO.setSupplierProductAttachs(attachs);

			SupplierProductDetail productDetail = objectVO
					.getSupplierProductDetail();

			// 设置售后电话
			String servicePhone = null;
			if (!Common.isEmpty(fristPhone)) {
				servicePhone = "39-" + fristPhone + "-" + subPhone;
				productDetail.setSalesCalls(servicePhone);
			}

			if (!Constants.DOMESTIC_DEALER.equals(getSupplierType())
					&& null != priceType) {
				if (0 == priceType) {

					productDetail
							.setPriceType(Constants.PRODUCT_PRICE_TYPE_FOB);
					productDetail.setPortName(fobPort);

				} else if (1 == priceType) {

					productDetail
							.setPriceType(Constants.PRODUCT_PRICE_TYPE_CIF);
					productDetail.setPortName(cifPort);

				} else if (2 == priceType) {

					productDetail
							.setPriceType(Constants.PRODUCT_PRICE_TYPE_EXW);

				} else {
					throw new Exception("价格类型有误！！！");
				}
			}

			// 去除属性值为空的属性
			objectVO.getB2cProductDetail().setB2cProductName(pname);//B2C商品名称
			objectVO.getB2cProductDetail().setB2cDescription(fileUrl);//图文详情
			SupplierProductObjectDTO productObjectVO = CopyBeanUtil.copy(
					objectVO, buyMap);

			// 标识是中文还是英文
			if ("/en".equals(getLanguage()) || "/en" == getLanguage()) {

				productObjectVO.getSupplierProduct().setMnemonicCode("2");

			} else {

				productObjectVO.getSupplierProduct().setMnemonicCode("1");

			}

			productObjectVO.setSupplierid(getCurrentSupplierId());
			productObjectVO.setSubsupplierid("");
//			productObjectVO.getSupplierProductSkuDTOs().get(0).getSupplierProductPriceMap().setUnitPrice(new BigDecimal(111));//TODO临时，前台修改完成后，动态前台获取
//			productObjectVO.getSupplierProductSkuDTOs().get(0).getSupplierProductPriceMap().setDealerprice(new BigDecimal(222));


			// 设置b2c的商品价格
			List<SupplierProductSkuDTO> skuProductList = productObjectVO.getSupplierProductSkuDTOs();
			if(CollectionUtils.isNotEmpty(skuProductList) && (unitPrice.length > 0) && (domesticPrice.length > 0) && (bestoayPrice.length > 0)){
				for(int i=0;i<skuProductList.size();i++){
					skuProductList.get(i).getSupplierProductPriceMap().setUnitPrice(new BigDecimal(unitPrice[i]));
					skuProductList.get(i).getSupplierProductPriceMap().setDomesticPrice(new BigDecimal(domesticPrice[i]));
					skuProductList.get(i).getSupplierProductPriceMap().setBestoayPrice(new BigDecimal(bestoayPrice[i]));
					
					skuProductList.get(i).getSupplierProductPriceMap().setFhed(new BigDecimal(fhed[i]));
				}
			}

			if (null != RemoteServiceSingleton.getInstance()
					.getSupplierProductService() && a!=1) {
				try {
					// TODO
					LOGGER.info("addProduct...");

					RemoteServiceSingleton.getInstance()
							.getSupplierProductService()
							.saveProductObjectForB2C(productObjectVO);
					LOGGER.info("保存商品成功!!!");

					issavestatuinfo = "1";

				} catch (SupplierProException e) {
					LOGGER.error("保存商品失败！！！supplierId:"
							+ getCurrentSupplierId() + "productName:" + pname
							+ e.getMessage(), e);
					issavestatuinfo = "0";
				}
			}
			if( a==1){
				issavestatuinfo = "2";
			}

		} catch (Exception e) {
			LOGGER.error("商品保存出错  msg:" + e.getMessage(), e);
			issavestatuinfo = "0";
		}
		return issavestatuinfo;
	}

	
	
	
	
	/**
	 * 发布幸福购商品
	 * @param request
	 * @param objectVO
	 * @param cost
	 * @param attrRows
	 * @param saleAttrRows
	 * @param attrOrd
	 * @param attrName
	 * @param start
	 * @param fristPhone
	 * @param subPhone
	 * @param pic
	 * @param buyIndex
	 * @param saleIndex
	 * @param saleIndex2
	 * @param saleIndex3
	 * @param saleIndex4
	 * @param productPic
	 * @param minNum
	 * @param saleVal
	 * @param saleVal2
	 * @param saleVal3
	 * @param saleVal4
	 * @param buyVal
	 * @param pname
	 * @param brandId
	 * @param subBrandId
	 * @param skuCode
	 * @param barCodeImg
	 * @param imgUrl
	 * @param buyName
	 * @param saleName
	 * @param saleName2
	 * @param saleName3
	 * @param saleName4
	 * @param unitPrice
	 * @param domesticPrice
	 * @param bestoayPrice
	 * @param productCode
	 * @param auto
	 * @param priceType
	 * @param fobPort
	 * @param hqj
	 * @param fhed
	 * @param cifPort
	 * @param editorValue
	 * @return
	 */
	@RequestMapping("/product/addXf")
	@ResponseBody
	public String saveProductXf(HttpServletRequest request,
			SupplierProductObjectDTO objectVO, Integer cost,
			String[] attrRows,String[] saleAttrRows,String[] attrOrd,String[] attrName,
			Long[] start, String fristPhone, String subPhone, BigDecimal[] pic,
			Integer buyIndex, Integer saleIndex, Integer saleIndex2, Integer saleIndex3, Integer saleIndex4, 
			BigDecimal[] productPic,
			Long minNum, Long[] saleVal, Long[] saleVal2, Long[] saleVal3, Long[] saleVal4, Long[] buyVal, String pname,
			String brandId, String subBrandId, String skuCode[],
			String[] barCodeImg, String[] imgUrl, String[] buyName,
			String[] saleName, String[] saleName2,String[] saleName3,String[] saleName4,
			String[]unitPrice,String[]domesticPrice,String[]bestoayPrice,String[]productCode,Integer auto, Integer priceType, String fobPort,
			String[] hqj,String[] fhed,String cifPort, String editorValue) {

		LOGGER.info("enter_addProduct_Mothod=supplierId:"
				+ getCurrentSupplierId());

		Long productId = objectVO.getProductId();

		if (null != productId) {
			try {
				RemoteServiceSingleton.getInstance()
						.getSupplierDraftProductService()
						.deleteDraftProductById(productId, "");
			} catch (Exception e) {
				LOGGER.info("不是草稿商品pid：" + productId);
			}
		}

    	List<SupplierProductAttrDTO> attrDTOs = new ArrayList<SupplierProductAttrDTO>();
    	//普通属性
    	if(attrRows!=null && attrRows.length>0){
    		for(int i=0;i<attrRows.length;i++){
        		SupplierProductAttrDTO attrDto = new SupplierProductAttrDTO();
        		SupplierProductAttr attr = new SupplierProductAttr();
        		List<SupplierProductAttrval> listAttrval = new ArrayList<SupplierProductAttrval>();
        		String type = request.getParameter("type"+attrRows[i]);
        		attr.setType(Short.valueOf(type));
        		attr.setAttrNameCn(attrName[i]);
        		attr.setAttrName(attrName[i]);
        		attr.setBuyAttr(Short.valueOf("0"));
        		attr.setSaleAttr(Short.valueOf("0"));
        		attr.setIsneed(Short.valueOf("-1"));
        		attr.setSortval(Integer.parseInt(attrOrd[i]));
        		String[] attrvals = request.getParameterValues("attrval"+attrRows[i]);
        		for (String val : attrvals) {
        			if(val!=null && "".equals(val)){
        				val = "-";
        			}
        			SupplierProductAttrval attrval = new SupplierProductAttrval();
            		attrval.setAttrNameCn(attrName[i]);
        			attrval.setAttrName(attrName[i]);
        			attrval.setLineAttrvalName(val);
        			attrval.setLineAttrvalNameCn(val);
        			attrval.setIstate(Short.valueOf("1"));
        			listAttrval.add(attrval);
    			}
        		attrDto.setSupplierProductAttr(attr);
        		attrDto.setSupplierProductAttrvals(listAttrval);
        		attrDTOs.add(attrDto);
        	}
    	}
    	//展示属性
    	String buyAttrname = request.getParameter("buyAttrName");
    	int a=0;
    	if(buyAttrname!=null && !"".equals(buyAttrname)){
    		SupplierProductAttrDTO attrDto = new SupplierProductAttrDTO();
    		SupplierProductAttr attr = new SupplierProductAttr();
    		List<SupplierProductAttrval> listAttrval = new ArrayList<SupplierProductAttrval>();
    		attr.setType(Short.valueOf("2"));
    		attr.setAttrNameCn(buyAttrname);
    		attr.setAttrName(buyAttrname);
    		attr.setBuyAttr(Short.valueOf("1"));
    		attr.setSaleAttr(Short.valueOf("0"));
    		attr.setIsneed(Short.valueOf("1"));
    		attr.setSortval(1);
    		String[] buyAttrvals = request.getParameterValues("buyAttrval");
    		if(buyAttrvals.length>1){
    			for(int i=0;i<buyAttrvals.length;i++){
    				if(buyAttrvals[0].equals(buyAttrvals[1])){
    					a=1;
    				}
        			
        		}
    		}
    		
    		for (String val : buyAttrvals) {
    			if(val!=null && "".equals(val)){
    				val = "-";
    			}
    			SupplierProductAttrval attrval = new SupplierProductAttrval();
        		attrval.setAttrNameCn(buyAttrname);
    			attrval.setAttrName(buyAttrname);
    			attrval.setLineAttrvalName(val);
    			attrval.setLineAttrvalNameCn(val);
    			attrval.setIstate(Short.valueOf("1"));
    			listAttrval.add(attrval);
    			
			}
    		attrDto.setSupplierProductAttr(attr);
    		attrDto.setSupplierProductAttrvals(listAttrval);
    		buyIndex=attrDTOs.size();
    		attrDTOs.add(attrDto);
    	}
    	//规格属性
    	String saleAttrname = request.getParameter("saleAttrName0");
    	if(saleAttrname!=null && !"".equals(saleAttrname)){
    		SupplierProductAttrDTO attrDto = new SupplierProductAttrDTO();
    		SupplierProductAttr attr = new SupplierProductAttr();
    		List<SupplierProductAttrval> listAttrval = new ArrayList<SupplierProductAttrval>();
    		attr.setType(Short.valueOf("2"));
    		attr.setAttrNameCn(saleAttrname);
    		attr.setAttrName(saleAttrname);
    		attr.setBuyAttr(Short.valueOf("0"));
    		attr.setSaleAttr(Short.valueOf("1"));
    		attr.setIsneed(Short.valueOf("1"));
    		attr.setSortval(1);
    		String[] saleAttrvals = request.getParameterValues("saleAttrval0");
    		for (String val : saleAttrvals) {
    			if(val!=null && "".equals(val)){
    				val = "-";
    			}
    			SupplierProductAttrval attrval = new SupplierProductAttrval();
        		attrval.setAttrNameCn(saleAttrname);
    			attrval.setAttrName(saleAttrname);
    			attrval.setLineAttrvalName(val);
    			attrval.setLineAttrvalNameCn(val);
    			attrval.setIstate(Short.valueOf("1"));
    			listAttrval.add(attrval);
			}
    		attrDto.setSupplierProductAttr(attr);
    		attrDto.setSupplierProductAttrvals(listAttrval);
    		saleIndex=attrDTOs.size();
    		attrDTOs.add(attrDto);
    	}
    	
    	//规格属性
    	String saleAttrname2 = request.getParameter("saleAttrName1");
    	if(saleAttrname2!=null && !"".equals(saleAttrname2)){
    		SupplierProductAttrDTO attrDto = new SupplierProductAttrDTO();
    		SupplierProductAttr attr = new SupplierProductAttr();
    		List<SupplierProductAttrval> listAttrval = new ArrayList<SupplierProductAttrval>();
    		attr.setType(Short.valueOf("1"));
    		attr.setAttrNameCn(saleAttrname2);
    		attr.setAttrName(saleAttrname2);
    		attr.setBuyAttr(Short.valueOf("0"));
    		attr.setSaleAttr(Short.valueOf("1"));
    		attr.setIsneed(Short.valueOf("1"));
    		attr.setSortval(2);
    		String[] saleAttrvals = request.getParameterValues("saleAttrval1");
    		for (String val : saleAttrvals) {
    			if(val!=null && "".equals(val)){
    				val = "-";
    			}
    			SupplierProductAttrval attrval = new SupplierProductAttrval();
        		attrval.setAttrNameCn(saleAttrname2);
    			attrval.setAttrName(saleAttrname2);
    			attrval.setLineAttrvalName(val);
    			attrval.setLineAttrvalNameCn(val);
    			attrval.setIstate(Short.valueOf("1"));
    			listAttrval.add(attrval);
			}
    		attrDto.setSupplierProductAttr(attr);
    		attrDto.setSupplierProductAttrvals(listAttrval);
    		saleIndex2=attrDTOs.size();
    		attrDTOs.add(attrDto);
    	}
    	//规格属性
    	String saleAttrname3 = request.getParameter("saleAttrName2");
    	if(saleAttrname3!=null && !"".equals(saleAttrname3)){
    		SupplierProductAttrDTO attrDto = new SupplierProductAttrDTO();
    		SupplierProductAttr attr = new SupplierProductAttr();
    		List<SupplierProductAttrval> listAttrval = new ArrayList<SupplierProductAttrval>();
    		attr.setType(Short.valueOf("1"));
    		attr.setAttrNameCn(saleAttrname3);
    		attr.setAttrName(saleAttrname3);
    		attr.setBuyAttr(Short.valueOf("0"));
    		attr.setSaleAttr(Short.valueOf("1"));
    		attr.setIsneed(Short.valueOf("1"));
    		attr.setSortval(3);
    		String[] saleAttrvals = request.getParameterValues("saleAttrval2");
    		for (String val : saleAttrvals) {
    			if(val!=null && "".equals(val)){
    				val = "-";
    			}
    			SupplierProductAttrval attrval = new SupplierProductAttrval();
        		attrval.setAttrNameCn(saleAttrname3);
    			attrval.setAttrName(saleAttrname3);
    			attrval.setLineAttrvalName(val);
    			attrval.setLineAttrvalNameCn(val);
    			attrval.setIstate(Short.valueOf("1"));
    			listAttrval.add(attrval);
			}
    		attrDto.setSupplierProductAttr(attr);
    		attrDto.setSupplierProductAttrvals(listAttrval);
    		saleIndex3=attrDTOs.size();
    		attrDTOs.add(attrDto);
    	}
    	//规格属性
    	String saleAttrname4 = request.getParameter("saleAttrName3");
    	if(saleAttrname4!=null && !"".equals(saleAttrname4)){
    		SupplierProductAttrDTO attrDto = new SupplierProductAttrDTO();
    		SupplierProductAttr attr = new SupplierProductAttr();
    		List<SupplierProductAttrval> listAttrval = new ArrayList<SupplierProductAttrval>();
    		attr.setType(Short.valueOf("1"));
    		attr.setAttrNameCn(saleAttrname4);
    		attr.setAttrName(saleAttrname4);
    		attr.setBuyAttr(Short.valueOf("0"));
    		attr.setSaleAttr(Short.valueOf("1"));
    		attr.setIsneed(Short.valueOf("1"));
    		attr.setSortval(4);
    		String[] saleAttrvals = request.getParameterValues("saleAttrval3");
    		for (String val : saleAttrvals) {
    			if(val!=null && "".equals(val)){
    				val = "-";
    			}
    			SupplierProductAttrval attrval = new SupplierProductAttrval();
        		attrval.setAttrNameCn(saleAttrname4);
    			attrval.setAttrName(saleAttrname4);
    			attrval.setLineAttrvalName(val);
    			attrval.setLineAttrvalNameCn(val);
    			attrval.setIstate(Short.valueOf("1"));
    			listAttrval.add(attrval);
			}
    		attrDto.setSupplierProductAttr(attr);
    		attrDto.setSupplierProductAttrvals(listAttrval);
    		saleIndex4=attrDTOs.size();
    		attrDTOs.add(attrDto);
    	}
    	objectVO.setSupplierProductAttrDTOs(attrDTOs);
 
		
		/**
		 * 设置展示属性的图片url
		 */
		String issavestatuinfo = null;

		try {

			List<SupplierProductAttach> attachs = new ArrayList<SupplierProductAttach>();

			/**
			 * 设置商品资质
			 */
			List<String> BuyAttrValUrl = new ArrayList<String>();

			for (int x = 0; x < imgUrl.length; x++) {

				String[] prodImg = imgUrl[x].split("_");
				StringBuffer sb = new StringBuffer();

				for (int i = 1; i < prodImg.length; i++) {

					if (i > 1) {
						sb.append("_");
					}

					sb.append(prodImg[i]);

				}

				if ("00".equals(prodImg[0])) {

					SupplierProductAttach prodQualification = new SupplierProductAttach();
					String qualification = sb.toString();
					qualification = qualification.substring(qualification
							.indexOf("group"));
					prodQualification.setFileurl(qualification);
					prodQualification.setType(Constants.PRODUCT_QUALIFICATION);
					attachs.add(prodQualification);

				} else {
					BuyAttrValUrl.add(imgUrl[x]);
				}

			}

			List<Integer> buyMap = new ArrayList<Integer>();
			Map<Integer, List<SupplierProductBuyAttrval>> map = new LinkedHashMap<Integer, List<SupplierProductBuyAttrval>>();

			if (null != BuyAttrValUrl && BuyAttrValUrl.size() > 0) {

				for (int x = 0; x < BuyAttrValUrl.size(); x++) {

					String[] split = BuyAttrValUrl.get(x).split("_");
					Integer index = Integer.parseInt(split[0].substring(10, split[0].length()));//buyAttrval1
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
						prodImgurl = prodImgurl.substring(prodImgurl
								.indexOf("group"));
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
						prodImgurl = prodImgurl.substring(prodImgurl
								.indexOf("group"));
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

			/**
			 * 商品基本信息
			 */
			objectVO.getSupplierProductBase().setProductname(pname);
			objectVO.getSupplierProductBaseEn().setProductname(pname);
			objectVO.getSupplierProduct().setProdType((short) 6);

			LOGGER.info("insertSkuInfo!!!");
			/**
			 * sku信息
			 */
			List<SupplierProductSkuDTO> productSkuVOs = new ArrayList<SupplierProductSkuDTO>();
			SupplierProductSaleSetting productSaleSetting = objectVO
					.getSupplierProductSaleSetting();
			List<SupplierProductWholesaleRange> wholesaleRanges = new ArrayList<SupplierProductWholesaleRange>();

			if (!Constants.DOMESTIC_DEALER.equals(getSupplierType())) {
				// 1按梯度家报价 2按sku报价
				if (null != cost && cost == 2) {
					// TODO
					productSaleSetting.setMaxSellerPrice(Common
							.getMax2(productPic));
					productSaleSetting.setMinSellerPrice(Common
							.getMin2(productPic));
					productSaleSetting.setMinWholesaleQty(minNum);

					for (int i = 0; i < buyVal.length; i++) {

						SupplierProductSkuDTO skuVO = new SupplierProductSkuDTO();
						SupplierProductSku productSku = new SupplierProductSku();
						// todo
						String skuCodeNum = "";
						String barCodeImage = "";
						if (null != auto && 1 == auto) {

							skuCodeNum = JBarCodeUtil.getCreateRandom();
							barCodeImage = JBarCodeUtil
									.getBarCodeUrl(skuCodeNum);

							LOGGER.info("系统自动生成验证码：" + skuCodeNum
									+ ";BarCodeUrl：" + barCodeImage);

						} else {

							skuCodeNum = skuCode[i];
							barCodeImage = barCodeImg[i]
									.substring(barCodeImg[i].indexOf("group"));

						}

						productSku.setSkuCode(skuCodeNum);

						productSku.setBarCodeImage(barCodeImage);

						productSku.setCreateDate(new Date());
						productSku.setSaleStatus(Constants.PRODUCT_STATUS_SUCCESS);
						if(buyName != null && buyName.length>0){
							buyName[i] = !"".equals(buyName[i])? buyName[i]:"-";
						}
						if(saleName != null && saleName.length>0){
							saleName[i] = !"".equals(saleName[i])? saleName[i]:"-";
						}
						String saleN2 = "";
	                    if(saleName2 !=null && saleName2.length>0){
	                    	saleN2=saleName2[i];
	                    }
	                    String saleN3 = "";
	                    if(saleName3 !=null && saleName3.length>0){
	                    	saleN3=saleName3[i];
	                    }
	                    String saleN4 = "";
	                    if(saleName4 !=null && saleName4.length>0){
	                    	saleN4=saleName4[i];
	                    }
	                    productSku.setSkuNameCn(buyName[i] + saleName[i] + saleN2 + saleN3 + saleN4);
	                    productSku.setSkuNameEn(buyName[i] + saleName[i] + saleN2 + saleN3 + saleN4);
	
						//商品货号
						if(productCode[i]!=null){	
							productSku.setProductCode(productCode[i]);
						}
						skuVO.setSupplierProductSku(productSku);

						List<SupplierProductSkuAttrval> supplierProductSkuAttrvals = new ArrayList<SupplierProductSkuAttrval>();
						SupplierProductSkuAttrval buyAttrval = new SupplierProductSkuAttrval();

						buyAttrval.setAttrId(Long.parseLong("" + buyIndex));
						buyAttrval.setAttrValId(buyVal[i]);
						buyAttrval.setSupplierid(getCurrentSupplierId());
						buyAttrval.setAttrvalNameCn(buyName[i]);

						supplierProductSkuAttrvals.add(buyAttrval);

						if (saleVal != null && saleVal.length > 0) {
	                    	
	                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
	                        
	                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex));
	                        saleAttrval.setAttrValId(saleVal[i]);
	                        saleAttrval.setSubsupplierid("");
	                        saleAttrval.setAttrvalNameCn(saleName[i]);
	                        
	                        supplierProductSkuAttrvals.add(saleAttrval);
	                    }
	                    if (saleVal2 != null && saleVal2.length > 0) {
	                    	
	                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
	                        
	                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex2));
	                        saleAttrval.setAttrValId(Long.valueOf(String.valueOf(saleVal2[i]).substring(1, String.valueOf(saleVal2[i]).length())));
	                        saleAttrval.setSubsupplierid("");
	                        saleAttrval.setAttrvalNameCn(saleName2[i]);
	                        
	                        supplierProductSkuAttrvals.add(saleAttrval);
	                    }
	                    if (saleVal3 != null && saleVal3.length > 0) {
	                    	
	                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
	                        
	                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex3));
	                        saleAttrval.setAttrValId(Long.valueOf(String.valueOf(saleVal3[i]).substring(1, String.valueOf(saleVal3[i]).length())));
	                        saleAttrval.setSubsupplierid("");
	                        saleAttrval.setAttrvalNameCn(saleName3[i]);
	                        
	                        supplierProductSkuAttrvals.add(saleAttrval);
	                    }
	                    if (saleVal4 != null && saleVal4.length > 0) {
	                    	
	                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
	                        
	                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex4));
	                        saleAttrval.setAttrValId(Long.valueOf(String.valueOf(saleVal4[i]).substring(1, String.valueOf(saleVal4[i]).length())));
	                        saleAttrval.setSubsupplierid("");
	                        saleAttrval.setAttrvalNameCn(saleName4[i]);
	                        
	                        supplierProductSkuAttrvals.add(saleAttrval);
	                    }

						skuVO.setSupplierProductSkuAttrvals(supplierProductSkuAttrvals);
						SupplierProductPrice price = new SupplierProductPrice();
						price.setSupplierprice(productPic[i]);
						skuVO.setSupplierProductPriceMap(price);
						productSkuVOs.add(skuVO);
					}
				}

				// 按照图梯度家设置价格
				if (null != cost && cost == 1) {

					productSaleSetting.setMaxSellerPrice(Common.getMax2(pic));
					productSaleSetting.setMinSellerPrice(Common.getMin2(pic));
					productSaleSetting.setMinWholesaleQty(start[0]);

					for (int i = 0; i < buyVal.length; i++) {

						SupplierProductSkuDTO skuVO = new SupplierProductSkuDTO();
						SupplierProductSku productSku = new SupplierProductSku();

						// todo
						String skuCodeNum = "";
						String barCodeImage = "";

						if (null != auto && 1 == auto) {

							skuCodeNum = JBarCodeUtil.getCreateRandom();
							barCodeImage = JBarCodeUtil
									.getBarCodeUrl(skuCodeNum);

							LOGGER.info("系统自动生成验证码：" + skuCodeNum
									+ ";BarCodeUrl：" + barCodeImage);

						} else {

							skuCodeNum = skuCode[i];
							barCodeImage = barCodeImg[i]
									.substring(barCodeImg[i].indexOf("group"));

						}

						productSku.setSkuCode(skuCodeNum);
						productSku.setBarCodeImage(barCodeImage);

						productSku.setCreateDate(new Date());
						productSku
								.setSaleStatus(Constants.PRODUCT_STATUS_SUCCESS);
						productSku.setIstate(Constants.PRODUCT_STATUS_SUCCESS);
						if(buyName != null && buyName.length>0){
							buyName[i] = !"".equals(buyName[i])? buyName[i]:"-";
						}
						if(saleName != null && saleName.length>0){
							saleName[i] = !"".equals(saleName[i])? saleName[i]:"-";
						}
						String saleN2 = "";
	                    if(saleName2 !=null && saleName2.length>0){
	                    	saleN2=saleName2[i];
	                    }
	                    String saleN3 = "";
	                    if(saleName3 !=null && saleName3.length>0){
	                    	saleN3=saleName3[i];
	                    }
	                    String saleN4 = "";
	                    if(saleName4 !=null && saleName4.length>0){
	                    	saleN4=saleName4[i];
	                    }
	                    productSku.setSkuNameCn(buyName[i] + saleName[i] + saleN2 + saleN3 + saleN4);
	                    productSku.setSkuNameEn(buyName[i] + saleName[i] + saleN2 + saleN3 + saleN4);
	                    //商品货号
						if(productCode[i]!=null){	
							productSku.setProductCode(productCode[i]);
						}
						skuVO.setSupplierProductSku(productSku);

						List<SupplierProductSkuAttrval> supplierProductSkuAttrvals = new ArrayList<SupplierProductSkuAttrval>();

						SupplierProductSkuAttrval buyAttrval = new SupplierProductSkuAttrval();
						buyAttrval.setAttrId(Long.parseLong("" + buyIndex));
						buyAttrval.setAttrValId(buyVal[i]);
						buyAttrval.setSupplierid(getCurrentSupplierId());
						buyAttrval.setAttrvalNameCn(buyName[i]);
						supplierProductSkuAttrvals.add(buyAttrval);

						if (saleVal != null && saleVal.length > 0) {
	                    	
	                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
	                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex));
	                        saleAttrval.setAttrValId(saleVal[i]);
	                        saleAttrval.setSubsupplierid("");
	                        saleAttrval.setAttrvalNameCn(saleName[i]);
	                        supplierProductSkuAttrvals.add(saleAttrval);
	                    }
	                    if (saleVal2 != null && saleVal2.length > 0) {
	                    	
	                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
	                        
	                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex2));
	                        saleAttrval.setAttrValId(Long.valueOf(String.valueOf(saleVal2[i]).substring(1, String.valueOf(saleVal2[i]).length())));
	                        saleAttrval.setSubsupplierid("");
	                        saleAttrval.setAttrvalNameCn(saleName2[i]);
	                        
	                        supplierProductSkuAttrvals.add(saleAttrval);
	                    }
	                    if (saleVal3 != null && saleVal3.length > 0) {
	                    	
	                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
	                        
	                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex3));
	                        saleAttrval.setAttrValId(Long.valueOf(String.valueOf(saleVal3[i]).substring(1, String.valueOf(saleVal3[i]).length())));
	                        saleAttrval.setSubsupplierid("");
	                        saleAttrval.setAttrvalNameCn(saleName3[i]);
	                        
	                        supplierProductSkuAttrvals.add(saleAttrval);
	                    }
	                    if (saleVal4 != null && saleVal4.length > 0) {
	                    	
	                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
	                        
	                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex4));
	                        saleAttrval.setAttrValId(Long.valueOf(String.valueOf(saleVal4[i]).substring(1, String.valueOf(saleVal4[i]).length())));
	                        saleAttrval.setSubsupplierid("");
	                        saleAttrval.setAttrvalNameCn(saleName4[i]);
	                        
	                        supplierProductSkuAttrvals.add(saleAttrval);
	                    }

						skuVO.setSupplierProductSkuAttrvals(supplierProductSkuAttrvals);
						SupplierProductPrice price = new SupplierProductPrice();
						price.setSupplierprice(Common.getMax2(pic));
						skuVO.setSupplierProductPriceMap(price);
						productSkuVOs.add(skuVO);
					}

					// 设置梯度价格
					for (int i = 0; i < pic.length; i++) {

						SupplierProductWholesaleRange range = new SupplierProductWholesaleRange();
						range.setStartQty(start[i]);
						Long endQty = 0L;

						if (i + 1 < pic.length) {

							endQty = start[i + 1] - 1;
						}

						if (i == pic.length - 1) {

							endQty = 0L;
						}

						range.setEndQty(endQty);
						range.setDiscountType("0");
						range.setDiscount(pic[i]);
						wholesaleRanges.add(range);
					}

				}
			}

			// TODO 国内经销商不设置价格信息
			if (Constants.DOMESTIC_DEALER.equals(getSupplierType())) {

				objectVO.getSupplierProduct().setProdType(
						Constants.PRODUCT_TYPE);
				objectVO.getSupplierProductDetail().setPriceType(
						Constants.PRODUCT_PRICE_TYPE_DEALER);
				objectVO.getSupplierProductDetail().setOrderType(
						Constants.PRODUCT_STATUS_SUCCESS);

				for (int i = 0; i < buyVal.length; i++) {

					SupplierProductSkuDTO skuVO = new SupplierProductSkuDTO();
					SupplierProductSku productSku = new SupplierProductSku();

					// todo
					String skuCodeNum = "";
					String barCodeImage = "";

					if (null != auto && 1 == auto) {

						skuCodeNum = JBarCodeUtil.getCreateRandom();
						barCodeImage = JBarCodeUtil.getBarCodeUrl(skuCodeNum);

						LOGGER.info("系统自动生成验证码：" + skuCodeNum + ";BarCodeUrl："
								+ barCodeImage);

					} else {
						skuCodeNum = skuCode[i];
						barCodeImage = barCodeImg[i].substring(barCodeImg[i]
								.indexOf("group"));
					}

					productSku.setSkuCode(skuCodeNum);
					productSku.setBarCodeImage(barCodeImage);

					productSku.setCreateDate(new Date());
					productSku.setSaleStatus(Constants.PRODUCT_STATUS_SUCCESS);
					productSku.setIstate(Constants.PRODUCT_STATUS_SUCCESS);
					String saleN2 = "";
                    if(saleName2 !=null && saleName2.length>0){
                    	saleN2=saleName2[i];
                    }
                    String saleN3 = "";
                    if(saleName3 !=null && saleName3.length>0){
                    	saleN3=saleName3[i];
                    }
                    String saleN4 = "";
                    if(saleName4 !=null && saleName4.length>0){
                    	saleN4=saleName4[i];
                    }
                    if(buyName != null && buyName.length>0){
						buyName[i] = !"".equals(buyName[i])? buyName[i]:"-";
					}
					if(saleName != null && saleName.length>0){
						saleName[i] = !"".equals(saleName[i])? saleName[i]:"-";
					}
					productSku.setSkuNameCn(buyName[i] + saleName[i] + saleN2 + saleN3 + saleN4);
                    productSku.setSkuNameEn(buyName[i] + saleName[i] + saleN2 + saleN3 + saleN4);
                    //商品货号
					if(productCode[i]!=null){	
						productSku.setProductCode(productCode[i]);
					}
					skuVO.setSupplierProductSku(productSku);

					List<SupplierProductSkuAttrval> supplierProductSkuAttrvals = new ArrayList<SupplierProductSkuAttrval>();

					SupplierProductSkuAttrval buyAttrval = new SupplierProductSkuAttrval();
					buyAttrval.setAttrId(Long.parseLong("" + buyIndex));
					buyAttrval.setAttrValId(buyVal[i]);
					buyAttrval.setSupplierid(getCurrentSupplierId());
					buyAttrval.setAttrvalNameCn(buyName[i]);
					supplierProductSkuAttrvals.add(buyAttrval);

					if (saleVal != null && saleVal.length > 0) {
                    	
                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex));
                        saleAttrval.setAttrValId(saleVal[i]);
                        saleAttrval.setSubsupplierid("");
                        saleAttrval.setAttrvalNameCn(saleName[i]);
                        supplierProductSkuAttrvals.add(saleAttrval);
                    }                    
                    if (saleVal2 != null && saleVal2.length > 0) {
                    	
                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex2));
                        saleAttrval.setAttrValId(Long.valueOf(String.valueOf(saleVal2[i]).substring(1, String.valueOf(saleVal2[i]).length())));
                        saleAttrval.setSubsupplierid("");
                        saleAttrval.setAttrvalNameCn(saleName2[i]);
                        supplierProductSkuAttrvals.add(saleAttrval);
                    }
                    if (saleVal3 != null && saleVal3.length > 0) {
                    	
                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex3));
                        saleAttrval.setAttrValId(Long.valueOf(String.valueOf(saleVal3[i]).substring(1, String.valueOf(saleVal3[i]).length())));
                        saleAttrval.setSubsupplierid("");
                        saleAttrval.setAttrvalNameCn(saleName3[i]);
                        supplierProductSkuAttrvals.add(saleAttrval);
                    }
                    if (saleVal4 != null && saleVal4.length > 0) {
                    	
                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex4));
                        saleAttrval.setAttrValId(Long.valueOf(String.valueOf(saleVal4[i]).substring(1, String.valueOf(saleVal4[i]).length())));
                        saleAttrval.setSubsupplierid("");
                        saleAttrval.setAttrvalNameCn(saleName4[i]);
                        supplierProductSkuAttrvals.add(saleAttrval);
                    }

					skuVO.setSupplierProductSkuAttrvals(supplierProductSkuAttrvals);
					SupplierProductPrice price = new SupplierProductPrice();
					skuVO.setSupplierProductPriceMap(price);
					productSkuVOs.add(skuVO);
				}

			}

			// 设置sku图片信息
			for (int x = 0; x < objectVO.getSupplierProductAttrDTOs().size(); x++) {

				if (objectVO.getSupplierProductAttrDTOs().get(x)
						.getSupplierProductAttr().getBuyAttr() == 1) {

					objectVO.getSupplierProductAttrDTOs().get(x).setMap(map);

				}
			}

			objectVO.setSupplierProductSkuDTOs(productSkuVOs);
			objectVO.setSupplierProductSaleSetting(productSaleSetting);

			if (!Constants.DOMESTIC_DEALER.equals(getSupplierType())) {

				objectVO.setSupplierProductWholesaleRanges(wholesaleRanges);
			}

			/**
			 * 商品核心信息
			 */
			objectVO.getSupplierProduct().setAuditReason(
					Constants.PRODUCT_STATUS_SUCCESS);

			objectVO.getSupplierProduct().setSuppliername(
					getSupplier().getName());
			objectVO.getSupplierProduct().setOperator("" + getCurrentUserId());

			if (subBrandId != null && !"".equals(subBrandId)) {

				try {

					Brand firstBrand = RemoteServiceSingleton.getInstance()
							.getCategoryServiceRpc().getBrandByID(brandId);
					SubBrand subBrand = RemoteServiceSingleton.getInstance()
							.getCategoryServiceRpc()
							.getSubBrandByid(subBrandId);
					objectVO.setBrand(firstBrand);
					objectVO.setSubBrand(subBrand);
					objectVO.getSupplierProduct().setBrandId(subBrandId);

					LOGGER.info("设置品牌成功！！！subBrandId=" + subBrandId);

				} catch (Exception e) {

					LOGGER.error("获取品牌失败！！！" + e.getMessage(), e);

					throw new Exception("获取品牌失败！！！" + e.getMessage(), e);
				}

			} else {

				try {

					Brand firstBrand = RemoteServiceSingleton.getInstance()
							.getCategoryServiceRpc().getBrandByID(brandId);
					objectVO.setBrand(firstBrand);
					objectVO.getSupplierProduct().setBrandId(brandId);
					LOGGER.info("设置品牌成功！！！brandId=" + brandId);

				} catch (Exception e) {

					LOGGER.error("获取品牌失败！！！" + e.getMessage(), e);
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
				if(editorValue.indexOf("detail_inner.css")==-1){
	            	String startStr="<link rel=\"stylesheet\" href=\"http://static.3qianwan.com/commons/css/detail_inner.css\" type=\"text/css\"><div class='detail_inner' >";
	            	String endStr="</div>";
	            	editorValue=startStr+editorValue+endStr;
	            }
				byte[] picByte = editorValue.getBytes();
				try {

					ByteArrayInputStream stream = new ByteArrayInputStream(
							picByte);
					fileUrl = UploadFileUtil.uploadFile(stream, null, null);
					LOGGER.info("图文详情上传成功！！！");

				} catch (Exception e) {

					LOGGER.error("图文详情上传失败！！！" + e.getMessage(), e);
					throw new Exception("图文详情上传失败！！！" + e.getMessage(), e);
				}
			}

			attach.setFileurl(fileUrl);
			attach.setType(Constants.PRODUCT_DESCRIPTIONS);
			attachs.add(attach);
			objectVO.setSupplierProductAttachs(attachs);

			SupplierProductDetail productDetail = objectVO
					.getSupplierProductDetail();

			// 设置售后电话
			String servicePhone = null;
			if (!Common.isEmpty(fristPhone)) {
				servicePhone = "39-" + fristPhone + "-" + subPhone;
				productDetail.setSalesCalls(servicePhone);
			}

			if (!Constants.DOMESTIC_DEALER.equals(getSupplierType())
					&& null != priceType) {
				if (0 == priceType) {

					productDetail
							.setPriceType(Constants.PRODUCT_PRICE_TYPE_FOB);
					productDetail.setPortName(fobPort);

				} else if (1 == priceType) {

					productDetail
							.setPriceType(Constants.PRODUCT_PRICE_TYPE_CIF);
					productDetail.setPortName(cifPort);

				} else if (2 == priceType) {

					productDetail
							.setPriceType(Constants.PRODUCT_PRICE_TYPE_EXW);

				} else {
					throw new Exception("价格类型有误！！！");
				}
			}

			// 去除属性值为空的属性
			objectVO.getB2cProductDetail().setB2cProductName(pname);//B2C商品名称
			objectVO.getB2cProductDetail().setB2cDescription(fileUrl);//图文详情
			SupplierProductObjectDTO productObjectVO = CopyBeanUtil.copy(
					objectVO, buyMap);

			// 标识是中文还是英文
			if ("/en".equals(getLanguage()) || "/en" == getLanguage()) {

				productObjectVO.getSupplierProduct().setMnemonicCode("2");

			} else {

				productObjectVO.getSupplierProduct().setMnemonicCode("1");

			}

			productObjectVO.setSupplierid(getCurrentSupplierId());
			productObjectVO.setSubsupplierid("");
//			productObjectVO.getSupplierProductSkuDTOs().get(0).getSupplierProductPriceMap().setUnitPrice(new BigDecimal(111));//TODO临时，前台修改完成后，动态前台获取
//			productObjectVO.getSupplierProductSkuDTOs().get(0).getSupplierProductPriceMap().setDealerprice(new BigDecimal(222));


			// 设置b2c的商品价格
			List<SupplierProductSkuDTO> skuProductList = productObjectVO.getSupplierProductSkuDTOs();
			if(CollectionUtils.isNotEmpty(skuProductList) && (unitPrice.length > 0) && (domesticPrice.length > 0) && (bestoayPrice.length > 0)){
				for(int i=0;i<skuProductList.size();i++){
					skuProductList.get(i).getSupplierProductPriceMap().setUnitPrice(new BigDecimal(unitPrice[i]));
					skuProductList.get(i).getSupplierProductPriceMap().setDomesticPrice(new BigDecimal(domesticPrice[i]));
					skuProductList.get(i).getSupplierProductPriceMap().setBestoayPrice(new BigDecimal(bestoayPrice[i]));
					skuProductList.get(i).getSupplierProductPriceMap().setCashHqj(new BigDecimal(hqj[i]));
					skuProductList.get(i).getSupplierProductPriceMap().setFhed(new BigDecimal(fhed[i]));
				}
			}

			if (null != RemoteServiceSingleton.getInstance()
					.getSupplierProductService() && a!=1) {
				try {
					// TODO
					LOGGER.info("addProduct...");

					RemoteServiceSingleton.getInstance()
							.getSupplierProductService()
							.saveProductObjectForB2C(productObjectVO);
					LOGGER.info("保存商品成功!!!");

					issavestatuinfo = "1";

				} catch (SupplierProException e) {
					LOGGER.error("保存商品失败！！！supplierId:"
							+ getCurrentSupplierId() + "productName:" + pname
							+ e.getMessage(), e);
					issavestatuinfo = "0";
				}
			}
			if(a==1){
				issavestatuinfo = "2";
			}

		} catch (Exception e) {
			LOGGER.error("商品保存出错  msg:" + e.getMessage(), e);
			issavestatuinfo = "0";
		}
		return issavestatuinfo;
	}
	
	
	
	
	
	
	
	/**
	 * 发布家庭易物商品
	 * @param request
	 * @param objectVO
	 * @param cost
	 * @param attrRows
	 * @param saleAttrRows
	 * @param attrOrd
	 * @param attrName
	 * @param start
	 * @param fristPhone
	 * @param subPhone
	 * @param pic
	 * @param buyIndex
	 * @param saleIndex
	 * @param saleIndex2
	 * @param saleIndex3
	 * @param saleIndex4
	 * @param productPic
	 * @param minNum
	 * @param saleVal
	 * @param saleVal2
	 * @param saleVal3
	 * @param saleVal4
	 * @param buyVal
	 * @param pname
	 * @param brandId
	 * @param subBrandId
	 * @param skuCode
	 * @param barCodeImg
	 * @param imgUrl
	 * @param buyName
	 * @param saleName
	 * @param saleName2
	 * @param saleName3
	 * @param saleName4
	 * @param unitPrice
	 * @param domesticPrice
	 * @param bestoayPrice
	 * @param productCode
	 * @param auto
	 * @param priceType
	 * @param fobPort
	 * @param hqj
	 * @param fhed
	 * @param cifPort
	 * @param editorValue
	 * @return
	 */
	@RequestMapping("/product/addfamily")
	@ResponseBody
	public String saveProduct1(HttpServletRequest request,
			SupplierProductObjectDTO objectVO, Integer cost,
			String[] attrRows,String[] saleAttrRows,String[] attrOrd,String[] attrName,
			Long[] start, String fristPhone, String subPhone, BigDecimal[] pic,
			Integer buyIndex, Integer saleIndex, Integer saleIndex2, Integer saleIndex3, Integer saleIndex4, 
			BigDecimal[] productPic,
			Long minNum, Long[] saleVal, Long[] saleVal2, Long[] saleVal3, Long[] saleVal4, Long[] buyVal, String pname,
			String brandId, String subBrandId, String skuCode[],
			String[] barCodeImg, String[] imgUrl, String[] buyName,
			String[] saleName, String[] saleName2,String[] saleName3,String[] saleName4,
			String[]unitPrice,String[]domesticPrice,String[]bestoayPrice,String[]productCode,Integer auto, Integer priceType, String fobPort,
			String[] hqj,String[] fhed,String cifPort, String editorValue) {

		LOGGER.info("enter_addProduct_Mothod=supplierId:"
				+ getCurrentSupplierId());

		Long productId = objectVO.getProductId();

		if (null != productId) {
			try {
				RemoteServiceSingleton.getInstance()
						.getSupplierDraftProductService()
						.deleteDraftProductById(productId, "");
			} catch (Exception e) {
				LOGGER.info("不是草稿商品pid：" + productId);
			}
		}

    	List<SupplierProductAttrDTO> attrDTOs = new ArrayList<SupplierProductAttrDTO>();
    	//普通属性
    	if(attrRows!=null && attrRows.length>0){
    		for(int i=0;i<attrRows.length;i++){
        		SupplierProductAttrDTO attrDto = new SupplierProductAttrDTO();
        		SupplierProductAttr attr = new SupplierProductAttr();
        		List<SupplierProductAttrval> listAttrval = new ArrayList<SupplierProductAttrval>();
        		String type = request.getParameter("type"+attrRows[i]);
        		attr.setType(Short.valueOf(type));
        		attr.setAttrNameCn(attrName[i]);
        		attr.setAttrName(attrName[i]);
        		attr.setBuyAttr(Short.valueOf("0"));
        		attr.setSaleAttr(Short.valueOf("0"));
        		attr.setIsneed(Short.valueOf("-1"));
        		attr.setSortval(Integer.parseInt(attrOrd[i]));
        		String[] attrvals = request.getParameterValues("attrval"+attrRows[i]);
        		for (String val : attrvals) {
        			if(val!=null && "".equals(val)){
        				val = "-";
        			}
        			SupplierProductAttrval attrval = new SupplierProductAttrval();
            		attrval.setAttrNameCn(attrName[i]);
        			attrval.setAttrName(attrName[i]);
        			attrval.setLineAttrvalName(val);
        			attrval.setLineAttrvalNameCn(val);
        			attrval.setIstate(Short.valueOf("1"));
        			listAttrval.add(attrval);
    			}
        		attrDto.setSupplierProductAttr(attr);
        		attrDto.setSupplierProductAttrvals(listAttrval);
        		attrDTOs.add(attrDto);
        	}
    	}
    	//展示属性
    	String buyAttrname = request.getParameter("buyAttrName");
    	if(buyAttrname!=null && !"".equals(buyAttrname)){
    		SupplierProductAttrDTO attrDto = new SupplierProductAttrDTO();
    		SupplierProductAttr attr = new SupplierProductAttr();
    		List<SupplierProductAttrval> listAttrval = new ArrayList<SupplierProductAttrval>();
    		attr.setType(Short.valueOf("2"));
    		attr.setAttrNameCn(buyAttrname);
    		attr.setAttrName(buyAttrname);
    		attr.setBuyAttr(Short.valueOf("1"));
    		attr.setSaleAttr(Short.valueOf("0"));
    		attr.setIsneed(Short.valueOf("1"));
    		attr.setSortval(1);
    		String[] buyAttrvals = request.getParameterValues("buyAttrval");
    		for (String val : buyAttrvals) {
    			if(val!=null && "".equals(val)){
    				val = "-";
    			}
    			SupplierProductAttrval attrval = new SupplierProductAttrval();
        		attrval.setAttrNameCn(buyAttrname);
    			attrval.setAttrName(buyAttrname);
    			attrval.setLineAttrvalName(val);
    			attrval.setLineAttrvalNameCn(val);
    			attrval.setIstate(Short.valueOf("1"));
    			listAttrval.add(attrval);
			}
    		attrDto.setSupplierProductAttr(attr);
    		attrDto.setSupplierProductAttrvals(listAttrval);
    		buyIndex=attrDTOs.size();
    		attrDTOs.add(attrDto);
    	}
    	//规格属性
    	String saleAttrname = request.getParameter("saleAttrName0");
    	if(saleAttrname!=null && !"".equals(saleAttrname)){
    		SupplierProductAttrDTO attrDto = new SupplierProductAttrDTO();
    		SupplierProductAttr attr = new SupplierProductAttr();
    		List<SupplierProductAttrval> listAttrval = new ArrayList<SupplierProductAttrval>();
    		attr.setType(Short.valueOf("2"));
    		attr.setAttrNameCn(saleAttrname);
    		attr.setAttrName(saleAttrname);
    		attr.setBuyAttr(Short.valueOf("0"));
    		attr.setSaleAttr(Short.valueOf("1"));
    		attr.setIsneed(Short.valueOf("1"));
    		attr.setSortval(1);
    		String[] saleAttrvals = request.getParameterValues("saleAttrval0");
    		for (String val : saleAttrvals) {
    			if(val!=null && "".equals(val)){
    				val = "-";
    			}
    			SupplierProductAttrval attrval = new SupplierProductAttrval();
        		attrval.setAttrNameCn(saleAttrname);
    			attrval.setAttrName(saleAttrname);
    			attrval.setLineAttrvalName(val);
    			attrval.setLineAttrvalNameCn(val);
    			attrval.setIstate(Short.valueOf("1"));
    			listAttrval.add(attrval);
			}
    		attrDto.setSupplierProductAttr(attr);
    		attrDto.setSupplierProductAttrvals(listAttrval);
    		saleIndex=attrDTOs.size();
    		attrDTOs.add(attrDto);
    	}
    	
    	//规格属性
    	String saleAttrname2 = request.getParameter("saleAttrName1");
    	if(saleAttrname2!=null && !"".equals(saleAttrname2)){
    		SupplierProductAttrDTO attrDto = new SupplierProductAttrDTO();
    		SupplierProductAttr attr = new SupplierProductAttr();
    		List<SupplierProductAttrval> listAttrval = new ArrayList<SupplierProductAttrval>();
    		attr.setType(Short.valueOf("1"));
    		attr.setAttrNameCn(saleAttrname2);
    		attr.setAttrName(saleAttrname2);
    		attr.setBuyAttr(Short.valueOf("0"));
    		attr.setSaleAttr(Short.valueOf("1"));
    		attr.setIsneed(Short.valueOf("1"));
    		attr.setSortval(2);
    		String[] saleAttrvals = request.getParameterValues("saleAttrval1");
    		for (String val : saleAttrvals) {
    			if(val!=null && "".equals(val)){
    				val = "-";
    			}
    			SupplierProductAttrval attrval = new SupplierProductAttrval();
        		attrval.setAttrNameCn(saleAttrname2);
    			attrval.setAttrName(saleAttrname2);
    			attrval.setLineAttrvalName(val);
    			attrval.setLineAttrvalNameCn(val);
    			attrval.setIstate(Short.valueOf("1"));
    			listAttrval.add(attrval);
			}
    		attrDto.setSupplierProductAttr(attr);
    		attrDto.setSupplierProductAttrvals(listAttrval);
    		saleIndex2=attrDTOs.size();
    		attrDTOs.add(attrDto);
    	}
    	//规格属性
    	String saleAttrname3 = request.getParameter("saleAttrName2");
    	if(saleAttrname3!=null && !"".equals(saleAttrname3)){
    		SupplierProductAttrDTO attrDto = new SupplierProductAttrDTO();
    		SupplierProductAttr attr = new SupplierProductAttr();
    		List<SupplierProductAttrval> listAttrval = new ArrayList<SupplierProductAttrval>();
    		attr.setType(Short.valueOf("1"));
    		attr.setAttrNameCn(saleAttrname3);
    		attr.setAttrName(saleAttrname3);
    		attr.setBuyAttr(Short.valueOf("0"));
    		attr.setSaleAttr(Short.valueOf("1"));
    		attr.setIsneed(Short.valueOf("1"));
    		attr.setSortval(3);
    		String[] saleAttrvals = request.getParameterValues("saleAttrval2");
    		for (String val : saleAttrvals) {
    			if(val!=null && "".equals(val)){
    				val = "-";
    			}
    			SupplierProductAttrval attrval = new SupplierProductAttrval();
        		attrval.setAttrNameCn(saleAttrname3);
    			attrval.setAttrName(saleAttrname3);
    			attrval.setLineAttrvalName(val);
    			attrval.setLineAttrvalNameCn(val);
    			attrval.setIstate(Short.valueOf("1"));
    			listAttrval.add(attrval);
			}
    		attrDto.setSupplierProductAttr(attr);
    		attrDto.setSupplierProductAttrvals(listAttrval);
    		saleIndex3=attrDTOs.size();
    		attrDTOs.add(attrDto);
    	}
    	//规格属性
    	String saleAttrname4 = request.getParameter("saleAttrName3");
    	if(saleAttrname4!=null && !"".equals(saleAttrname4)){
    		SupplierProductAttrDTO attrDto = new SupplierProductAttrDTO();
    		SupplierProductAttr attr = new SupplierProductAttr();
    		List<SupplierProductAttrval> listAttrval = new ArrayList<SupplierProductAttrval>();
    		attr.setType(Short.valueOf("1"));
    		attr.setAttrNameCn(saleAttrname4);
    		attr.setAttrName(saleAttrname4);
    		attr.setBuyAttr(Short.valueOf("0"));
    		attr.setSaleAttr(Short.valueOf("1"));
    		attr.setIsneed(Short.valueOf("1"));
    		attr.setSortval(4);
    		String[] saleAttrvals = request.getParameterValues("saleAttrval3");
    		for (String val : saleAttrvals) {
    			if(val!=null && "".equals(val)){
    				val = "-";
    			}
    			SupplierProductAttrval attrval = new SupplierProductAttrval();
        		attrval.setAttrNameCn(saleAttrname4);
    			attrval.setAttrName(saleAttrname4);
    			attrval.setLineAttrvalName(val);
    			attrval.setLineAttrvalNameCn(val);
    			attrval.setIstate(Short.valueOf("1"));
    			listAttrval.add(attrval);
			}
    		attrDto.setSupplierProductAttr(attr);
    		attrDto.setSupplierProductAttrvals(listAttrval);
    		saleIndex4=attrDTOs.size();
    		attrDTOs.add(attrDto);
    	}
    	objectVO.setSupplierProductAttrDTOs(attrDTOs);
 
		
		/**
		 * 设置展示属性的图片url
		 */
		String issavestatuinfo = null;

		try {

			List<SupplierProductAttach> attachs = new ArrayList<SupplierProductAttach>();

			/**
			 * 设置商品资质
			 */
			List<String> BuyAttrValUrl = new ArrayList<String>();

			for (int x = 0; x < imgUrl.length; x++) {

				String[] prodImg = imgUrl[x].split("_");
				StringBuffer sb = new StringBuffer();

				for (int i = 1; i < prodImg.length; i++) {

					if (i > 1) {
						sb.append("_");
					}

					sb.append(prodImg[i]);

				}

				if ("00".equals(prodImg[0])) {

					SupplierProductAttach prodQualification = new SupplierProductAttach();
					String qualification = sb.toString();
					qualification = qualification.substring(qualification
							.indexOf("group"));
					prodQualification.setFileurl(qualification);
					prodQualification.setType(Constants.PRODUCT_QUALIFICATION);
					attachs.add(prodQualification);

				} else {
					BuyAttrValUrl.add(imgUrl[x]);
				}

			}

			List<Integer> buyMap = new ArrayList<Integer>();
			Map<Integer, List<SupplierProductBuyAttrval>> map = new LinkedHashMap<Integer, List<SupplierProductBuyAttrval>>();

			if (null != BuyAttrValUrl && BuyAttrValUrl.size() > 0) {

				for (int x = 0; x < BuyAttrValUrl.size(); x++) {

					String[] split = BuyAttrValUrl.get(x).split("_");
					Integer index = Integer.parseInt(split[0].substring(10, split[0].length()));//buyAttrval1
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
						prodImgurl = prodImgurl.substring(prodImgurl
								.indexOf("group"));
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
						prodImgurl = prodImgurl.substring(prodImgurl
								.indexOf("group"));
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

			/**
			 * 商品基本信息
			 */
			objectVO.getSupplierProductBase().setProductname(pname);
			objectVO.getSupplierProductBaseEn().setProductname(pname);
			objectVO.getSupplierProduct().setProdType((short) 5);

			LOGGER.info("insertSkuInfo!!!");
			/**
			 * sku信息
			 */
			List<SupplierProductSkuDTO> productSkuVOs = new ArrayList<SupplierProductSkuDTO>();
			SupplierProductSaleSetting productSaleSetting = objectVO
					.getSupplierProductSaleSetting();
			List<SupplierProductWholesaleRange> wholesaleRanges = new ArrayList<SupplierProductWholesaleRange>();

			if (!Constants.DOMESTIC_DEALER.equals(getSupplierType())) {
				// 1按梯度家报价 2按sku报价
				if (null != cost && cost == 2) {
					// TODO
					productSaleSetting.setMaxSellerPrice(Common
							.getMax2(productPic));
					productSaleSetting.setMinSellerPrice(Common
							.getMin2(productPic));
					productSaleSetting.setMinWholesaleQty(minNum);

					for (int i = 0; i < buyVal.length; i++) {

						SupplierProductSkuDTO skuVO = new SupplierProductSkuDTO();
						SupplierProductSku productSku = new SupplierProductSku();
						// todo
						String skuCodeNum = "";
						String barCodeImage = "";
						if (null != auto && 1 == auto) {

							skuCodeNum = JBarCodeUtil.getCreateRandom();
							barCodeImage = JBarCodeUtil
									.getBarCodeUrl(skuCodeNum);

							LOGGER.info("系统自动生成验证码：" + skuCodeNum
									+ ";BarCodeUrl：" + barCodeImage);

						} else {

							skuCodeNum = skuCode[i];
							barCodeImage = barCodeImg[i]
									.substring(barCodeImg[i].indexOf("group"));

						}

						productSku.setSkuCode(skuCodeNum);

						productSku.setBarCodeImage(barCodeImage);

						productSku.setCreateDate(new Date());
						productSku.setSaleStatus(Constants.PRODUCT_STATUS_SUCCESS);
						if(buyName != null && buyName.length>0){
							buyName[i] = !"".equals(buyName[i])? buyName[i]:"-";
						}
						if(saleName != null && saleName.length>0){
							saleName[i] = !"".equals(saleName[i])? saleName[i]:"-";
						}
						String saleN2 = "";
	                    if(saleName2 !=null && saleName2.length>0){
	                    	saleN2=saleName2[i];
	                    }
	                    String saleN3 = "";
	                    if(saleName3 !=null && saleName3.length>0){
	                    	saleN3=saleName3[i];
	                    }
	                    String saleN4 = "";
	                    if(saleName4 !=null && saleName4.length>0){
	                    	saleN4=saleName4[i];
	                    }
	                    productSku.setSkuNameCn(buyName[i] + saleName[i] + saleN2 + saleN3 + saleN4);
	                    productSku.setSkuNameEn(buyName[i] + saleName[i] + saleN2 + saleN3 + saleN4);
	
						//商品货号
						if(productCode[i]!=null){	
							productSku.setProductCode(productCode[i]);
						}
						skuVO.setSupplierProductSku(productSku);

						List<SupplierProductSkuAttrval> supplierProductSkuAttrvals = new ArrayList<SupplierProductSkuAttrval>();
						SupplierProductSkuAttrval buyAttrval = new SupplierProductSkuAttrval();

						buyAttrval.setAttrId(Long.parseLong("" + buyIndex));
						buyAttrval.setAttrValId(buyVal[i]);
						buyAttrval.setSupplierid(getCurrentSupplierId());
						buyAttrval.setAttrvalNameCn(buyName[i]);

						supplierProductSkuAttrvals.add(buyAttrval);

						if (saleVal != null && saleVal.length > 0) {
	                    	
	                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
	                        
	                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex));
	                        saleAttrval.setAttrValId(saleVal[i]);
	                        saleAttrval.setSubsupplierid("");
	                        saleAttrval.setAttrvalNameCn(saleName[i]);
	                        
	                        supplierProductSkuAttrvals.add(saleAttrval);
	                    }
	                    if (saleVal2 != null && saleVal2.length > 0) {
	                    	
	                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
	                        
	                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex2));
	                        saleAttrval.setAttrValId(Long.valueOf(String.valueOf(saleVal2[i]).substring(1, String.valueOf(saleVal2[i]).length())));
	                        saleAttrval.setSubsupplierid("");
	                        saleAttrval.setAttrvalNameCn(saleName2[i]);
	                        
	                        supplierProductSkuAttrvals.add(saleAttrval);
	                    }
	                    if (saleVal3 != null && saleVal3.length > 0) {
	                    	
	                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
	                        
	                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex3));
	                        saleAttrval.setAttrValId(Long.valueOf(String.valueOf(saleVal3[i]).substring(1, String.valueOf(saleVal3[i]).length())));
	                        saleAttrval.setSubsupplierid("");
	                        saleAttrval.setAttrvalNameCn(saleName3[i]);
	                        
	                        supplierProductSkuAttrvals.add(saleAttrval);
	                    }
	                    if (saleVal4 != null && saleVal4.length > 0) {
	                    	
	                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
	                        
	                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex4));
	                        saleAttrval.setAttrValId(Long.valueOf(String.valueOf(saleVal4[i]).substring(1, String.valueOf(saleVal4[i]).length())));
	                        saleAttrval.setSubsupplierid("");
	                        saleAttrval.setAttrvalNameCn(saleName4[i]);
	                        
	                        supplierProductSkuAttrvals.add(saleAttrval);
	                    }

						skuVO.setSupplierProductSkuAttrvals(supplierProductSkuAttrvals);
						SupplierProductPrice price = new SupplierProductPrice();
						price.setSupplierprice(productPic[i]);
						skuVO.setSupplierProductPriceMap(price);
						productSkuVOs.add(skuVO);
					}
				}

				// 按照图梯度家设置价格
				if (null != cost && cost == 1) {

					productSaleSetting.setMaxSellerPrice(Common.getMax2(pic));
					productSaleSetting.setMinSellerPrice(Common.getMin2(pic));
					productSaleSetting.setMinWholesaleQty(start[0]);

					for (int i = 0; i < buyVal.length; i++) {

						SupplierProductSkuDTO skuVO = new SupplierProductSkuDTO();
						SupplierProductSku productSku = new SupplierProductSku();

						// todo
						String skuCodeNum = "";
						String barCodeImage = "";

						if (null != auto && 1 == auto) {

							skuCodeNum = JBarCodeUtil.getCreateRandom();
							barCodeImage = JBarCodeUtil
									.getBarCodeUrl(skuCodeNum);

							LOGGER.info("系统自动生成验证码：" + skuCodeNum
									+ ";BarCodeUrl：" + barCodeImage);

						} else {

							skuCodeNum = skuCode[i];
							barCodeImage = barCodeImg[i]
									.substring(barCodeImg[i].indexOf("group"));

						}

						productSku.setSkuCode(skuCodeNum);
						productSku.setBarCodeImage(barCodeImage);

						productSku.setCreateDate(new Date());
						productSku
								.setSaleStatus(Constants.PRODUCT_STATUS_SUCCESS);
						productSku.setIstate(Constants.PRODUCT_STATUS_SUCCESS);
						if(buyName != null && buyName.length>0){
							buyName[i] = !"".equals(buyName[i])? buyName[i]:"-";
						}
						if(saleName != null && saleName.length>0){
							saleName[i] = !"".equals(saleName[i])? saleName[i]:"-";
						}
						String saleN2 = "";
	                    if(saleName2 !=null && saleName2.length>0){
	                    	saleN2=saleName2[i];
	                    }
	                    String saleN3 = "";
	                    if(saleName3 !=null && saleName3.length>0){
	                    	saleN3=saleName3[i];
	                    }
	                    String saleN4 = "";
	                    if(saleName4 !=null && saleName4.length>0){
	                    	saleN4=saleName4[i];
	                    }
	                    productSku.setSkuNameCn(buyName[i] + saleName[i] + saleN2 + saleN3 + saleN4);
	                    productSku.setSkuNameEn(buyName[i] + saleName[i] + saleN2 + saleN3 + saleN4);
	                    //商品货号
						if(productCode[i]!=null){	
							productSku.setProductCode(productCode[i]);
						}
						skuVO.setSupplierProductSku(productSku);

						List<SupplierProductSkuAttrval> supplierProductSkuAttrvals = new ArrayList<SupplierProductSkuAttrval>();

						SupplierProductSkuAttrval buyAttrval = new SupplierProductSkuAttrval();
						buyAttrval.setAttrId(Long.parseLong("" + buyIndex));
						buyAttrval.setAttrValId(buyVal[i]);
						buyAttrval.setSupplierid(getCurrentSupplierId());
						buyAttrval.setAttrvalNameCn(buyName[i]);
						supplierProductSkuAttrvals.add(buyAttrval);

						if (saleVal != null && saleVal.length > 0) {
	                    	
	                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
	                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex));
	                        saleAttrval.setAttrValId(saleVal[i]);
	                        saleAttrval.setSubsupplierid("");
	                        saleAttrval.setAttrvalNameCn(saleName[i]);
	                        supplierProductSkuAttrvals.add(saleAttrval);
	                    }
	                    if (saleVal2 != null && saleVal2.length > 0) {
	                    	
	                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
	                        
	                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex2));
	                        saleAttrval.setAttrValId(Long.valueOf(String.valueOf(saleVal2[i]).substring(1, String.valueOf(saleVal2[i]).length())));
	                        saleAttrval.setSubsupplierid("");
	                        saleAttrval.setAttrvalNameCn(saleName2[i]);
	                        
	                        supplierProductSkuAttrvals.add(saleAttrval);
	                    }
	                    if (saleVal3 != null && saleVal3.length > 0) {
	                    	
	                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
	                        
	                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex3));
	                        saleAttrval.setAttrValId(Long.valueOf(String.valueOf(saleVal3[i]).substring(1, String.valueOf(saleVal3[i]).length())));
	                        saleAttrval.setSubsupplierid("");
	                        saleAttrval.setAttrvalNameCn(saleName3[i]);
	                        
	                        supplierProductSkuAttrvals.add(saleAttrval);
	                    }
	                    if (saleVal4 != null && saleVal4.length > 0) {
	                    	
	                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
	                        
	                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex4));
	                        saleAttrval.setAttrValId(Long.valueOf(String.valueOf(saleVal4[i]).substring(1, String.valueOf(saleVal4[i]).length())));
	                        saleAttrval.setSubsupplierid("");
	                        saleAttrval.setAttrvalNameCn(saleName4[i]);
	                        
	                        supplierProductSkuAttrvals.add(saleAttrval);
	                    }

						skuVO.setSupplierProductSkuAttrvals(supplierProductSkuAttrvals);
						SupplierProductPrice price = new SupplierProductPrice();
						price.setSupplierprice(Common.getMax2(pic));
						skuVO.setSupplierProductPriceMap(price);
						productSkuVOs.add(skuVO);
					}

					// 设置梯度价格
					for (int i = 0; i < pic.length; i++) {

						SupplierProductWholesaleRange range = new SupplierProductWholesaleRange();
						range.setStartQty(start[i]);
						Long endQty = 0L;

						if (i + 1 < pic.length) {

							endQty = start[i + 1] - 1;
						}

						if (i == pic.length - 1) {

							endQty = 0L;
						}

						range.setEndQty(endQty);
						range.setDiscountType("0");
						range.setDiscount(pic[i]);
						wholesaleRanges.add(range);
					}

				}
			}

			// TODO 国内经销商不设置价格信息
			if (Constants.DOMESTIC_DEALER.equals(getSupplierType())) {

				objectVO.getSupplierProduct().setProdType(
						Constants.PRODUCT_TYPE);
				objectVO.getSupplierProductDetail().setPriceType(
						Constants.PRODUCT_PRICE_TYPE_DEALER);
				objectVO.getSupplierProductDetail().setOrderType(
						Constants.PRODUCT_STATUS_SUCCESS);

				for (int i = 0; i < buyVal.length; i++) {

					SupplierProductSkuDTO skuVO = new SupplierProductSkuDTO();
					SupplierProductSku productSku = new SupplierProductSku();

					// todo
					String skuCodeNum = "";
					String barCodeImage = "";

					if (null != auto && 1 == auto) {

						skuCodeNum = JBarCodeUtil.getCreateRandom();
						barCodeImage = JBarCodeUtil.getBarCodeUrl(skuCodeNum);

						LOGGER.info("系统自动生成验证码：" + skuCodeNum + ";BarCodeUrl："
								+ barCodeImage);

					} else {
						skuCodeNum = skuCode[i];
						barCodeImage = barCodeImg[i].substring(barCodeImg[i]
								.indexOf("group"));
					}

					productSku.setSkuCode(skuCodeNum);
					productSku.setBarCodeImage(barCodeImage);

					productSku.setCreateDate(new Date());
					productSku.setSaleStatus(Constants.PRODUCT_STATUS_SUCCESS);
					productSku.setIstate(Constants.PRODUCT_STATUS_SUCCESS);
					String saleN2 = "";
                    if(saleName2 !=null && saleName2.length>0){
                    	saleN2=saleName2[i];
                    }
                    String saleN3 = "";
                    if(saleName3 !=null && saleName3.length>0){
                    	saleN3=saleName3[i];
                    }
                    String saleN4 = "";
                    if(saleName4 !=null && saleName4.length>0){
                    	saleN4=saleName4[i];
                    }
                    if(buyName != null && buyName.length>0){
						buyName[i] = !"".equals(buyName[i])? buyName[i]:"-";
					}
					if(saleName != null && saleName.length>0){
						saleName[i] = !"".equals(saleName[i])? saleName[i]:"-";
					}
					productSku.setSkuNameCn(buyName[i] + saleName[i] + saleN2 + saleN3 + saleN4);
                    productSku.setSkuNameEn(buyName[i] + saleName[i] + saleN2 + saleN3 + saleN4);
                    //商品货号
					if(productCode[i]!=null){	
						productSku.setProductCode(productCode[i]);
					}
					skuVO.setSupplierProductSku(productSku);

					List<SupplierProductSkuAttrval> supplierProductSkuAttrvals = new ArrayList<SupplierProductSkuAttrval>();

					SupplierProductSkuAttrval buyAttrval = new SupplierProductSkuAttrval();
					buyAttrval.setAttrId(Long.parseLong("" + buyIndex));
					buyAttrval.setAttrValId(buyVal[i]);
					buyAttrval.setSupplierid(getCurrentSupplierId());
					buyAttrval.setAttrvalNameCn(buyName[i]);
					supplierProductSkuAttrvals.add(buyAttrval);

					if (saleVal != null && saleVal.length > 0) {
                    	
                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex));
                        saleAttrval.setAttrValId(saleVal[i]);
                        saleAttrval.setSubsupplierid("");
                        saleAttrval.setAttrvalNameCn(saleName[i]);
                        supplierProductSkuAttrvals.add(saleAttrval);
                    }                    
                    if (saleVal2 != null && saleVal2.length > 0) {
                    	
                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex2));
                        saleAttrval.setAttrValId(Long.valueOf(String.valueOf(saleVal2[i]).substring(1, String.valueOf(saleVal2[i]).length())));
                        saleAttrval.setSubsupplierid("");
                        saleAttrval.setAttrvalNameCn(saleName2[i]);
                        supplierProductSkuAttrvals.add(saleAttrval);
                    }
                    if (saleVal3 != null && saleVal3.length > 0) {
                    	
                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex3));
                        saleAttrval.setAttrValId(Long.valueOf(String.valueOf(saleVal3[i]).substring(1, String.valueOf(saleVal3[i]).length())));
                        saleAttrval.setSubsupplierid("");
                        saleAttrval.setAttrvalNameCn(saleName3[i]);
                        supplierProductSkuAttrvals.add(saleAttrval);
                    }
                    if (saleVal4 != null && saleVal4.length > 0) {
                    	
                        SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
                        saleAttrval.setAttrId(Long.parseLong("" + saleIndex4));
                        saleAttrval.setAttrValId(Long.valueOf(String.valueOf(saleVal4[i]).substring(1, String.valueOf(saleVal4[i]).length())));
                        saleAttrval.setSubsupplierid("");
                        saleAttrval.setAttrvalNameCn(saleName4[i]);
                        supplierProductSkuAttrvals.add(saleAttrval);
                    }

					skuVO.setSupplierProductSkuAttrvals(supplierProductSkuAttrvals);
					SupplierProductPrice price = new SupplierProductPrice();
					skuVO.setSupplierProductPriceMap(price);
					productSkuVOs.add(skuVO);
				}

			}

			// 设置sku图片信息
			for (int x = 0; x < objectVO.getSupplierProductAttrDTOs().size(); x++) {

				if (objectVO.getSupplierProductAttrDTOs().get(x)
						.getSupplierProductAttr().getBuyAttr() == 1) {

					objectVO.getSupplierProductAttrDTOs().get(x).setMap(map);

				}
			}

			objectVO.setSupplierProductSkuDTOs(productSkuVOs);
			objectVO.setSupplierProductSaleSetting(productSaleSetting);

			if (!Constants.DOMESTIC_DEALER.equals(getSupplierType())) {

				objectVO.setSupplierProductWholesaleRanges(wholesaleRanges);
			}

			/**
			 * 商品核心信息
			 */
			objectVO.getSupplierProduct().setAuditReason(
					Constants.PRODUCT_STATUS_SUCCESS);

			objectVO.getSupplierProduct().setSuppliername(
					getSupplier().getName());
			objectVO.getSupplierProduct().setOperator("" + getCurrentUserId());

			if (subBrandId != null && !"".equals(subBrandId)) {

				try {

					Brand firstBrand = RemoteServiceSingleton.getInstance()
							.getCategoryServiceRpc().getBrandByID(brandId);
					SubBrand subBrand = RemoteServiceSingleton.getInstance()
							.getCategoryServiceRpc()
							.getSubBrandByid(subBrandId);
					objectVO.setBrand(firstBrand);
					objectVO.setSubBrand(subBrand);
					objectVO.getSupplierProduct().setBrandId(subBrandId);

					LOGGER.info("设置品牌成功！！！subBrandId=" + subBrandId);

				} catch (Exception e) {

					LOGGER.error("获取品牌失败！！！" + e.getMessage(), e);

					throw new Exception("获取品牌失败！！！" + e.getMessage(), e);
				}

			} else {

				try {

					Brand firstBrand = RemoteServiceSingleton.getInstance()
							.getCategoryServiceRpc().getBrandByID(brandId);
					objectVO.setBrand(firstBrand);
					objectVO.getSupplierProduct().setBrandId(brandId);
					LOGGER.info("设置品牌成功！！！brandId=" + brandId);

				} catch (Exception e) {

					LOGGER.error("获取品牌失败！！！" + e.getMessage(), e);
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
				if(editorValue.indexOf("detail_inner.css")==-1){
	            	String startStr="<link rel=\"stylesheet\" href=\"http://static.3qianwan.com/commons/css/detail_inner.css\" type=\"text/css\"><div class='detail_inner' >";
	            	String endStr="</div>";
	            	editorValue=startStr+editorValue+endStr;
	            }
				byte[] picByte = editorValue.getBytes();
				try {

					ByteArrayInputStream stream = new ByteArrayInputStream(
							picByte);
					fileUrl = UploadFileUtil.uploadFile(stream, null, null);
					LOGGER.info("图文详情上传成功！！！");

				} catch (Exception e) {

					LOGGER.error("图文详情上传失败！！！" + e.getMessage(), e);
					throw new Exception("图文详情上传失败！！！" + e.getMessage(), e);
				}
			}

			attach.setFileurl(fileUrl);
			attach.setType(Constants.PRODUCT_DESCRIPTIONS);
			attachs.add(attach);
			objectVO.setSupplierProductAttachs(attachs);

			SupplierProductDetail productDetail = objectVO
					.getSupplierProductDetail();

			// 设置售后电话
			String servicePhone = null;
			if (!Common.isEmpty(fristPhone)) {
				servicePhone = "39-" + fristPhone + "-" + subPhone;
				productDetail.setSalesCalls(servicePhone);
			}

			if (!Constants.DOMESTIC_DEALER.equals(getSupplierType())
					&& null != priceType) {
				if (0 == priceType) {

					productDetail
							.setPriceType(Constants.PRODUCT_PRICE_TYPE_FOB);
					productDetail.setPortName(fobPort);

				} else if (1 == priceType) {

					productDetail
							.setPriceType(Constants.PRODUCT_PRICE_TYPE_CIF);
					productDetail.setPortName(cifPort);

				} else if (2 == priceType) {

					productDetail
							.setPriceType(Constants.PRODUCT_PRICE_TYPE_EXW);

				} else {
					throw new Exception("价格类型有误！！！");
				}
			}

			// 去除属性值为空的属性
			objectVO.getB2cProductDetail().setB2cProductName(pname);//B2C商品名称
			objectVO.getB2cProductDetail().setB2cDescription(fileUrl);//图文详情
			SupplierProductObjectDTO productObjectVO = CopyBeanUtil.copy(
					objectVO, buyMap);

			// 标识是中文还是英文
			if ("/en".equals(getLanguage()) || "/en" == getLanguage()) {

				productObjectVO.getSupplierProduct().setMnemonicCode("2");

			} else {

				productObjectVO.getSupplierProduct().setMnemonicCode("1");

			}

			productObjectVO.setSupplierid(getCurrentSupplierId());
			productObjectVO.setSubsupplierid("");
//			productObjectVO.getSupplierProductSkuDTOs().get(0).getSupplierProductPriceMap().setUnitPrice(new BigDecimal(111));//TODO临时，前台修改完成后，动态前台获取
//			productObjectVO.getSupplierProductSkuDTOs().get(0).getSupplierProductPriceMap().setDealerprice(new BigDecimal(222));


			// 设置b2c的商品价格
			List<SupplierProductSkuDTO> skuProductList = productObjectVO.getSupplierProductSkuDTOs();
			if(CollectionUtils.isNotEmpty(skuProductList) && (unitPrice.length > 0) && (domesticPrice.length > 0) && (bestoayPrice.length > 0)){
				for(int i=0;i<skuProductList.size();i++){
					skuProductList.get(i).getSupplierProductPriceMap().setUnitPrice(new BigDecimal(unitPrice[i]));
					skuProductList.get(i).getSupplierProductPriceMap().setDomesticPrice(new BigDecimal(domesticPrice[i]));
					skuProductList.get(i).getSupplierProductPriceMap().setBestoayPrice(new BigDecimal(bestoayPrice[i]));
					
					skuProductList.get(i).getSupplierProductPriceMap().setFhed(new BigDecimal(fhed[i]));
				}
			}

			if (null != RemoteServiceSingleton.getInstance()
					.getSupplierProductService()) {
				try {
					// TODO
					LOGGER.info("addProduct...");

					RemoteServiceSingleton.getInstance()
							.getSupplierProductService()
							.saveProductObjectForB2C(productObjectVO);
					LOGGER.info("保存商品成功!!!");

					issavestatuinfo = "1";

				} catch (SupplierProException e) {
					LOGGER.error("保存商品失败！！！supplierId:"
							+ getCurrentSupplierId() + "productName:" + pname
							+ e.getMessage(), e);
					issavestatuinfo = "0";
				}
			}

		} catch (Exception e) {
			LOGGER.error("商品保存出错  msg:" + e.getMessage(), e);
			issavestatuinfo = "0";
		}
		return issavestatuinfo;
	}
	
	
	/**
	 * 设置商品主图.
	 *
	 * @param imgUrl
	 *            imgurl
	 * @return url
	 */
	private String saveProdImgUrl(List<String> imgUrl) {

		String imageUrl = "";
		if (imgUrl != null && imgUrl.size() > 0) {
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
			LOGGER.info("设置主图imgurl:" + imageUrl);
		} else {
			LOGGER.error("设置主图失败！！！imageUrl:" + imageUrl);
		}
		return imageUrl;
	}

	/**
	 * . POP加载商品页面
	 *
	 *            DealerProductSelectConDTO
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/product/onSaleList")
	public String getProductPage(Model model,@RequestParam(required = false) String page,@RequestParam(required = false) String dpro) {
		
		if(dpro==null){
			dpro = "2";
		}
		if(page==null){
			page = "1";
		}
		model.addAttribute("dpro",dpro);
		model.addAttribute("page",page);
		if (Constants.MANUFACTURER_TRADERS.equals(getSupplierType())
				|| Constants.TRADERS.equals(getSupplierType())) {
			List<Supplier> subSuppliers = RemoteServiceSingleton.getInstance()
					.getSupplierManagerService()
					.getSubSuppliersByPid(getCurrentSupplierId());

			model.addAttribute("subSuppliers", subSuppliers);
		}
		Supplier supplier = getSupplier();
		if(supplier.getOrganizationType()!=null && supplier.getOrganizationType()==5){
			
			int productCount = RemoteServiceSingleton.getInstance().getSupplierProductService().productCount(supplier.getSupplierId());
			 HomeNumRecordDto homeNumRecordDto;
			try {
				if(supplier.getUserId()!=null){
					homeNumRecordDto = homeNumRecordService.selectRecordByUserid((supplier.getUserId()).intValue());
					
					Integer jiaTingStatus = homeNumRecordDto.getStatus();
					if(jiaTingStatus==1){
						
						model.addAttribute("noPub", jiaTingStatus);
						System.out.println("---"+jiaTingStatus);
						
					}
					
				}
				int maxSetting = RemoteServiceSingleton.getInstance().getSqwAccountRecordService().getMaxSetting();
				if(productCount>=maxSetting){
					System.out.println("不能发布啦");
					return "/zh/product/productlist2";
				}
			} catch (Exception e) {
				
				e.printStackTrace();
			}
			
		}
		
		return "/zh/product/productlist";

	}
	
	
	
	/**
	 * . POP加载导入商品页面
	 *
	 *            DealerProductSelectConDTO
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/product/getImportPro")
	public String getProductImportPage(Model model) {

		if (Constants.MANUFACTURER_TRADERS.equals(getSupplierType())
				|| Constants.TRADERS.equals(getSupplierType())) {
			List<Supplier> subSuppliers = RemoteServiceSingleton.getInstance()
					.getSupplierManagerService()
					.getSubSuppliersByPid(getCurrentSupplierId());

			model.addAttribute("subSuppliers", subSuppliers);
			model.addAttribute("operator", "-51");
		}

		return "/zh/product/importlist";

	}

	/**
	 * POP条件加载商品列表
	 *
	 * @param cate
	 *            String
	 * @param page
	 *            Integer
	 * @param dealerProductSelectConDTO
	 *            DealerProductSelectConDTO
	 * @return null
	 */
	@RequestMapping(value = "/product/getPOPProductByConditions")
	public String getProductByConditions(Model model, String cate,
			PageBean<DealerProductShowDTO> pageBean,
			DealerProductSelectConDTO dealerProductSelectConDTO,
			String productName, Long subId, Short auditStatus, Integer page,
			String istate,String popshengIsTate, Long productId, String brandId,BigDecimal popProdType) {

		// 审核中列表数据
		if (auditStatus == 2) {
			LOGGER.info("getProductByConditions!!!auditStatus:" + auditStatus
					+ ";supplierId:" + getCurrentSupplierId());

			try {
				PageBean<SupplierProductShowDTO> pageBean2 = new PageBean<SupplierProductShowDTO>();
				SupplierProductSelectConDTO productSelectConVO = new SupplierProductSelectConDTO();
				List<String> list = new ArrayList<String>();
				if (cate != null) {
					list.add(cate);
					productSelectConVO.setCatePubIds(list);
				}

				productSelectConVO.setSupplierId(getCurrentSupplierId());

				if (null != productId && productId != 0) {
					productSelectConVO.setProductId(productId);
				}
				if (null != popProdType ) {
					productSelectConVO.setProdType(popProdType);
				}

				if (null != dealerProductSelectConDTO.getB2cProductName() && !dealerProductSelectConDTO.getB2cProductName().equals("")) {
					productSelectConVO.setProductName(dealerProductSelectConDTO.getB2cProductName());
				}
				
				if (null != dealerProductSelectConDTO.getProductBarCode() && !dealerProductSelectConDTO.getProductBarCode().equals("")) {
					productSelectConVO.setProductBarCode(dealerProductSelectConDTO.getProductBarCode());
				}

				List<Long> supplierIds = new ArrayList<Long>();

				if (null != subId && !"".equals(subId)) {

					supplierIds.add(subId);

				} else {
					supplierIds = getSupplierIds();
				}

				productSelectConVO.setSupplierIds(supplierIds);

				if (null != brandId && !"".equals(brandId)) {

					productSelectConVO.setBrandId(brandId);
				}

				//productSelectConVO.setB2cSupply(51);
				
				productSelectConVO.setCounterfeittypeid(popshengIsTate);

				if (null != page && page != 0) {
					pageBean2.setPage(page);
				} else {
					pageBean2.setPage(1);
				}
				pageBean2.setSortFields("OPERATIONDATE");
				pageBean2.setOrder("DESC");

				PageBean<SupplierProductShowDTO> pageBeanSupplierProduct = new PageBean<SupplierProductShowDTO>();

				productSelectConVO.setAuditStatus(auditStatus);
				
				/**
				 * 如果是导入商品
				 */
//				if(null != operator && !"".equals(operator) && !operator.equals("undefined")){
//					
//					productSelectConVO.setOperator(operator);
//				}
				
				pageBean2.setPageSize(Constants.PAGE_NUM_TEN);

				pageBean2.setParameter(productSelectConVO);

				pageBeanSupplierProduct = RemoteServiceSingleton.getInstance()
						.getSupplierProductService()
						.findProductsByConditionsbyPOP(pageBean2);

				// 设置图片的地址
				List<SupplierProductShowDTO> result = pageBeanSupplierProduct
						.getResult();
				for (SupplierProductShowDTO supplierProductShowVO : result) {
					String imgURL = supplierProductShowVO.getImgURL();
					if (!imgURL.startsWith("http")
							|| !imgURL.startsWith("Http")) {
						imgURL = Constants.FILESERVER1 + imgURL;
						supplierProductShowVO.setImgURL(imgURL);
					}
				}
				model.addAttribute("pb", pageBeanSupplierProduct);
				
				
				
				// return getLanguage() + "/product/modelPage/showProductList";
			} catch (Exception e) {
				logger.error(
						"查询商品失败！！！auditStatus:" + auditStatus + ";supplierId:"
								+ getCurrentSupplierId() + e.getMessage(), e);

				return "1";

			}

		}

		// 审核通过列表数据
		if (auditStatus == 1){
			dealerProductSelectConDTO.setSupplierId(getCurrentSupplierId());
			if(popProdType!=null){
				dealerProductSelectConDTO.setProdType(popProdType.shortValue());
			}
			

			List<Long> supplierIds = new ArrayList<Long>();

			if (null != subId && !"".equals(subId)) {

				supplierIds.add(subId);

			} else {
				supplierIds = getSupplierIds();
			}

			dealerProductSelectConDTO.setSupplierIds(supplierIds);

			try {
				List<String> cateList = new ArrayList<String>();
				if (cate != null) {
					cateList.add(cate);
					dealerProductSelectConDTO.setCateDispIds(cateList);
				}
				pageBean.setPageSize(Constants.PAGESIZE);
				pageBean.setSortFields("CREATEDDATE");
				pageBean.setOrder("DESC");
				dealerProductSelectConDTO.setB2cSupply(51);
				pageBean.setParameter(dealerProductSelectConDTO);

				pageBean = RemoteServiceSingleton.getInstance()
						.getDealerProductService()
						.findProductsByConditionsbyPOP(pageBean);

				List<DealerProductShowDTO> result = pageBean.getResult();
                List<Long> pids = null;
				if (result != null && result.size() > 0) {
					FormatBigDecimal formatBigDecimal = new FormatBigDecimal();
					pids = new ArrayList<Long>();

					for (int i = 0; i < result.size(); i++) {
						String imgUrl = result.get(i).getImgURL();

						pids.add(result.get(i).getProductId());

						if (!imgUrl.startsWith("http")
								|| !imgUrl.startsWith("Http")) {

							if (result.get(i).getIsB2c()) {
								result.get(i)
										.setB2cImage(Constants.M1 + imgUrl);
							}
							result.get(i).setImgURL(Constants.P1 + imgUrl);
						}
						BigDecimal productPriceMin = result.get(i)
								.getProductPriceMin();
						BigDecimal productPriceMax = result.get(i)
								.getProductPriceMax();

						BigDecimal priceMax = formatBigDecimal
								.priceFormat(productPriceMax);
						BigDecimal priceMin = formatBigDecimal
								.priceFormat(productPriceMin);

						result.get(i).setProductPriceMin(priceMin);
						result.get(i).setProductPriceMax(priceMax);

						if (null != result.get(i).getDescription()) {
							result.get(i).setDescription(
									result.get(i).getDescription()
											.replaceAll("\n", "<br/>"));
						}

						if (dealerProductSelectConDTO.getAuditStatus() == Constants.SHORT6) {
							result.get(i).setCounterfeittypeid(
									"" + Constants.NUM6);
							// result.get(i).getSupply();
						}
					}


					// 遍历处理商品名称
					List<B2cProductDetail> b2cdetailList = b2cProductDetailService.findB2cProductByProductIds(pids);
					if(CollectionUtils.isNotEmpty(b2cdetailList)){
						for (DealerProductShowDTO dto:result){

							for (B2cProductDetail detail:b2cdetailList){
								if(dto.getProductId().longValue() == detail.getProductId().longValue()){
									dto.setProductName(detail.getB2cProductName());
									break;
								}
							}
						}
					}

                    if(null != pids && !pids.isEmpty()){
                        // 2017-1-7 by lipeng
                        // 增加一个查询 审核列表 中数据状态的功能,
                        // 用于设置,下架,修改完,之后是待审核状态,不能再上架
                        List<SupplierProduct> supplierProductList = RemoteServiceSingleton
                                .getInstance()
                                .getSupplierProductService().selectProductAuditStatusByIds(pids);

                        for (DealerProductShowDTO dto:result){
                            for (SupplierProduct supplierProduct:supplierProductList){
                                if(dto.getProductId().longValue() == supplierProduct.getProductid().longValue()){
                                    dto.setIsNationalAgency(Short.valueOf(supplierProduct.getCounterfeittypeid()));
                                    break;
                                }
                            }
                        }
                    }


					// 回写商品状态，查询审核中的状态
//					List<Long> auditList = supplierProductAuditService.findAudingtingByPids(pids);
//					if(CollectionUtils.isNotEmpty(auditList)){
//						if(CollectionUtils.isNotEmpty(b2cdetailList)){
//							for (DealerProductShowDTO dto:result){
//
//								for (Long audit:auditList){
//									if(dto.getProductId().longValue() == audit.longValue()){
//										dto.setCounterfeittypeid("0");
//										break;
//									}
//								}
//							}
//						}
//					}
				}

				model.addAttribute("pb2", pageBean);
				model.addAttribute("supplierId", this.getCurrentSupplierId());

			} catch (Exception e) {

				LOGGER.error(e.getMessage(), e);

				return "1";

			}
		}
		Supplier supplier = getSupplier();
		if(supplier.getOrganizationType()!=null && supplier.getOrganizationType()==5){
			model.addAttribute("supplier",supplier.getOrganizationType());
		}
		if(supplier.getOrganizationType()==null){
			model.addAttribute("supplier",1);
		}
		
		
		
		return "/zh/product/modelPage/product_model";

	}
	
	/**.
	 * 下架操作
	 * @param request HttpServletRequest
	 * @param pid String
	 * @return String
	 */
	@RequestMapping(value = "/product/POPupdateProductTateByIds")
	@ResponseBody
	public String updateProductTateByIds(HttpServletRequest request , String pid ,String stopReason,Short stopType){

		String downprostat = Constants.SUCCESS;
		
		DealerPordUpdateTateDto dealerPordUpdateTateDto = new DealerPordUpdateTateDto();
		
		if(pid.length()>0){
			
			LOGGER.info("POP下架操作.商品Id:"+pid);
			LOGGER.info("用户ID:"+getCurrentUser().getSupplierId());

			try{
				
				String[] cates = pid.split(",");
				Long [] catels = new Long[cates.length];
				
				for(int i = 0 ; i < cates.length ; i++ ){
					
					catels[i] = Long.parseLong(cates[i]);
					
				}
				
				dealerPordUpdateTateDto.setProductIds(catels);
				dealerPordUpdateTateDto.setOperatorId(getCurrentUser().getSupplierId());
				dealerPordUpdateTateDto.setStatus(Constants.SHORT0);
				dealerPordUpdateTateDto.setStopReason(stopReason);
				dealerPordUpdateTateDto.setType(stopType);
				
				RemoteServiceSingleton.getInstance().getDealerProductService().updateProductTateByIds(dealerPordUpdateTateDto);		
				
			}catch (Exception e) {
				
				LOGGER.error(e.getMessage(),e);
				
				downprostat = Constants.ERROR;
				
			}
			
		}else{
			
			downprostat = Constants.ERROR;
			
		}
		
		return downprostat;
		
	}
	
	/**.
	 * 上架操作
	 * AJAX
	 * @param request HttpServletRequest
	 * @param pid String
	 * @return String
	 */
	@RequestMapping(value = "/product/POPupProductByIds")
	@ResponseBody
	public String hitsShelvesProductByIds(HttpServletRequest request,String pid,Short upType){

		String updata = Constants.SUCCESS;
		
		if(pid.length()>0){

			LOGGER.info("POP上架操作.商品Id:"+pid);

			try{

				DealerPordUpdateTateDto dealerPordUpdateTateDto = new DealerPordUpdateTateDto();

				String[] cates = pid.split(",");
				Long [] catels = new Long[cates.length];
				
				for(int i = 0 ; i < cates.length ; i++ ){
					
					catels[i] = Long.parseLong(cates[i]);
					
				}

				dealerPordUpdateTateDto.setProductIds(catels);
				dealerPordUpdateTateDto.setOperatorId(getCurrentUser().getSupplierId());
				dealerPordUpdateTateDto.setStatus(Constants.SHORT1);
				dealerPordUpdateTateDto.setType(upType);
				
				RemoteServiceSingleton.getInstance().
									getDealerProductService().updateProductTateByIds(dealerPordUpdateTateDto);		
				
			}catch (Exception e) {
				
				LOGGER.error(e.getMessage(),e);
				
				updata = Constants.ERROR;
				
			}
			
		}else{
			
			updata = Constants.ERROR;
			
		}
		
		return updata;
		
	}
	
	
	@RequestMapping(value = "/product/POPdownProductExcel")
    public void POPdownProduct(HttpServletResponse response, String cate,PageBean<DealerProductTabExportDTO> pageBean,DealerProductSelectConDTO dealerProductSelectConDTO) {
	    if(StringUtils.isNotBlank(cate)){
    	    List<String> cateDispIds = new ArrayList<String>();
    	    cateDispIds.add(cate);
            dealerProductSelectConDTO.setCateDispIds(cateDispIds);
	    }
	    
	    //商品列表，查询wofe库
	    if(dealerProductSelectConDTO.getAuditStatus() == 1){
	    
	    	List<Long> supplierIds = new ArrayList<Long>();
			supplierIds = getSupplierIds();
			dealerProductSelectConDTO.setSupplierIds(supplierIds);
		    dealerProductSelectConDTO.setB2cSupply(51);
		    pageBean.setPageSize(999999);
		    pageBean.setParameter(dealerProductSelectConDTO);
		    pageBean = RemoteServiceSingleton.getInstance().getDealerProductExportExcelService().findB2CProTabListbyPOP(pageBean);
		    
		    
		    if (null != pageBean && null != pageBean.getResult()) {
		        try {
	                OutputStream os = null;
	                List<DealerProductTabExportDTO> list = pageBean.getResult();
	                HSSFWorkbook workbook = new HSSFWorkbook();// 声明一个工作薄
	                HSSFSheet sheet = workbook.createSheet("productList");// 生成一个表格
	                HSSFRow row = sheet.createRow(0);
	                
	                HSSFCellStyle style = workbook.createCellStyle();
	                style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
	                style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
	                style.setFillForegroundColor(HSSFColor.YELLOW.index);
	                HSSFCell cell = null;
	                String strtitle ;
	                strtitle =  "发布日期,商品品类,商品编码,商品ID,商品名称,规格名称,条形码,零售价(￥),原产国,制造商,供应商,保质期";
	                FormatBigDecimal formatBigDecimal = new FormatBigDecimal();
	                sheet.setDefaultColumnWidth(20);
	                String[] split = strtitle.split(",");
	                for (int i = 0; i < split.length; i++) {
	                    cell = row.createCell(i);
	                    cell.setCellValue(split[i]);
	                    cell.setCellStyle(style);
	                }
	                for (int i = 0; i < list.size(); i++) {
	                    HSSFCellStyle styleRow = null;
	                    if (i % 2 == 0) {
	                        styleRow = workbook.createCellStyle();
	                        styleRow.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
	                        styleRow.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
	                        styleRow.setFillForegroundColor(HSSFColor.LIGHT_TURQUOISE.index);
	                    } else {
	                        styleRow = workbook.createCellStyle();
	                        styleRow.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
	                        styleRow.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
	                        styleRow.setFillForegroundColor(HSSFColor.WHITE.index);
	                    }
	                    int lastRowIndex = sheet.getLastRowNum();
	                    DealerProductTabExportDTO exportDTO = list.get(i);
	                    List<SKUAuditExportDTO> skuList = exportDTO.getSkuList();
	                    if (skuList != null && skuList.size() > 0) {
	                        int skuLength = skuList.size();
	                        for (int j = 0; j < skuLength; j++) {
	                            short cellNum = Constants.SHORT0;
	                            SKUAuditExportDTO skuDto = skuList.get(j);
	                            row = sheet.createRow(j + lastRowIndex + 1);
	                            this.geneCell(row, cellNum++,exportDTO.getStrCreatedate(), styleRow);
	                            this.geneCell(row, cellNum++,exportDTO.getCatePubName(), styleRow);
	                            this.geneCell(row, cellNum++,exportDTO.getBusinessProdId(), styleRow);
	                            this.geneCell(row, cellNum++,exportDTO.getProductId().toString(), styleRow);
	                            this.geneCell(row, cellNum++,exportDTO.getProductName(), styleRow);
	                            this.geneCell(row, cellNum++,skuDto.getSkuNameCN(), styleRow);
	                            this.geneCell(row, cellNum++,skuDto.getSkuCode(), styleRow);
//	                            this.geneCell(row, cellNum++,skuDto.getsPrice(), styleRow);
	                            
	                            BigDecimal productPrice = new BigDecimal(skuDto.getdPrice());
	    						BigDecimal productRetailPrice = skuDto.getRetailPrice();

	    						BigDecimal productPriceB = formatBigDecimal
	    								.priceFormat(productPrice);
	    						BigDecimal productRetailPriceB = formatBigDecimal
	    								.priceFormat(productRetailPrice);

//	                            this.geneCell(row, cellNum++,productPriceB.toString(), styleRow);
	                            this.geneCell(row, cellNum++,productRetailPriceB.toString(), styleRow);
	                            
	                            this.geneCell(row, cellNum++,exportDTO.getOriginplaceName(), styleRow);
	                            this.geneCell(row, cellNum++,exportDTO.getManufacturers(), styleRow);
	                            this.geneCell(row, cellNum++,exportDTO.getSupplierName(), styleRow);
	                            this.geneCell(row, cellNum++, this.toSheillife(exportDTO),styleRow);
	                            cellNum = Constants.SHORT0;
	                        }
	                    } else {
	                        short cellNum = Constants.SHORT0;
	                        row = sheet.createRow(lastRowIndex + 1);
	                        this.geneCell(row, cellNum++,exportDTO.getStrCreatedate(), styleRow);
	                        this.geneCell(row, cellNum++,exportDTO.getCatePubName(), styleRow);
	                        this.geneCell(row, cellNum++,exportDTO.getBusinessProdId(), styleRow);
	                        this.geneCell(row, cellNum++, exportDTO.getProductId().toString(), styleRow);
	                        this.geneCell(row, cellNum++,exportDTO.getProductName(), styleRow);
	                        this.geneCell(row, cellNum++, "没规格", styleRow);
	                        this.geneCell(row, cellNum++, "没规格", styleRow);
	                        
	                        this.geneCell(row, cellNum++, "没规格", styleRow);
	                        this.geneCell(row, cellNum++, "没规格", styleRow);
	                        this.geneCell(row, cellNum++, "没规格", styleRow);
	                       
	                        this.geneCell(row, cellNum++,exportDTO.getOriginplaceName(), styleRow);
	                        this.geneCell(row, cellNum++,exportDTO.getManufacturers(), styleRow);
	                        this.geneCell(row, cellNum++,exportDTO.getSupplierName(), styleRow);
	                        this.geneCell(row, cellNum++, this.toSheillife(exportDTO),styleRow);
	                    }
	                }
	                
	                LOGGER.info("拼装商品信息完成!");
	                String filename = "productList";
	                os = response.getOutputStream();
	                response.reset();
	                response.setCharacterEncoding("UTF-8");
	                filename = java.net.URLEncoder.encode(filename, "UTF-8");
	                response.setHeader("Content-Disposition","attachment;filename="+ new String(filename.getBytes("UTF-8"), "GBK")+ ".xls");
	                response.setContentType("application/msexcel");// 定义输出类型
	                workbook.write(os);
	                response.getOutputStream().flush();
	                response.getOutputStream().close();
	            } catch (Exception e) {
	                LOGGER.error("导出B2B商品错误" + e.getMessage(), e);
	            }
		    }
	    }
	}
	
	/**
	 * downExcel Help
	 * 
	 * @param row
	 * @param cellNum
	 * @param strCreatedate
	 * @param style
	 */
	@SuppressWarnings("deprecation")
	private void geneCell(HSSFRow row, Short cellNum, String strCreatedate,
			HSSFCellStyle style) {
		HSSFCell cell = row.createCell(cellNum);
		cell.setCellValue(strCreatedate);
		cell.setCellStyle(style);
	}
	
	private String toSheillife(DealerProductTabExportDTO exportDTO){ 
	    String strShelLife = "";
        
        if (exportDTO.getSheilLife() != null&& exportDTO.getSheilLife() != 0) {
            strShelLife = exportDTO.getSheilLife().toString();
            switch (exportDTO.getSheilLifeType()) {
            case com.mall.dealer.product.util.Constants.SHEILLIFE_DAY:
                strShelLife += " 天";
                break;
            case com.mall.dealer.product.util.Constants.SHEILLIFE_MON:
                strShelLife += " 月";
                break;
            case com.mall.dealer.product.util.Constants.SHEILLIFE_YEAR:
                strShelLife += " 年";
                break;
            default:
                break;
            }
        } else {
            strShelLife = "无保质期";
        }
	    return strShelLife;
	}

	/**
	 * . 图片上传
	 *
	 * @param request
	 *            HttpServletRequest
	 * @param response
	 *            HttpServletResponse
	 */
	@RequestMapping("/product/imageUp")
	public void uploadImages(HttpServletRequest request,
			HttpServletResponse response, String productId) {

		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		// 获取file框的
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

		// 遍历获取的所有文件
		List<String> picUrlS = null;
		String sid = getSessionId();

		productId = (null == productId ? Constants.IMAGES : productId);

		try {

			picUrlS = memcachedClient.get(sid + productId);

		} catch (Exception e) {

			LOGGER.error("获取缓存图片列表失败！" + e.getMessage(), e);
		}

		if (null == picUrlS) {

			picUrlS = new ArrayList<String>();

		}

		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {

			try {

				MultipartFile mf = entity.getValue();
				// 判断文件名是否为空。为空set null值
				String myfileUrl = UploadFileUtil.uploadFile(
						mf.getInputStream(),
						Common.getFileExt2(mf.getOriginalFilename()), null);

				String newUrl = Constants.IMAGES_VIEW1 + myfileUrl;
				picUrlS.add(Constants.IMAGES_VIEW1 + myfileUrl);

				if (null != myfileUrl) {

					LOGGER.info("图片上传成功ImageUrl：" + newUrl + ";SupplierId:"
							+ getCurrentSupplierId());
					response.getWriter().write(
							"{\"success\":\"true\","
									+ "\"data\":{\"BaseUrl\":\"" + myfileUrl
									+ "\",\"Url\":\"" + newUrl
									+ "\",\"filename\":\""
									+ mf.getOriginalFilename() + "\"}}");

				} else {

					LOGGER.error("图片服务器上传图片失败！！！supplierId："
							+ getCurrentSupplierId());
					response.getWriter()
							.write("{\"success\":\"flase\","
									+ "\"data\":{\"BaseUrl\":\"\",\"Url\":\"\",\"filename\":\""
									+ mf.getOriginalFilename() + "\"}}");

				}
			} catch (Exception e) {

				try {

					response.getWriter().write(
							"{\"success\":\"false\","
									+ "\"data\":{\"BaseUrl\":\"" + ""
									+ "\",\"Url\":\"" + ""
									+ "\",\"filename\":\"" + "" + "\"}}");

				} catch (IOException e1) {

					LOGGER.error("展示属性图片上传失败！！！" + e1.getMessage(), e1);
				}

				LOGGER.error("展示属性图片上传失败！！！" + e.getMessage(), e);
			}
		}

		try {

			if (null == memcachedClient.get(sid + productId)) {

				memcachedClient.set(sid + productId, Constants.OUT_TIME_3600,
						picUrlS);

			} else {

				memcachedClient.replace(sid + productId,
						Constants.OUT_TIME_3600, picUrlS);

			}

		} catch (Exception e) {

			LOGGER.error("获取缓存图片列表失败！" + e.getMessage(), e);
		}
	}

	/**
	 * 富文本编辑器上传图片.
	 *
	 * @param request
	 *            HttpServletRequest
	 * @param response
	 *            HttpServletResponse
	 */
	@SuppressWarnings("deprecation")
	@RequestMapping("/js/ueditor/jsp/imageUp")
	public void uploadImg(HttpServletRequest request,
			HttpServletResponse response, String action) {

		if (action.equals("uploadimage")) {

			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			// 获取file框的
			Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

			// 遍历获取的所有文件
			List<String> picUrlS = new ArrayList<String>();

			for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {

				try {

					MultipartFile mf = entity.getValue();

					//如果图片大于100k
					/*if(mf.getSize() > 102400){
						
						response.getWriter().print(
								"{\"state\": \"The picture size beyond 100K!\"}");
						LOGGER.error("富文本编辑器上传图片失败！！！图片超出100K。");
						return;
					}*/
					// 判断文件名是否为空。为空set null值
					String myfileUrl = UploadFileUtil.uploadFile(
							mf.getInputStream(),
							Common.getFileExt2(mf.getOriginalFilename()), null);

					if (null != myfileUrl) {

						String newUrl = Constants.IMAGES_VIEW2 + myfileUrl;
						picUrlS.add(Constants.IMAGES_VIEW2 + myfileUrl);
						// {"state": "SUCCESS","title":
						// "ueditor.png","original": "img06.png","type":
						// ".png","url": "/ueditor.png","size": "1856031"}
						// {'state': 'SUCCESS','title':
						// '','original':'psb.jpg','type':
						// '.jpg','url':'Http://image01.3qianwan.com/h0/group1/M00/02/BB/wKgBO1RQVgSAAe_tAACscwmJG88194.jpg','size':
						// '44147'}
						String status = "{\"state\": \"SUCCESS\",\"title\": \"\",\"original\":\""
								+ mf.getOriginalFilename()
								+ "\",\"type\": \""
								+ Common.getFileExt(myfileUrl)
								+ "\",\"url\":\""
								+ newUrl
								+ "\",\"size\": \""
								+ mf.getSize() + "\"}";
						response.getWriter().print(status);

						LOGGER.info("uedtior上传图片，图片图片服务器返回 ：" + myfileUrl
								+ ";原始文件名：" + mf.getOriginalFilename()
								+ ";supplierId:" + getCurrentSupplierId());

					} else {

						response.getWriter().print(
								"{\"state\": \"Server is Error!\"}");

					}

				} catch (Exception e) {

					try {

						response.getWriter().print(
								"{\"state\": \"Server is Error!\"}");

					} catch (IOException e1) {
						LOGGER.error("富文本编辑器上传图片失败！！！" + e.getMessage(), e);
					}

					LOGGER.error("富文本编辑器上传图片失败！！！" + e.getMessage(), e);
				}
			}

		} else if (action.equals("catchimage")) {

			String[] source = request.getParameterValues("linkUp[]");

			StringBuffer status = new StringBuffer();

			status.append("{\"state\": \"SUCCESS\", list: [");

			for (int i = 0; i < source.length; i++) {

				try {

					URL url = new URL(source[i]);
					HttpURLConnection uc = (HttpURLConnection) url
							.openConnection();
					uc.setDoInput(true);// 设置是否要从 URL 连接读取数据,默认为true
					uc.connect();
					// 判断文件名是否为空。为空set null值
					String myfileUrl = UploadFileUtil.uploadFile(
							uc.getInputStream(), Common.getFileExt2(source[i]),
							null);
					String newUrl = Constants.IMAGES_VIEW2 + myfileUrl;

					if (i == source.length - 1) {

						status.append("{\"state\": \"SUCCESS\",\"title\": \"\",\"source\":\""
								+ source[i]
								+ "\",\"type\": \""
								+ Common.getFileExt(myfileUrl)
								+ "\",\"url\":\""
								+ newUrl
								+ "\",\"size\": \""
								+ uc.getContentLength() + "\"}]}");

					} else {

						status.append("{\"state\": \"SUCCESS\",\"title\": \"\",\"source\":\""
								+ source[i]
								+ "\",\"type\": \""
								+ Common.getFileExt(myfileUrl)
								+ "\",\"url\":\""
								+ newUrl
								+ "\",\"size\": \""
								+ uc.getContentLength() + "\"},");

					}

				} catch (Exception e) {

					LOGGER.error("文件上传失败！" + e.getMessage(), e);
				}
			}
			try {

				response.getWriter().print(status);

			} catch (IOException e) {
				LOGGER.error("输出失败！" + e.getMessage(), e);
			}
		} else if (action.equals("listimage")) {

			String productId = request.getParameter("productId");

			Integer start = Integer.parseInt(request.getParameter("start"));
			Integer size = Integer.parseInt(request.getParameter("size"));

			List<String> source = null;

			productId = (null == productId ? Constants.IMAGES : productId);

			try {
				source = memcachedClient.get(getSessionId() + productId);

			} catch (Exception e) {

				LOGGER.error("获取缓存图片列表失败！" + e.getMessage(), e);
			}
			if (null == source) {

				source = new ArrayList<String>();
			}

			StringBuilder status = new StringBuilder();

			status.append("{\"state\": \"SUCCESS\", list: [");

			List<String> findAllProdUrlByProductId = RemoteServiceSingleton
					.getInstance().getSupplierProductService()
					.findAllProdUrlByProductId(Long.valueOf(productId), "");
			logger.info("获取商品图片");

			List<String> allList = new ArrayList<String>();

			if (null != findAllProdUrlByProductId) {

				for (String productid : findAllProdUrlByProductId) {
					allList.add(Constants.IMAGES_VIEW2 + productid);
				}

				source.addAll(allList);
			}

			if (source.size() > start) {

				for (int i = start; i < source.size(); i++) {

					if (i == start + size) {

						status.append("{\"url\":\"" + source.get(i)
								+ "\",\"mtime\": \""
								+ System.currentTimeMillis() + "\"}");
						break;
					}

					if (i == source.size() - 1) {

						status.append("{\"url\":\"" + source.get(i)
								+ "\",\"mtime\": \""
								+ System.currentTimeMillis() + "\"}");

					} else {

						status.append("{\"url\":\"" + source.get(i)
								+ "\",\"mtime\": \""
								+ System.currentTimeMillis() + "\"},");
					}
				}
			}

			status.append("]}");

			try {

				response.getWriter().print(status);

			} catch (IOException e) {
				LOGGER.error("输出失败！" + e.getMessage(), e);
			}

		} else if (action.equals("config")) {

			try {

				request.setCharacterEncoding("utf-8");
				response.setHeader("Content-Type", "text/html");
				String rootPath = request.getRealPath("/");
				String re = new ActionEnter(request, rootPath).exec();
				response.getWriter().write(re);

			} catch (IOException e) {

				LOGGER.error("富文本编辑器！！！" + e.getMessage(), e);
			}
		}

	}
	
	@RequestMapping(value = "/product/toImport")
	public String getToImport(Model model,HttpServletRequest request) {

		if (Constants.MANUFACTURER_TRADERS.equals(getSupplierType())
				|| Constants.TRADERS.equals(getSupplierType())) {
			List<Supplier> subSuppliers = RemoteServiceSingleton.getInstance()
					.getSupplierManagerService()
					.getSubSuppliersByPid(getCurrentSupplierId());

			model.addAttribute("subSuppliers", subSuppliers);
		}
		
		request.setAttribute("message",request.getParameter("message"));

		return "/zh/product/toImport";
	}
	
	/**
	 * 查询采购价格
	 * @param model
	 * @param pageBean
	 * @return
	 */
	@RequestMapping(value = "/product/getPurchasePriceByConditions")
	public String getPurchasePriceByConditions(Model model,HttpServletRequest request,
			PageBean<PurchasePriceDto> pageBean,PurchasePriceDto purchasePriceDto,Integer page) {
		
		    request.setAttribute("message",request.getParameter("message"));

			purchasePriceDto.setSupplierId(getCurrentSupplierId()+"");

			try {
				
				if (null != page && page != 0) {
					pageBean.setPage(page);
				} else {
					pageBean.setPage(1);
				}
				
				pageBean.setPageSize(Constants.PAGE_NUM_TEN);
//				pageBean.setSortFields("BEGIN_TIME");
//				pageBean.setSortFields("PRODUCT_NAME");
//				pageBean.setOrder("DESC");
				pageBean.setParameter(purchasePriceDto);

				pageBean = RemoteServiceSingleton.getInstance()
						.getDealerProductSkuService().findPurchasePriceByPageBean(pageBean);
//				List<PurchasePriceDto> result = pageBean.getResult();

				model.addAttribute("pb", pageBean);
				model.addAttribute("supplierId", this.getCurrentSupplierId());

			} catch (Exception e) {

				LOGGER.error(e.getMessage(), e);

				return "1";

			}
		return "/zh/product/modelPage/purchaseList";

	}
	
	/**
	 * 获取采购价格表格数据
	 * @param file
	 * @return
	 */
	@RequestMapping(value = "/product/settingPurchasePriceExcel")
	public String settingPurchasePriceExcel(@RequestParam(value = "file", required = true) MultipartFile file, HttpServletRequest request, Model model){

		 String fileName = file.getOriginalFilename();
		 
		if(StringUtils.isBlank(fileName) || !(fileName.endsWith("xls") || fileName.endsWith("xlsx"))){
            ThirdPartyMessage m = new ThirdPartyMessage("fail","","导入失败,文件格式不正确");
            model.addAttribute("message", JSONArray.fromObject(m).toString());
            return "redirect:/product/toImport";
        }
		
		try {
				Workbook wb = null;
				if (fileName.endsWith("xls") ) {
					wb = new HSSFWorkbook(new BufferedInputStream(file.getInputStream()));
				} else if(fileName.endsWith("xlsx") ){
					wb = new XSSFWorkbook(new BufferedInputStream(file.getInputStream()));
				} else{
	                ThirdPartyMessage m = new ThirdPartyMessage("fail","","导入失败,文件不能解析");
	                model.addAttribute("message", JSONArray.fromObject(m).toString());
	                return "redirect:/product/toImport";
				}
			  Sheet sheet = wb.getSheetAt(0); // 创建对工作表的引用
              
              
              int rows = sheet.getPhysicalNumberOfRows();//获取表格的
              for (int r = 1; r < rows; r++) {                //循环遍历表格的行
                  String value = "";
                  Row row = sheet.getRow(r);         //获取单元格中指定的行对象
                  if (row != null) {
                	  
                	  PurchasePriceDto dto = new PurchasePriceDto();
                	  
                      int cells = row.getPhysicalNumberOfCells();//获取单元格中指定列对象
                      for (short c = 0; c < cells; c++) {      //循环遍历单元格中的列                  
                          Cell cell = row.getCell((short) c); //获取指定单元格中的列                      
                          if (cell != null) {
                              if (cell.getCellType() == HSSFCell.CELL_TYPE_STRING) {  //判断单元格的值是否为字符串类型
                            	  
                            	  if(c == 0){
                            		  dto.setSupplierId(cell.getStringCellValue().trim());
                            	  }
                            	  
                            	  if(c == 1){
                            		  dto.setSupplierName(cell.getStringCellValue().trim());
                            	  }
                            	  
                            	  if(c == 2){
                            		  dto.setSkuId(cell.getStringCellValue().trim());
                            	  }
                            	  
                            	  if(c == 3){
                            		  dto.setPurchasePrice(cell.getStringCellValue().trim());
                            	  }
                            	  
                            	  if(c == 4){
                            		  dto.setBeginTime(new Date(cell.getStringCellValue().trim()));
                            	  }
                                 // value += cell.getStringCellValue() + ",";
                              } else if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {  //判断单元格的值是否为数字类型            

                            	  if(c == 0){
                            		  dto.setSupplierId(cell.getNumericCellValue()+"");
                            	  }
                            	  
                            	  if(c == 1){
                            		  dto.setSupplierName(cell.getNumericCellValue()+"");
                            	  }
                            	  
                            	  if(c == 2){
                            		  dto.setSkuId(cell.getNumericCellValue()+"");
                            	  }
                            	  
                            	  if(c == 3){
                            		  dto.setPurchasePrice(cell.getNumericCellValue()+"");
                            	  }
                            	  
                            	  if(c == 4){
                            		  if(HSSFDateUtil.isCellDateFormatted(cell)) {
                            	         double d=cell.getNumericCellValue();
                            	         dto.setBeginTime(HSSFDateUtil.getJavaDate(d));
                            	       }
                            	  }
                                  //value += cell.getNumericCellValue() + ",";
                              } else if (cell.getCellType() == HSSFCell.CELL_TYPE_BOOLEAN) {    //判断单元格的值是否为布尔类型                  
                            	  
                            	  if(c == 0){
                            		  dto.setSupplierId(cell.getStringCellValue().trim());
                            	  }
                            	  
                            	  if(c == 1){
                            		  dto.setSupplierName(cell.getStringCellValue().trim());
                            	  }
                            	  
                            	  if(c == 2){
                            		  dto.setSkuId(cell.getStringCellValue().trim());
                            	  }
                            	  
                            	  if(c == 3){
                            		  dto.setPurchasePrice(cell.getStringCellValue().trim());
                            	  }
                                 // value += cell.getStringCellValue() + ",";
                              }
                          }
                      }
                      
                      List<PurchasePricePO> list = null;
                      
                      if(dto.getSkuId() != null){
                    	  list = dealerProductSkuService.getPurchasePriceBySkuId(Long.parseLong(dto.getSkuId()));
                      }
                      
                      SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                      String s= "2036-12-01"; 
                      Date yuEndDate =  formatter.parse(s);
                      
                      String yuEndDateStr = formatter.format(yuEndDate);
                      
                      if(null != dto.getSupplierId() && !(getCurrentSupplierId()+"").equals(dto.getSupplierId())){
                		  ThirdPartyMessage m = new ThirdPartyMessage("fail","","excel中供应商与登录者不符");
				            model.addAttribute("message", JSONArray.fromObject(m).toString());
				            return "redirect:/product/toImport";
                	  }else{
                      
	                      if(dto.getSkuId() != null){
	                    	  
		                      for (PurchasePricePO purchasePricePO : list) {
		                    	  
		                    	  Date endDate = purchasePricePO.getEndTime();
		                    	  
		                    	  String endDateStr = formatter.format(endDate);
		                    	  
		                    	  if(yuEndDateStr.equals(endDateStr)){
		                    		  
		                    		  purchasePricePO.setEndTime(dto.getBeginTime());
		                    		  boolean status = false;
									  try {
											  status = dealerProductSkuService.updateDealerProductPurchasePrice(purchasePricePO);
									  } catch (Exception e1) {
										 if(status == false){
			                    			  LOGGER.error("采购价格表修改失败！！！" + e1.getMessage(), e1);
			                    	   }
										ThirdPartyMessage m = new ThirdPartyMessage("fail","","导入失败,修改数据异常");
				                        model.addAttribute("message", JSONArray.fromObject(m).toString());
				                        return "redirect:/product/toImport";
									}
		                    	  }
		                      }
	                      }
	                      
	                      if(null != dto.getSupplierId()){
		                      PurchasePricePO overPurchasePrice = new PurchasePricePO();
		                      overPurchasePrice.setSupplierId(dto.getSupplierId());
		                      overPurchasePrice.setSupplierName(dto.getSupplierName());
		                      overPurchasePrice.setSkuId(dto.getSkuId());
		                      overPurchasePrice.setPurchasePrice(new BigDecimal(dto.getPurchasePrice()));
		                      overPurchasePrice.setBeginTime(dto.getBeginTime());
		                      overPurchasePrice.setEndTime(yuEndDate);
		                      overPurchasePrice.setOperation(getCurrentSupplierId()+"");
		                      overPurchasePrice.setOperationTime(new Date());
		                      
		                      Map<String, String> map = new HashMap<String, String>();
		                      
		                      map.put("skuId", dto.getSkuId());
		                      map.put("supplierId", dto.getSupplierId());
		                      
		                      DealerProductSkuShowDTO dealerProductShow = dealerProductSkuService.selectproductSkuShowBySkuId(map);
		                      
		                      if(null != dealerProductShow){
		                      
			                      overPurchasePrice.setPid(dealerProductShow.getProductid());
			                      overPurchasePrice.setProductName(dealerProductShow.getProductName());
			                      
			                      boolean status2 = false;
			                      
			                      try {
			                    	  
			                    		  status2 = dealerProductSkuService.insertDealerProductPurchasePrice(overPurchasePrice);
									} catch (Exception e) {
										 if(status2 == false){
				               			  LOGGER.error("采购价格表添加失败！！！" + e.getMessage(), e);
										 }
										ThirdPartyMessage m = new ThirdPartyMessage("fail","","导入失败,插入数据库异常");
							            model.addAttribute("message", JSONArray.fromObject(m).toString());
							            return "redirect:/product/toImport";
									}
		                      }else{
		                    	  ThirdPartyMessage m = new ThirdPartyMessage("fail","","excel中SkuID与登录者不符");
		  				            model.addAttribute("message", JSONArray.fromObject(m).toString());
		  				            return "redirect:/product/toImport";
		                      }
	                      }
                	  }
                  }
              }
              
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            logger.error("解析execl错误",e);
            ThirdPartyMessage m = new ThirdPartyMessage("fail","","导入失败,解析execl错误");
            model.addAttribute("message", JSONArray.fromObject(m).toString());
            return "redirect:/product/toImport";
        } 
		
		return "redirect:/product/toImport";
        
    }
	/**
     * 转向修改类目页
     * @param model
     * @param productId
     * @return StringUrl
     */
    @RequestMapping("/product/toEditCategoryUI")
    public String toEditCategoryUI(Model model, Long productId) {  	
    	logger.info("toEditCategoryUI!!!productId："+productId);
		try {   
            DealerProductObjectDTO productObject = RemoteServiceSingleton.getInstance().getDealerProductService().findProductObjectById(productId, "");    
            String categoryId = productObject.getDealerProduct().getCatePubId(); 
            List<TdCatePub> cateNamesList = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getCategoryNameByDigui(categoryId); 
            if(cateNamesList!=null){
            	for (int i = 0; i < cateNamesList.size(); i++) {
                	TdCatePub tdCatePub = cateNamesList.get(i);
                	if(i==0){	
                		model.addAttribute("firCategoryId", tdCatePub.getCatePubId());	
                	}
                	if(i==1){	
                		model.addAttribute("secCategoryId", tdCatePub.getCatePubId());		
                	}
                	if(i==2){	
                		model.addAttribute("thiCategoryId", tdCatePub.getCatePubId());	
                	}
                	if(i==3){	
                		model.addAttribute("fouCategoryId", tdCatePub.getCatePubId());	
                	}
    			}
            }  
    		List<TdCatePub> list = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getFirstCategoryList();			
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
				model.addAttribute("productId", productId);
			}
        } catch (Exception e) {	
            LOGGER.error("获取商品信息失败productId"+productId + e.getMessage(),e);
            return "/error/notFind";
        }
        return "/zh/product/editCategoryUI";
    }
    /**
     * 修改商品分类
     * @param model
     * @param productId
     * @param type
     * @return
     */
    @RequestMapping("/product/toUpdateCategoryId")
    @ResponseBody
    public String toUpdateCategoryId(Model model, Long productId,String cateId) {  	
    	logger.info("toEditCategoryUI!!!productId："+productId);
    	LOGGER.info("用户ID:"+getCurrentUser().getSupplierId());
		try {   
			DealerProduct product = new DealerProduct();
			product.setProductid(productId);
			product.setCatePubId(cateId);
			product.setOperatetime(new Date());
			product.setOperator(getCurrentUser().getSupplierId()+"");
			SupplierProduct supplierProduct = new SupplierProduct();
			supplierProduct.setProductid(productId);
			supplierProduct.setCatePubId(cateId);
			supplierProduct.setOperatetime(new Date());
			supplierProduct.setOperator(getCurrentUser().getSupplierId()+"");
			RemoteServiceSingleton.getInstance().getDealerProductService().updateProductCategoryId(product);
			RemoteServiceSingleton.getInstance().getSupplierProductService().updateProductCategoryId(supplierProduct);
			return "1";
        } catch (Exception e) {	
            LOGGER.error("获取商品分类信息失败productId"+productId+ e.getMessage(),e);
            return "0";
        }
    }

}
