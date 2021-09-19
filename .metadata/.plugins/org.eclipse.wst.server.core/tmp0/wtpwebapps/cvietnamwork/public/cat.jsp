<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/templates/public/inc/header.jsp" %>
<%@ include file="/templates/public/inc/left-bar.jsp" %>

			<div class="body">
				<div class="cat">
				<%
					Category category = (Category) request.getAttribute("category");
				%>
					<span>Tuyển dụng ngành <%=category.getName() %></span>
				</div>
				<div class="news">
				<%
					ArrayList<News> news = (ArrayList<News>) request.getAttribute("news");
					if(news != null && news.size() > 0){
						for(News item: news){
				%>
					<ul>
						<li class="title"><a href="<%=request.getContextPath()%>/detail?id=<%=item.getId()%>&active=<%=category.getId()%>"><%=item.getTitle() %><a></li>
						<li class="info"><span>Đăng ngày:</span> <%=item.getDate() %></li>
						<li class="info"><span>Công ty:</span> <%=item.getCorporatename() %></li>
						<li class="info"><span>Địa chỉ:</span> <%=item.getAdress() %></li>
						<li class="info"><span>Lương:</span> 
							<%if(userLogin != null){ 
								out.print(item.getSalary() + "$"); 
							  }else{%> 
							  <a href="<%=request.getContextPath()%>/login?display=public" style="color:red">Đăng nhập để xem lương</a>
							<%} %>
						</li>
						<li class="detail" >
							<a href="<%=request.getContextPath()%>/detail?id=<%=item.getId()%>&active=<%=category.getId()%>" ><i class="fa fa-hand-o-right"> chi tiết</i> </a> 
						</li>
					</ul>
				<%} }else{%>
					Không có dữ liệu
				<%} %>

				</div>	
				<div class="page">
					<%	
						int numberOfPages = (Integer) request.getAttribute("numberOfPages");
						int currentPage = (Integer) request.getAttribute("currentPage");
						
						String cat_id = (String)request.getAttribute("cat_id");
					%>
						<a href="<%=request.getContextPath()%>/cat?cat_id=<%=category.getId()%>&active=<%=category.getId()%>&page=<%=1 %>"> « </a>
						<%	if(currentPage + 1 <= numberOfPages){ //chạy từ 1-> n-1
								for(int i = currentPage -1 ; i <= currentPage + 1 ; i ++ ){
									if(i==0){i=1;}	%>
									<a class="<%if(currentPage == i ){out.print("active");} %>"  href="<%=request.getContextPath()%>/cat?cat_id=<%=category.getId()%>&active=<%=category.getId()%>&page=<%=i %>"> <%=i %> </a>
						<%} }else{	// đây là 2 trang cuối
								for(int i = currentPage - 1 ; i <= numberOfPages; i++){  if(i==0){i=1;}%>
									 	 
								<a class="<%if(currentPage == i ){out.print("active");} %>"  href="<%=request.getContextPath()%>/cat?cat_id=<%=category.getId()%>&active=<%=category.getId()%>&page=<%=i %>"> <%=i %> </a>
						<%} }%>
						<a href="<%=request.getContextPath()%>/cat?cat_id=<%=category.getId()%>&active=<%=category.getId()%>&page=<%=numberOfPages %>"> » </a>
				</div>		
			</div>
			<div class="clr"></div>
<%@ include file="/templates/public/inc/footer.jsp" %>