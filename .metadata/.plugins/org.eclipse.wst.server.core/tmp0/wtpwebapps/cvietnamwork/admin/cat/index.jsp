<%@page import="model.bean.Category"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/templates/admin/inc/header.jsp" %>
<%@ include file="/templates/admin/inc/left-bar.jsp" %>

			<div class="bodyCat">
				<div class="title"><h2>Trang quản lý danh mục</h2></div>
				<%	String err = request.getParameter("err");
					String msg = request.getParameter("msg");
					if("1".equals(err)){
        				out.print("<span style=\"background: yellow; color: red; font-weight: bold; padding: 5px; \">ID không tồn tại - sửa thất bại </span>");
        			}
					if("1".equals(msg)){
        				out.print("<span style=\"background: yellow; color: green; font-weight: bold; padding: 5px; \">Sửa danh mục thành công </span>");
        			}
					if("1".equals(msg)){
        				out.print("<span style=\"background: yellow; color: green; font-weight: bold; padding: 5px; \">Thêm danh mục thành công </span>");
        			}
					if("2".equals(err)){
        				out.print("<span style=\"background: yellow; color: red; font-weight: bold; padding: 5px; \">Thêm danh mục thất bại </span>");
        			}
					if("3".equals(msg)){
        				out.print("<span style=\"background: yellow; color: green; font-weight: bold; padding: 5px; \">xóa danh mục thành công </span>");
        			}
					if("3".equals(err)){
        				out.print("<span style=\"background: yellow; color: red; font-weight: bold; padding: 5px; \">Xóa danh mục thất bại </span>");
        			}
        		%>
				<div class="function">
					<div class="left"><a href="<%=request.getContextPath()%>/admin/cat/add"><i class="fa fa-plus"></i>Thêm</a></div>
					<div class="right">
						<form action="" method="post"  id="form">
							<input type="text" id="name"/>
							<button type="submit" name="submit">Tìm kiếm</button>
						</form>
					</div>
					<div class="clr"></div>
				</div>
				<div class="table">
					<table>
						<tr class="title">
							<th>ID</th>
							<th>Tên danh mục</th>
							<th>Chức năng</th>
						</tr>
						<%	ArrayList<Category> categories = (ArrayList<Category>) request.getAttribute("categories");
							if(categories != null){
								for(Category item: categories){
							
						%>
						<tr class="info">
							<td><%=item.getId() %></td>
							<td><%=item.getName() %></td>
							<td>
								<a href="<%=request.getContextPath() %>/admin/cat/edit?id=<%=item.getId() %>" class="edit">Sửa </a>
								<a href="<%=request.getContextPath() %>/admin/cat/del?id=<%=item.getId() %>" class="del" onclick =" return confirm('Bạn có chắc muốn xóa ?');">Xóa </a>
							</td>
						</tr>
						<%} }else{%>
								<tr>
                       				<td colspan="3" align="center">Chưa có danh mục nào !</td>
                       			</tr>
						<%} %>
					</table>
				</div>
					<div class="page">
					<%
						int numberOfPages = (Integer) request.getAttribute("numberOfPages");
						int currentPage = (Integer) request.getAttribute("currentPage");
					%>
						<a href="<%=request.getContextPath()%>/admin/cats?page=<%=1 %>"> « </a>
						<%	if(currentPage + 1 <= numberOfPages){ //chạy từ 1-> n-1
								for(int i = currentPage -1 ; i <= currentPage + 1 ; i ++ ){
									if(i==0){i=1;}	%>
									<a class="<%if(currentPage == i ){out.print("active");} %>"  href="<%=request.getContextPath()%>/admin/cats?page=<%=i %>"> <%=i %> </a>
						<%} }else{	// đây là 2 trang cuối
								for(int i = currentPage - 1 ; i <= numberOfPages; i++){ %>
								<a class="<%if(currentPage == i ){out.print("active");} %>"  href="<%=request.getContextPath()%>/admin/cats?page=<%=i %>"> <%=i %> </a>
						<%} }%>
						<a href="<%=request.getContextPath()%>/admin/cats?page=<%=numberOfPages %>"> » </a>
					</div>		
				</div>
			<div class="clr"></div>
			<div class="footer">
				<span>Copyright 2021 © || Code by Tran Van Trinh </span>
			</div>
		</div>
	</body>
</html>