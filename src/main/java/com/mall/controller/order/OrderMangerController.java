package com.mall.controller.order;

import java.awt.Insets;
import java.io.ByteArrayOutputStream;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zefer.pd4ml.PD4Constants;
import org.zefer.pd4ml.PD4ML;

import com.mall.controller.base.BaseController;
import com.mall.dealer.order.po.BasContracts;
import com.mall.merchant.proxy.RemoteServiceSingleton;
import com.mall.mybatis.utility.PageBean;
import com.mall.supplier.model.SupplierUser;
import com.mall.supplier.order.dto.ItemBatchDto;
import com.mall.supplier.order.dto.PurchaseItemBatchDto;
import com.mall.supplier.order.dto.PurchaseOrderDto;
import com.mall.utils.Common;
import com.mall.utils.Constants;

/**
 * 订单.
 * @author xusq
 */

@Controller
public class OrderMangerController extends BaseController {

	/**
	 * .
	 */
	private static final Logger LOGGER = Logger.getLogger(OrderMangerController.class);

//	/**
//	 * 转向订单页.
//	 * @return String 地址
//	 */
//	@RequestMapping(value = "/order/getOrder", method = RequestMethod.GET)
//	public String getOrder(Model model) {
//		model.addAttribute("language", getLanguage().substring(1));
//		return getLanguage() + "/order/soldOutList";
//	}

	
	@RequestMapping("/order/toDespatchUI")
	public String toDespatchUI(Long orderId,Model model){
		 boolean isMyOreder = RemoteServiceSingleton.getInstance()
			.getPurchaseOrderService().checkSupplierOfPurchaseOrder(orderId, getSupplierIds());

		 if(isMyOreder){
			try {
				PurchaseOrderDto purChaseOrderItem = new PurchaseOrderDto();
				purChaseOrderItem = RemoteServiceSingleton.getInstance()
						.getPurchaseOrderService()
						.findAllPurChaseOrderItemByPOid(orderId);
				
				Long sheilLife = purChaseOrderItem.getSupplierProductDetail().getSheilLife();
				if(null!=sheilLife&&sheilLife>0){
					sheilLife=1L;
				} else {
					sheilLife=0L;
				}
				String imgURL = purChaseOrderItem.getImgUrl();
				if (!imgURL.startsWith("http") || !imgURL.startsWith("Http")) {
					imgURL = Constants.IMAGES_VIEW1 + imgURL;
					purChaseOrderItem.setImgUrl(imgURL);
				}
				model.addAttribute("sheilLife", sheilLife);
				model.addAttribute("purDto", purChaseOrderItem);
			} catch (Exception e) {
				LOGGER.error("查看详细信息失败！!！！"+e.getMessage(),e);
			}
			
			return getLanguage() + "/order/addBatch";
		 } else {
			 return "/error/notFind";
		 }
	}
	
	
	@RequestMapping("/order/despatch")
	@ResponseBody
	public String orderDespatch(Long orderId,Long pid,Long purchaseId,Long[] skuId,String[] batchNo,Integer[] qty,Date[] createTime,Date[] endTime,int isBatch){
		
		
		String isPass = "0";
		
		PurchaseItemBatchDto batchDto = new PurchaseItemBatchDto();
		batchDto.setPid(pid);
		batchDto.setPurchaseId(purchaseId);
		List<ItemBatchDto> itemBatchDtos = new ArrayList<ItemBatchDto>(); 
		if(isBatch==1){
			for(int i =0;i< skuId.length;i++){
				ItemBatchDto batch = new ItemBatchDto();
				batch.setSkuId(skuId[i]);
				batch.setBatchNo(batchNo[i]);
				batch.setQty(qty[i]);
				batch.setCreateTime(createTime[i]);
				batch.setEndTime(endTime[i]);
				itemBatchDtos.add(batch);
			}
		} else {
				
			for(int i =0;i< skuId.length;i++){
				ItemBatchDto batch = new ItemBatchDto();
				batch.setSkuId(skuId[i]);
				batch.setBatchNo(batchNo[i]);
				batch.setQty(qty[i]);
				itemBatchDtos.add(batch);
			}
		}
		
		batchDto.setBatchList(itemBatchDtos);
		Map<Long,List<ItemBatchDto>> maps=new HashMap<Long,List<ItemBatchDto>>();
		
		for(ItemBatchDto itemBatchDto:itemBatchDtos){
			List<ItemBatchDto> list = new ArrayList<ItemBatchDto>();
		    if(maps.containsKey(itemBatchDto.getSkuId())){
		    	list =maps.get(itemBatchDto.getSkuId());
		    	list.add(itemBatchDto);
		    	
		    }else{
		    	list.add(itemBatchDto);
		    }    
		    maps.put(itemBatchDto.getSkuId(), list);
		}
		Set<Long> keys=maps.keySet();
		for(Long skuid:keys){
			List<ItemBatchDto> list=maps.get(skuid);
			for(ItemBatchDto itemBatchDto:list){
				int i=0;
				for(ItemBatchDto itemBatchDto1:list){
					if(itemBatchDto.getBatchNo().equals(itemBatchDto1.getBatchNo())){
						i++;
					}
				}
				if(i>1){
					isPass = "0";
					return isPass;
				}
			}
		}
		

			if(null!=RemoteServiceSingleton.getInstance().getPurchaseOrderService()){
				try{
					LOGGER.info("插入库存批次pid="+pid+";orderId="+orderId);
					SupplierUser supplierUser = getCurrentUser();
					String createBy = supplierUser.getLoginName() + "("
							+ supplierUser.getSupplierId() + ")";
					boolean isCreateBacth = RemoteServiceSingleton.getInstance().getPurchaseOrderService()
					.insertPurchaseItemBatch2(batchDto,createBy);
					if(isCreateBacth){
						isPass = "1";
						LOGGER.info("插入库存批次成功！！！更新订单状态！！！orderId="+orderId);
					}
				} catch (Exception e) {
					LOGGER.error("发货失败！！！pid="+pid+";orderId="+orderId+e.getMessage(),e);
				}
				
				
			}
		return isPass;
				
	}
	
	
	/**
	 * 订单详情.
	 * 
	 * @param model
	 *            model
	 * @param orderId
	 *            订单id
	 * @return String 地址
	 */
	@RequestMapping("/order/getOrderMinute")
	public String getOrderMinute(Model model, Long orderId) {
			logger.info("getOrderMinute！！！orderId:"+orderId+";supplierId:"+getCurrentSupplierId());
			 boolean isMyOreder = RemoteServiceSingleton.getInstance()
				.getPurchaseOrderService().checkSupplierOfPurchaseOrder(orderId, getSupplierIds());
			 if(isMyOreder){
				try {
					PurchaseOrderDto purChaseOrderItem = new PurchaseOrderDto();
					purChaseOrderItem = RemoteServiceSingleton.getInstance()
							.getPurchaseOrderService()
							.findAllPurChaseOrderItemByPOid(orderId);
					String imgURL = purChaseOrderItem.getImgUrl();
					if (!imgURL.startsWith("http") || !imgURL.startsWith("Http")) {
						imgURL = Constants.IMAGES_VIEW1 + imgURL;
						purChaseOrderItem.setImgUrl(imgURL);
					}
  					model.addAttribute("purDto", purChaseOrderItem);
				} catch (Exception e) {
					LOGGER.error("查看详细信息失败！!！！"+e.getMessage(),e);
				}
				
				return getLanguage() + "/order/orderMinute";
			 } else {
				 return "/error/notFind";
			 }
		}

	/**
	 * 获取订单信息.
	 * 
	 * @param model
	 *            model
	 * @param selectFinddto
	 *            查询dto
	 * @param page
	 *            分页
	 * @return String
	 */
	@RequestMapping(value = "/order/getOrder", method = RequestMethod.POST)
	public String getOrder(Model model, PurchaseOrderDto selectFinddto,Integer page) {
		logger.info("查询订单信息！！！status:"+selectFinddto.getStatus());
		try {
 
			PageBean<PurchaseOrderDto> findAllRetailerOrder = null;
			PageBean<PurchaseOrderDto> pageBean = new PageBean<PurchaseOrderDto>();


			
			selectFinddto.setSupplierIds(getSupplierIds());
			
			
			if (page != null && page != 0) {
				pageBean.setPage(page);
			} else {
				pageBean.setPage(1);
			}
			
			pageBean.setPageSize(Constants.PAGE_NUM_TEN);
			pageBean.setParameter(selectFinddto);

			if (RemoteServiceSingleton.getInstance().getPurchaseOrderService() != null) {
				findAllRetailerOrder = RemoteServiceSingleton.getInstance()
						.getPurchaseOrderService()
						.findAllDealerOrdersBySupplier(pageBean);
			}

			if (findAllRetailerOrder != null) {
				List<PurchaseOrderDto> result = findAllRetailerOrder
						.getResult();
				if (result != null && result.size() > 0) {
					for (int i = 0; i < result.size(); i++) {
						String imgUrl = result.get(i).getImgUrl();
						if (!imgUrl.startsWith("http")
								|| !imgUrl.startsWith("Http")) {
							imgUrl = Constants.IMAGES_VIEW1 + imgUrl;
							result.get(i).setImgUrl(imgUrl);
						}
					}
				}
			}

			model.addAttribute("pb", findAllRetailerOrder);
			return getLanguage() + "/order/modelPage/orderAllList";

		} catch (Exception e) {
			LOGGER.error("获取订单失败"+e.getMessage(), e);
			return null;
		}
	}

	/**
	 * 更改订单状态.
	 * 
	 * @param orderId
	 *            订单id
	 * @param status
	 *            状态吗
	 * @return Stringurl
	 */
	@RequestMapping("/order/validationMoney")
	@ResponseBody
	public String validationMoney(Long orderId, Short status) {
		try {

			SupplierUser supplierUser = getCurrentUser();
			String createBy = supplierUser.getLoginName() + "("
					+ supplierUser.getSupplierId() + ")";
			if (RemoteServiceSingleton.getInstance().getPurchaseOrderService() != null) {
				RemoteServiceSingleton.getInstance().getPurchaseOrderService()
						.updatePurchaseOrderStatusByPoid(orderId, status,createBy);
			}
			logger.info("修改订单状态成功！！！orderId=" + orderId + ";status=" + status+";supplierId="+getCurrentSupplierId());
			return "1";
		} catch (Exception e) {
			LOGGER.error("修改订单状态失败！！！"+e.getMessage(), e);
		}
		return "0";
	}

	/**
	 * 合同预览.
	 * 
	 * @param orderId
	 *            orderId
	 * @param model
	 *            model
	 * @return
	 */
	@RequestMapping("/order/viewerContract")
	public String viewerContract(Long orderId, Model model) {
		
		LOGGER.info("viewerContract==orderId:"+orderId+";supplierId:"+getCurrentSupplierId());
			/* boolean isMyOreder = RemoteServiceSingleton.getInstance()
					.getPurchaseOrderService().checkSupplierOfPurchaseOrder(orderId,getSupplierIds());
			 if(isMyOreder){*/
				PurchaseOrderDto contactData = new PurchaseOrderDto();
				List<String> salePackVals = new ArrayList<String>();
				List<String> shipPackVals = new ArrayList<String>();
				List<String> others = new ArrayList<String>();
				try {
					contactData = RemoteServiceSingleton.getInstance()
							.getDealerOrderService().contactData(orderId);
					BasContracts basContracts = contactData.getBasContracts();
					if(basContracts!=null){
						//货物销售包装1|2|3|100asdasdasd
						String cargoSalesPacking = basContracts.getCargoSalesPacking();
						 String[] salesPackings = cargoSalesPacking.split("\\|"); 
						 
						 if(!Common.isEmptyArray(salesPackings)){
							 for (int i = 0; i < salesPackings.length; i++) { 
								 if(salesPackings[i].startsWith("100")){
									 others.add(salesPackings[i].substring(3));
								 } else{
									 salePackVals.add(salesPackings[i]);
								 }
							}
						 }
						
						 
						 basContracts.getLatestDate();
						 
						//货物运输包装1|2|3|100aaaa
						String cargoTransportation = basContracts.getCargoTransportation();
						String[] transportations = cargoTransportation.split("\\|");
						
						 if(!Common.isEmptyArray(transportations)){
							 for (int i = 0; i < transportations.length; i++) {
								 if(transportations[i].startsWith("100")){
									 others.add(transportations[i].substring(3));
								 } else {
									 shipPackVals.add(transportations[i]);
								 }
							} 
						 } 
					}
					
					
					
				} catch (Exception e) {
					LOGGER.error("获取合同失败！"+e.getMessage(),e);
				}
				
				model.addAttribute("others", others);
				model.addAttribute("salePackVals",salePackVals);
				model.addAttribute("shipPackVals",shipPackVals);
				model.addAttribute("contract", contactData);
				model.addAttribute("orederId", orderId);
				return getLanguage() + "/order/orderContract";
			 /*}else{
				 return "/error/notFind";
			 }*/
			 
	}

	/**
	 * 转向合同修改页.
	 *  
	 * @param model
	 *            model
	 * @param orderId
	 *            orderId
	 * @return 合同页
	 */
	@RequestMapping("/order/toEditContractUI")
	public String toEditContract(Model model, Long orderId) {
		boolean isMyOreder = RemoteServiceSingleton.getInstance()
				.getPurchaseOrderService().checkSupplierOfPurchaseOrder(orderId, getSupplierIds());

		LOGGER.info("toEditContractUI==orderId:"+orderId+";supplierId:"+getCurrentSupplierId());
		 if(isMyOreder){
			 
				PurchaseOrderDto contactData = new PurchaseOrderDto();
				try {
					contactData = RemoteServiceSingleton.getInstance()
							.getDealerOrderService().contactData(orderId);
				} catch (Exception e) {
					LOGGER.error("获取合同失败！"+e.getMessage(),e);
				}
				
				model.addAttribute("contract", contactData);
				return getLanguage() + "/order/editContract";
		 }else{
			 
			 return "/error/notFind";
		 }
	}

	/**
	 * 填写合同.
	 * @param basContracts
	 *            合同信息
	 * @param shippingPackage
	 *            运输包装
	 * @param salePackage
	 *            销售包装
	 * @param orderId
	 *            orderId
	 * @return 页面
	 */
	@RequestMapping("/order/editContract")
	public String editContract(BasContracts basContracts,
			String[] shippingPackage, String[] salePackage, Long orderId,
			String shipPackOthers, String salePackOthers) {

		LOGGER.info("editContract==orderId:"+orderId+";supplierId:"+getCurrentSupplierId());
		basContracts.setStatus(Constants.ORDER_SUPPPLIER_FILLED);

		
		
		// 销售包装
		StringBuffer salePackVals = new StringBuffer();
		for (int i = 0; i < salePackage.length; i++) {
			if (i > 0) {
				salePackVals.append("|");
			}
			salePackVals.append(salePackage[i]);
		}
		if (null!=salePackOthers) {
			salePackVals.append("|100" + salePackOthers);
		}
		basContracts.setCargoSalesPacking(salePackVals.toString());

		// 运输包装
		StringBuffer shipPackVals = new StringBuffer();
		for (int j = 0; j < shippingPackage.length; j++) {
			if (j > 0) {
				shipPackVals.append("|");
			}
			shipPackVals.append(shippingPackage[j]);
		}

		if (null!=shipPackOthers) {
			shipPackVals.append("|100" + shipPackOthers);
		}

		basContracts.setCargoTransportation(shipPackVals.toString());
		try {
			String createBy = getCurrentUser().getLoginName() + "("
					+ getCurrentUser().getUserId() + ")";
			
			LOGGER.info("修改合同user:"+createBy+";orderId"+orderId);
			RemoteServiceSingleton.getInstance().getDealerOrderService()
					.updateBasContactsSelective(basContracts);
			RemoteServiceSingleton.getInstance().getPurchaseOrderService()
					.updatePurchaseOrderStatusByPoid(orderId,Constants.ORDER_SUPPPLIER_FILLED, createBy);
		} catch (Exception e) {
			LOGGER.error("保存合同失败！"+e.getMessage(),e);
		}
		return "redirect:/order/getOrder";
	}
	
	
	
	/**
	 * 转向确认合同页面
	 * @param orderId 订单id
	 * @param model model
	 * @return 
	 */
	@RequestMapping("/order/affirmUI")
	public String toAffirmContractUI(Long orderId, Model model){
		LOGGER.info("toAffirmContractUI==orderId:"+orderId+";supplierId:"+getCurrentSupplierId());
		 boolean isMyOreder = RemoteServiceSingleton.getInstance()
					.getPurchaseOrderService().checkSupplierOfPurchaseOrder(orderId,getSupplierIds());

			 if(isMyOreder){
				PurchaseOrderDto contactData = new PurchaseOrderDto();
				List<String> salePackVals = new ArrayList<String>();
				List<String> shipPackVals = new ArrayList<String>();
				List<String> others = new ArrayList<String>();
				try {
					contactData = RemoteServiceSingleton.getInstance()
							.getDealerOrderService().contactData(orderId);
					BasContracts basContracts = contactData.getBasContracts();
					if(basContracts!=null){
						//货物销售包装1|2|3|100asdasdasd
						String cargoSalesPacking = basContracts.getCargoSalesPacking();
						 String[] salesPackings = cargoSalesPacking.split("\\|"); 
						 
						 if(!Common.isEmptyArray(salesPackings)){
							 for (int i = 0; i < salesPackings.length; i++) { 
								 if(salesPackings[i].startsWith("100")){
									 others.add(salesPackings[i].substring(3));
								 } else{
									 salePackVals.add(salesPackings[i]);
								 }
							}
						 }
						
						 
						 basContracts.getLatestDate();
						 
						//货物运输包装1|2|3|100aaaa
						String cargoTransportation = basContracts.getCargoTransportation();
						String[] transportations = cargoTransportation.split("\\|");
						
						 if(!Common.isEmptyArray(transportations)){
							 for (int i = 0; i < transportations.length; i++) {
								 if(transportations[i].startsWith("100")){
									 others.add(transportations[i].substring(3));
								 } else {
									 shipPackVals.add(transportations[i]);
								 }
							} 
						 } 
					}
					
					
					
				} catch (Exception e) {
					LOGGER.error("获取合同失败！"+e.getMessage(),e);
				}
				
				model.addAttribute("others", others);
				model.addAttribute("salePackVals",salePackVals);
				model.addAttribute("shipPackVals",shipPackVals);
				
				model.addAttribute("contract", contactData);
				model.addAttribute("orederId", orderId);
				return getLanguage() + "/order/affirmContract";
			 }else{
				 return "/error/notFind";
			 }
	}

	/**
	 * 打印发货单页面.
	 * 
	 * @param orderId
	 *            orderId
	 * @param model
	 *            model
	 * @return 页面
	 */
	@RequestMapping("/order/toPrintDespatchUI")
	public String toPrintDespatch(Long orderId, Model model) {
		// TODO
		PurchaseOrderDto contactData = new PurchaseOrderDto();
		try {
			contactData = RemoteServiceSingleton.getInstance()
					.getDealerOrderService().contactData(orderId);
		} catch (Exception e) {
			logger.error("获取发货单失败！！！"+e.getMessage(),e);
		}
		model.addAttribute("contract", contactData);
		return getLanguage() + "/order/printDespatch";
	}

	/**
	 * 打印发货单.
	 * 
	 * @param response
	 * @param request
	 * @param orderId
	 * @return
	 */
	@RequestMapping("/order/printDespatch")
	public String printDespatch(HttpServletResponse response,
			HttpServletRequest request, Long orderId, String content) {

		
		String createBy = getCurrentUser().getLoginName() + "("
				+ getCurrentUser().getUserId() + ")";

		try {
			RemoteServiceSingleton.getInstance().getPurchaseOrderService()
					.updatePurchaseOrderStatusByPoid(orderId,Constants.ORDER_PRINT_DESPATCH, createBy);

			response.setContentType("application/pdf");

			content = "<html><head><title>打印发货单 </title> </head><body>"
					+ content + "</body></html>";
			PD4ML pd4ml = new PD4ML();
			pd4ml.setPageInsets(new Insets(20, 10, 10, 10));
			pd4ml.setHtmlWidth(950);
			pd4ml.setPageSize(pd4ml.changePageOrientation(PD4Constants.A4));
			pd4ml.useTTF("java:fonts", true);
			pd4ml.setDefaultTTFs("SimHei", "Arial", "Courier New");
			pd4ml.enableDebugInfo();
			response.setContentType("application/pdf");
			response.setHeader("Content-disposition","inline; filename=test.pdf");
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			StringReader strReader = new StringReader(content.toString());
			pd4ml.render(strReader, baos);
			byte[] result = baos.toByteArray();
			response.setContentLength(result.length);
			ServletOutputStream sos = response.getOutputStream();
			if (sos != null) {
				sos.write(result);
			}
			if (sos != null) {
				sos.close();
			}
		} catch (Exception e) {

		    LOGGER.error("打印发货单异常！！"+e.getMessage(),e);
		}

		return null;
	}

	/**
	 * 打印合同.
	 * 
	 * @param response
	 *            HttpServletRequest
	 * @param request
	 *            HttpServletResponse
	 * @param content
	 *            body
	 * @return ""
	 */
	@RequestMapping("/order/printContract")
	public String print(HttpServletResponse response,
			HttpServletRequest request, String content) {

		LOGGER.info("printContract==supplierId:"+getCurrentSupplierId());
		try {

			response.setContentType("application/pdf");

			content = "<html><head><title>打印合同 </title> </head><body>"
					+ content + "</body></html>";
			PD4ML pd4ml = new PD4ML();
			pd4ml.setPageInsets(new Insets(20, 10, 10, 10));
			pd4ml.setHtmlWidth(950);
			pd4ml.setPageSize(pd4ml.changePageOrientation(PD4Constants.A4));
			pd4ml.useTTF("java:fonts", true);
			pd4ml.setDefaultTTFs("YaHei", "YaHei", "KaiTi");
			pd4ml.enableDebugInfo();
			response.setContentType("application/pdf");
			response.setHeader("Content-disposition","inline; filename=ImportContact.pdf");
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			StringReader strReader = new StringReader(content.toString());
			pd4ml.render(strReader, baos); 
			byte[] result = baos.toByteArray();
			response.setContentLength(result.length);
			ServletOutputStream sos = response.getOutputStream();
			if (sos != null) {
				sos.write(result);
			}
			if (sos != null) {
				sos.close();
			}

		} catch (Exception e) {
			LOGGER.error("打印合同失败！！！"+e.getMessage(),e);
		}

		return null;
	}
}
