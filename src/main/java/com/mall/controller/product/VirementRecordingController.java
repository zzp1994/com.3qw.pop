package com.mall.controller.product;

import com.mall.architect.logging.Log;
import com.mall.architect.logging.LogFactory;
import com.mall.controller.base.BaseController;
import com.mall.customer.model.SqwAccountTransferRecord;
import com.mall.customer.model.User;
import com.mall.customer.service.SqwAccountRecordService;
import com.mall.customer.service.UserService;
import com.mall.mybatis.utility.PageBean;
import com.mall.pay.common.StringUtils;
import com.mall.supplier.model.Supplier;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;


/**
 * 转账配置Controller
 *
 * @author lipeng
 */

@Controller
@RequestMapping(value = "/recording")
public class VirementRecordingController extends BaseController {

    /**
     * LOGGER.
     */
    private static final Log LOGGER = LogFactory.getLogger(VirementRecordingController.class);

    @Autowired
    private SqwAccountRecordService sqwAccountRecordService;


    @Autowired
    private UserService userService;

    /**
     * 转账记录
     *
     * @return ModelAndView
     */
    @RequestMapping(value = "/virementRecording")
    public ModelAndView virementRecording(String trancNo,
                                          Integer toId,
                                          String startTime,
                                          String endTime,
                                          Integer page,
                                          Integer pageSize) {

        ModelAndView mav = new ModelAndView();
        String msg = null;

        // 获取用户ID
        Long suppilerId = getCurrentUser().getSupplierId();

        // 获取企业转账明细
        PageBean<SqwAccountTransferRecord> pageBean = new PageBean<SqwAccountTransferRecord>();
        pageBean.setOrder("desc");
        pageBean.setSortFields("create_time");
        if (null == page || page <= 0) {
            pageBean.setPage(1);
        } else {
            pageBean.setPage(page);
        }

        if (null == pageSize || pageSize <= 0) {
            pageBean.setPageSize(10);
        } else {
            pageBean.setPageSize(pageSize);
        }


        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("qiyeId", suppilerId);

        if (StringUtils.isNotEmpty(trancNo)) {
            paramMap.put("trancNo", trancNo);
        }

        if (null != toId && toId > 0) {
            paramMap.put("toId", toId);
        }

        if (StringUtils.isNotEmpty(startTime) && StringUtils.isEmpty(endTime)) {
            paramMap.put("startTime", startTime + " 00:00:00");
            paramMap.put("endTime", startTime + " 23:59:59");
        }

        if (StringUtils.isNotEmpty(endTime) && StringUtils.isEmpty(startTime)) {
            paramMap.put("startTime", endTime + " 00:00:00");
            paramMap.put("endTime", endTime + " 23:59:59");
        }

        if (StringUtils.isNotEmpty(endTime) && StringUtils.isNotEmpty(startTime)) {
            paramMap.put("startTime", startTime + " 00:00:00");
            paramMap.put("endTime", endTime + " 23:59:59");
        }

        pageBean.setParameter(paramMap);
        try {
            pageBean = sqwAccountRecordService.getQiyeTransferPageList(pageBean);
        } catch (Exception e) {
            LOGGER.error("Exception :", e);
        }

        if (null != pageBean.getResult() && !pageBean.getResult().isEmpty()) {
        	Supplier supplier = getSupplier();
           
            
            if(supplier.getOrganizationType()==null){
            	 User user = userService.findUserBySupplierId(suppilerId);
            	  if (null != user) {
                      for (SqwAccountTransferRecord str : pageBean.getResult()) {
                          str.setMemo(user.getRealName());
                      }
                  }
            	
            }
            if(supplier.getOrganizationType()!=null && supplier.getOrganizationType()==5){
            	User user2=userService.findUserById(supplier.getUserId());
          	  if (null != user2) {
                    for (SqwAccountTransferRecord str : pageBean.getResult()) {
                        str.setMemo(user2.getRealName());
                    }
                }
          	
          }
          
        }

        mav.addObject("pb", pageBean);
        mav.addObject("trancNo", StringUtils.isEmpty(trancNo) ? "" : trancNo);
        mav.addObject("toId", null == toId ? "" : toId);
        mav.addObject("startTime", StringUtils.isEmpty(startTime) ? "" : startTime);
        mav.addObject("endTime", StringUtils.isEmpty(endTime) ? "" : endTime);
        LOGGER.info(" recordList size = " + (null == pageBean.getResult() ? 0 : pageBean.getResult().size()));
        mav.setViewName("zh/product/virementRecordingList");
        return mav;
    }
}	