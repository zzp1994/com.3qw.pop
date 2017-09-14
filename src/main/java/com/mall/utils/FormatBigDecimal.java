package com.mall.utils;

import java.math.BigDecimal;
import java.text.DecimalFormat;

public class FormatBigDecimal {
	/**
	 * 格式化价钱.
	 * @param price 价格
	 * @return 格式后的价格
	 */
	public BigDecimal priceFormat(BigDecimal price){
		BigDecimal pic = new BigDecimal(0);
		if(null!=price){
			DecimalFormat priceFormat = new DecimalFormat("0.00");
			String formatPrice = priceFormat.format(price);
			pic = new BigDecimal(formatPrice);
		}
		return pic ;
	}
}
