<%@page import="model.bean.Category"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/templates/admin/inc/header.jsp" %>
<%@ include file="/templates/admin/inc/left-bar.jsp" %>

			<div class="bodyAddCat">
				<div class="title"><h2>Sửa danh mục</h2></div>
				<%
 					Category category = (Category) request.getAttribute("category");
					String name = category.getName();
					String err = request.getParameter("err");
		        	if("1".equals(err)){
		        		out.print("<span style=\"background: yellow; color: red; font-weight: bold; padding: 5px; \">sửa danh sách thất bại </span>");
		        	}
				%>
				<div class="addForm">
					<form action="" method="post"  id="form">
						<input type="text" id="name" name="name" value="<%if(name != null) out.print(name);%>"/>
						<button type="submit" name="submit">Sửa</button>
					</form>
				</div>	
			</div>
			<div class="clr"></div>
			<div class="footer">
				<span>Copyright 2021 © || Code by Tran Van Trinh </span>
			</div>
		</div>
	</body>
</html>