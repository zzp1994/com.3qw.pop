package com.mall.tag;

import java.io.IOException;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.mall.utils.Constants;

public class TokenTag extends TagSupport {

	/**
	 * serialVersionUID.
	 */
	private static final long serialVersionUID = 7303753074190983529L;
	
	/**
	 * log.
	 */
	private static final Logger LOGGER = Logger.getLogger(TokenTag.class);
	
	public int doStartTag() throws JspException {  
	  JspWriter out = pageContext.getOut();  
	  try {  
	    out.print(renderToken());  
	  } catch (IOException e) {  
		  LOGGER.error("token标签出错："+e.getMessage(), e);
	  }  
	  // doStartTag() 方法返回 SKIP_BODY 。当然其原因是我们的token标记没有正文。  
	  return Tag.SKIP_BODY;  
	 } 
	 protected String renderToken() {
	        StringBuffer results = new StringBuffer();
	        HttpSession session = pageContext.getSession();
	        if (session != null) {
	            String token =(String) session.getAttribute(Constants.TOKEN);
	            if (token != null) {
	                results.append("<input type=\"hidden\" name=\""+Constants.TOKEN+"\" value=\"");
	                results.append(token);
	                results.append("\">");
	            }
	        }
	        return results.toString();

	}
	 public int doEndTag()throws JspTagException
	 {
	    return EVAL_PAGE;
	 }  
	
}
