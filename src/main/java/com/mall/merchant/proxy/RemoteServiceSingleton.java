package com.mall.merchant.proxy;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.alibaba.fastjson.JSON;
import com.mall.category.api.rpc.BaseDataServiceRpc;
import com.mall.category.api.rpc.BrandServiceRpc;
import com.mall.category.api.rpc.CategoryServiceRpc;
import com.mall.category.po.TdCatePub;
import com.mall.customer.order.api.rpc.CustomerOrderExportSevice;
import com.mall.customer.order.api.rpc.CustomerOrderService;
import com.mall.customer.service.HomeNumRecordService;
import com.mall.customer.service.ProductCostPriceSettingService;
import com.mall.customer.service.SqwAccountRecordService;
import com.mall.customer.service.UserService;
import com.mall.dealer.order.api.rpc.DealerOrderService;
import com.mall.dealer.product.api.DealerProductExportExcelService;
import com.mall.dealer.product.api.DealerProductService;
import com.mall.dealer.product.api.DealerProductSkuService;
import com.mall.dealer.product.retailer.api.LogisticTempService;
import com.mall.dealer.productTags.api.ProductTagsService;
import com.mall.retailer.order.api.rpc.ShipOrderB2CService;
import com.mall.stock.api.rpc.StockService;
import com.mall.stock.api.rpc.StockSupplyService;
import com.mall.supplier.order.api.rpc.PurchaseOrderService;
import com.mall.supplier.product.api.SupplierProductAuditService;
import com.mall.supplier.product.api.SupplierProductService;
import com.mall.supplier.product.draft.SupplierDraftProductService;
import com.mall.supplier.service.SupplierBrandManagerService;
import com.mall.supplier.service.SupplierManagerService;
import com.mall.supplier.service.SupplierRoleManagerService;
import com.mall.supplier.service.SupplierUserManagerService;

public class RemoteServiceSingleton {

	private static final Logger LOGGER = Logger.getLogger(RemoteServiceSingleton.class);

	private static ApplicationContext context;

	static class RemoteServiceSingletonHolder {
		static RemoteServiceSingleton instance = new RemoteServiceSingleton();
		static {
			context = new ClassPathXmlApplicationContext(
					new String[] { "remoting.xml" });
		}
	}

	public static RemoteServiceSingleton getInstance() {
		return RemoteServiceSingletonHolder.instance;
	}

	/************************ 请修改以下方法 **************************/
	
	@SuppressWarnings("finally")
	public SupplierUserManagerService getSupplierUserManagerService() {
		SupplierUserManagerService supplierUserManagerService = null;
		try {
			supplierUserManagerService = (SupplierUserManagerService) context
					.getBean("supplierUserManagerService");
		} catch (Exception e) {
			LOGGER.error(e.getMessage(), e);
		} finally {
			return supplierUserManagerService;
		}
	}
	
	@SuppressWarnings("finally")
	public HomeNumRecordService getHomeNumRecordService() {
		HomeNumRecordService homeNumRecordService = null;
		try {
			homeNumRecordService = (HomeNumRecordService) context
					.getBean("homeNumRecordService");
		} catch (Exception e) {
			LOGGER.error(e.getMessage(), e);
		} finally {
			return homeNumRecordService;
		}
	}
	
	@SuppressWarnings("finally")
	public SupplierManagerService getSupplierManagerService() {
		SupplierManagerService supplierManagerService = null;
		try {
			supplierManagerService = (SupplierManagerService) context
					.getBean("supplierManagerService");
		} catch (Exception e) {
			LOGGER.error(e.getMessage(), e);
		} finally {
			return supplierManagerService;
		}
	}
	
	@SuppressWarnings("finally")
	public SupplierRoleManagerService getSupplierRoleManagerService() {
		SupplierRoleManagerService supplierRoleManagerService = null;
		try {
			supplierRoleManagerService = (SupplierRoleManagerService) context
					.getBean("supplierRoleManagerService");
		} catch (Exception e) {
			LOGGER.error(e.getMessage(), e);
		} finally {
			return supplierRoleManagerService;
		}
	}
	@SuppressWarnings("finally")
	public SupplierBrandManagerService getSupplierBrandManagerService() {
		SupplierBrandManagerService supplierBrandManagerService = null;
		try {
			supplierBrandManagerService = (SupplierBrandManagerService) context
					.getBean("supplierBrandManagerService");
		} catch (Exception e) {
			LOGGER.error(e.getMessage(), e);
		} finally {
			return supplierBrandManagerService;
		}
	}
	
	@SuppressWarnings("finally")
	public CategoryServiceRpc getCategoryServiceRpc() {
		CategoryServiceRpc categoryServiceRpc = null;
		try {
			categoryServiceRpc = (CategoryServiceRpc) context
					.getBean("categoryServiceRpc");
		} catch (Exception e) {
			LOGGER.error(e.getMessage(), e);
		} finally {
			return categoryServiceRpc;
		}
	}
	
	@SuppressWarnings("finally")
	public BaseDataServiceRpc getBaseDataServiceRpc() {
		BaseDataServiceRpc baseDataServiceRpc = null;
		try {
			baseDataServiceRpc = (BaseDataServiceRpc) context
					.getBean("baseDataServiceRpc");
		} catch (Exception e) {
			LOGGER.error(e.getMessage(), e);
		} finally {
			return baseDataServiceRpc;
		}
	}
	
	@SuppressWarnings("finally")
	public SupplierProductService getSupplierProductService() {
		SupplierProductService supplierProductService = null;
		try {
			supplierProductService = (SupplierProductService) context
					.getBean("supplierProductService");
		} catch (Exception e) {
			LOGGER.error(e.getMessage(), e);
		} finally {
			return supplierProductService;
		}
	}
	
	@SuppressWarnings("finally")
	public PurchaseOrderService getPurchaseOrderService() {
		PurchaseOrderService purchaseOrderService = null;
		try {
			purchaseOrderService = (PurchaseOrderService) context
					.getBean("purchaseOrderService");
		} catch (Exception e) {
			LOGGER.error(e.getMessage(), e);
		} finally {
			return purchaseOrderService;
		}
	}
	
	@SuppressWarnings("finally")
	public StockSupplyService getStockSupplyService() {
		StockSupplyService stockSupplyService = null;
		try {
			stockSupplyService = (StockSupplyService) context
					.getBean("stockSupplyService");
		} catch (Exception e) {
			LOGGER.error(e.getMessage(), e);
		} finally {
			return stockSupplyService;
		}
	}
	
	@SuppressWarnings("finally")
	public DealerOrderService getDealerOrderService() {
		DealerOrderService dealerOrderService = null;
		try {
			dealerOrderService = (DealerOrderService) context
					.getBean("dealerOrderService");
		} catch (Exception e) {
			LOGGER.error(e.getMessage(), e);
		} finally {
			return dealerOrderService;
		}
	}
	
	@SuppressWarnings("finally")
	public BrandServiceRpc getBrandServiceRpc() {
		BrandServiceRpc brandServiceRpc = null;
		try {
			brandServiceRpc = (BrandServiceRpc) context
					.getBean("brandServiceRpc");
		} catch (Exception e) {
			LOGGER.error(e.getMessage(), e);
		} finally {
			return brandServiceRpc;
		}
	}
	
	@SuppressWarnings("finally")
	public SupplierDraftProductService getSupplierDraftProductService() {
		SupplierDraftProductService supplierDraftProductService = null;
		try {
			supplierDraftProductService = (SupplierDraftProductService) context
					.getBean("supplierDraftProductService");
		} catch (Exception e) {
			LOGGER.error(e.getMessage(), e);
		} finally {
			return supplierDraftProductService;
		}
	}
	
	
	
	public static void main(String[] args) throws Exception {
		List<TdCatePub> topCategoryList = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getTopCategoryList();
		
		System.out.println(JSON.toJSON(topCategoryList).toString());
		
	}
	
	/**
	 * . (商品信息dealerProductService)
	 * 
	 * @return DealerProductService
	 */

	public DealerProductService getDealerProductService() {
		DealerProductService dealerProductService = null;
		try {
			dealerProductService = (DealerProductService) context.getBean("dealerProductService");
		} catch (Exception e) {
			LOGGER.error("调用商品信息接口bean错误:  msg:" + e.getMessage(), e);
		}
		return dealerProductService;
	}

	/**
	 * . (商品信息dealerProductService)
	 *
	 * @return DealerProductService
	 */

	public DealerProductSkuService getDealerProductSkuService() {
		DealerProductSkuService dealerProductService = null;
		try {
			dealerProductService = (DealerProductSkuService) context.getBean("dealerProductSkuService");
		} catch (Exception e) {
			LOGGER.error("调用商品信息接口bean错误:  msg:" + e.getMessage(), e);
		}
		return dealerProductService;
	}

	/**
	 * . (库存信息StockService)
	 *
	 * @return StockService
	 */

	public StockService getStockService() {
		StockService stockService = null;
		try {
			stockService = (StockService) context.getBean("stockService");
		} catch (Exception e) {
			LOGGER.error("调用库存信息接口bean错误:  msg:" + e.getMessage(), e);
		}
		return stockService;
	}
	/**
	 * 物流-平台自定义运费模板
	 * 
	 * @return
	 */
	public DealerProductExportExcelService getDealerProductExportExcelService() {
		DealerProductExportExcelService dealerProductExportExcelService = null;
		try {
			dealerProductExportExcelService = (DealerProductExportExcelService) context.getBean("dealerProductExportExcelService");
		} catch (Exception e) {
			LOGGER.error("platformLogisticTempService bean is not found" + e.getMessage(), e);
		}
		return dealerProductExportExcelService;

	}
	
	// B2C订单接口服务
	@SuppressWarnings("finally")
	public CustomerOrderService getCustomerOrderService() {
		CustomerOrderService customerOrderService = null;
		try {
			customerOrderService = (CustomerOrderService) context.getBean("customerOrderService");
		} catch (Exception e) {
			LOGGER.error(e.getMessage(), e);
			LOGGER.error("调用B2C订单接口服务错误:  msg:" + e.getMessage(), e);
		} finally {
			return customerOrderService;
		}
	}
	
	// B2C用户接口服务
	@SuppressWarnings("finally")
	public UserService getUserService() {
		UserService userService = null;
		try {
			userService = (UserService) context.getBean("userService");
		} catch (Exception e) {
			LOGGER.error("调B2C用户接口服务错误:  msg:" + e.getMessage(), e);
		} finally {
			return userService;
		}
	}
	// 获取用户结算或未结算订单接口服务
	@SuppressWarnings("finally")
	public SqwAccountRecordService getSqwAccountRecordService() {
		SqwAccountRecordService sqwAccountRecordService = null;
		try {
			sqwAccountRecordService = (SqwAccountRecordService) context.getBean("sqwAccountRecordService");
		} catch (Exception e) {
			LOGGER.error("获取用户结算或未结算订单接口服务:  msg:" + e.getMessage(), e);
		} finally {
			return sqwAccountRecordService;
		}
	}
	
	// 订单导出服务
	@SuppressWarnings("finally")
	public CustomerOrderExportSevice getCustomerOrderExportService() {
		CustomerOrderExportSevice customerOrderExportSevice = null;
		try {
			customerOrderExportSevice = (CustomerOrderExportSevice) context.getBean("customerOrderExportSevice");
		} catch (Exception e) {
			LOGGER.error("调B2C用户接口服务错误:  msg:" + e.getMessage(), e);
		} finally {
			return customerOrderExportSevice;
		}
	}
	
	/**
	 * 获取物流商接口
	 * @return
	 */
	@SuppressWarnings("finally")
	public LogisticTempService getlogisticTempService(){
		LogisticTempService logisticTempService = null;
		try {
			logisticTempService = (LogisticTempService) context.
					getBean("logisticTempService");
		} catch (Exception e) {
			LOGGER.error(e.getMessage(),e);
		}finally{
		return logisticTempService;
		}
	}
	/**
	 * 获取物流商接口
	 * @return
	 */
	@SuppressWarnings("finally")
	public ShipOrderB2CService getShipOrderB2CService(){
		ShipOrderB2CService shipOrderB2CService = null;
		try {
			shipOrderB2CService = (ShipOrderB2CService) context.
					getBean("shipOrderB2CService");
		} catch (Exception e) {
			LOGGER.error(e.getMessage(),e);
		}finally{
			return shipOrderB2CService;
		}
	}

	/**
	 * 成本价设置接口
	 * @return
	 */
	@SuppressWarnings("finally")
	public ProductCostPriceSettingService getProductCostPriceSettingService(){
		ProductCostPriceSettingService productCostPriceSettingService = null;
		try {

			productCostPriceSettingService = (ProductCostPriceSettingService) context.
					getBean("productCostPriceSettingService");
		} catch (Exception e) {
			LOGGER.error(e.getMessage(),e);
		}finally{
			return productCostPriceSettingService;
		}
	}

	/**
	 * 商品审核记录接口
	 * @return
	 */
	@SuppressWarnings("finally")
	public SupplierProductAuditService getSupplierProductAuditService(){
		SupplierProductAuditService supplierProductAuditService = null;
		try {

			supplierProductAuditService = (SupplierProductAuditService) context.
					getBean("supplierProductAuditService");
		} catch (Exception e) {
			LOGGER.error(e.getMessage(),e);
		}finally{
			return supplierProductAuditService;
		}
	}
	
	@SuppressWarnings("finally")
	public ProductTagsService getProductTagsService(){
		ProductTagsService productTagsService = null;
		try {

			productTagsService = (ProductTagsService) context.
					getBean("productTagsService");
		} catch (Exception e) {
			LOGGER.error(e.getMessage(),e);
		}finally{
			return productTagsService;
		}
	}
	
}
