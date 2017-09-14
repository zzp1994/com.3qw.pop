<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
		<div class="blank10"></div>
		<div class="shang" style="margin:5px 20px 0 0;">
		<c:if test="${pageBean.totalPage >= 1}">
				<c:choose>
					<c:when test="${pageBean.page==1 }">
						<button class="y" type="button"  ><img src="${path}/images/x6.png"> 上一页</button>
					</c:when>
					
					<c:otherwise>
						<a href='javascript:void(0)' onclick="toPage(${pageBean.page-1})">
						<button type="button" class="y1"><img src="${path}/images/x5.png"> 上一页 
						</button>
						</a>
					</c:otherwise>
				</c:choose>
				<c:choose>	
								
					<c:when test="${pageBean.page < 4}">
						<c:choose>
							<c:when test="${pageBean.totalPage>6}">
								<c:set var="stopPage" value="7"/>
							</c:when> 
							<c:when test="${pageBean.totalPage<8}">
								<c:set var="stopPage" value="${pageBean.totalPage }"/>
							</c:when> 
						</c:choose>
						<c:set var="startPage" value="1"/>
							<c:forEach begin="${startPage }" end="${stopPage }" varStatus="i" >
								<c:choose>
								<c:when test="${pageBean.page == i.index}">
										<input type="button" style="color:#ff6600; font-weight:bold; border:none;" value="${i.index }"/>		
								</c:when>
								<c:when test="${pageBean.page !=  i.index}">
										<a href='javascript:void(0)' onclick="toPage(${i.index})"><input type='button'  value="${i.index }"/></a>
								</c:when>
								</c:choose>
							</c:forEach>
							
							
						<c:if test="${(pageBean.totalPage-pageBean.page)>4&&pageBean.totalPage>8 }">
							......<a href='#'><input type='button'  value="${pageBean.totalPage }" onclick="toPage(${pageBean.totalPage})"/></a>
						</c:if>
					</c:when>
					
					
					
					<c:when test="${pageBean.page > 3 }" >
							
							<%-- <c:if test="${pageBean.page > 4 }">
								<a href='#'><input type='button'  value="1" onclick="toPage(1)"/></a>......
							</c:if> --%>
							<c:if test="${pageBean.page>5&&pageBean.totalPage>8 }">
									<a href='#'><input type='button'  value="1" onclick="toPage('1')"/></a>......
							</c:if>
							
							<c:choose>
								<c:when test="${pageBean.totalPage<8 }">
									<c:set var="startPage" value="1"/>
								</c:when>
								<c:when test="${pageBean.totalPage-pageBean.page<3 }">
									<c:set var="startPage" value="${pageBean.page-(7-(pageBean.totalPage-pageBean.page))+1 }"/>
								</c:when>
								<c:otherwise>
									<c:set var="startPage" value="${pageBean.page-3 }"/>
								</c:otherwise>
							</c:choose>
							
							
							<c:choose>
								<c:when test="${pageBean.totalPage-pageBean.page<3 }">
									<c:set var="stopPage" value="${pageBean.totalPage }"/>
								</c:when>
								<c:otherwise>
									<c:set var="stopPage" value="${pageBean.page+3 }"/>
								</c:otherwise>
							</c:choose>
							<c:forEach begin="${startPage }" end="${stopPage }" varStatus="i" >
									<c:choose>
									<c:when test="${pageBean.page eq i.index}">
											<input type="button" style="color:#ff6600; font-weight:bold; border:none;" value="${i.index }"/>		
									</c:when>
									<c:when test="${pageBean.page !=  i.index}">
											<a href='#'><input type='button'  value="${i.index }" onclick="toPage(${i.index})"/></a>
									</c:when>
									</c:choose>
							</c:forEach>
							<c:if test="${(pageBean.totalPage-pageBean.page)>4 }">
							......<a href='#'><input type='button'  value="${pageBean.totalPage }" onclick="toPage(${pageBean.totalPage})"/></a>
						</c:if>
					</c:when>
				</c:choose>	
				
				<c:choose>
					<c:when test="${pageBean.page<pageBean.totalPage}">
						<a href='javascript:void(0)' onclick="toPage(${pageBean.page+1})">
							<button class="y1" type="button">下一页 
								<img src="${path}/images/x7.png">
							</button>
						</a>
					</c:when>
					<c:otherwise>
						<button class="y" type="button"> 下一页  <img src="${path}/images/x61.png"></button>
					</c:otherwise>
				</c:choose>	
					<input type="text" class="go" id="go" placeholder="Page Num">
					<button type="button" class="go_button" onclick="javascript: var pagenum=document.getElementById('go').value; toPage(pagenum)">GO</button>
			</div>
			</c:if>
			<div class="blank10"></div>
