<%@page import="model.bean.News"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/templates/public/inc/header.jsp" %>
<%@ include file="/templates/public/inc/left-bar.jsp" %>
				
			<div class="body">
				<div class="searchframe">
					<form action="<%=request.getContextPath() %>/search?active=0" method="post"  id="form">
						<input type="text" id="searchtitle" value="" name="searchtitle" placeholder="Tìm kiếm việc làm"/>
						<input type="text" id="searchadress" value="" name="searchadress" placeholder="Tỉnh/Thành phố"/>
						<button type="submit" name="submit" href="<%=request.getContextPath()%>/public/search.jsp">Tìm kiếm</button>
<%-- 						<button type="submit" name="submit" href="<%=request.getContextPath()%>/public/search.jsp">Tìm kiếm</button> --%>
					</form>	
				</div>
				<div class="allnews">
				<%
				ArrayList<News> news = (ArrayList<News>) request.getAttribute("news");
					if(news != null && news.size() > 0){
						for(News item: news){
				%>
					<div class="news">
						<div class="title"><a href="<%=request.getContextPath()%>/detail?id=<%=item.getId()%>&active=<%=item.getCategory().getId()%>"><%=item.getTitle() %><a></div>
						<div>
							<div class="right">
								<ul>
									<li class="info"><span>Đăng ngày:</span> <%=item.getDate() %></li>
									<li class="info"><span>Tên công ty:</span> <%=item.getCorporatename() %></li>
									<li class="info"><span>Tỉnh/Thành phố:</span> <%=item.getAdress() %></li>
									<li class="info"><span>Lương:</span>
										 <%if(userLogin != null){ 
											out.print(item.getSalary() + "$"); 
										  }else{%> 
										  <a href="<%=request.getContextPath()%>/login?display=public" style="color:red">Đăng nhập để xem lương</a>
										<%} %>
									</li>
									<li class="detail" >
										<a href="<%=request.getContextPath()%>/detail?id=<%=item.getId()%>&active=<%=item.getCategory().getId()%>" ><i class="fa fa-hand-o-right"> chi tiết</i> </a> 
									</li>
								</ul>
							</div>
							<div class="left">
							
							</div>
							<div class="clr"></div>	
						</div>	
					</div>	
				<%} }else{ %>
				<div class="news">
						<div class="title">Không có danh mục nào</div>
					</div>	
				<%} %>	
				</div>		
				<div class="page">
					<%
						int numberOfPages = (Integer) request.getAttribute("numberOfPages");
						int currentPage = (Integer) request.getAttribute("currentPage");
					%>
						<a href="<%=request.getContextPath()%>/index?headerActive=1&page=<%=1 %>"> « </a>
						<%	if(currentPage + 1 <= numberOfPages){ //chạy từ 1-> n-1
								for(int i = currentPage -1 ; i <= currentPage + 1 ; i ++ ){
									if(i==0){i=1;}	%>
									<a class="<%if(currentPage == i ){out.print("active");} %>"  href="<%=request.getContextPath()%>/index?headerActive=1&page=<%=i %>"> <%=i %> </a>
						<%} }else{	 
								for(int i = currentPage - 1 ; i <= numberOfPages; i++){ %>
								<a class="<%if(currentPage == i ){out.print("active");} %>"  href="<%=request.getContextPath()%>/index?headerActive=1&page=<%=i %>"> <%=i %> </a>
						<%} }%>
						<a href="<%=request.getContextPath()%>/index?headerActive=1&page=<%=numberOfPages %>"> » </a>
				</div>		
			</div>
			<div class="clr"></div>
<%@ include file="/templates/public/inc/footer.jsp" %>