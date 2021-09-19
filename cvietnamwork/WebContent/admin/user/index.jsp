<%@page import="model.bean.User"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/templates/admin/inc/header.jsp" %>
<%@ include file="/templates/admin/inc/left-bar.jsp" %>

<div class="bodyCat">
				<div class="title"><h2>Trang quản lý người dùng</h2></div>
				<%	String err = request.getParameter("err");
					String msg = request.getParameter("msg");
					if("1".equals(err)){
        				out.print("<span style=\"background: yellow; color: red; font-weight: bold; padding: 5px; \">ID không tồn tại - Không tồn tại đối tượng </span>");
        			}
					if("2".equals(err)){
        				out.print("<span style=\"background: yellow; color: red; font-weight: bold; padding: 5px; \">Đã tồn tại username</span>");
        			}
					if("3".equals(err)){
        				out.print("<span style=\"background: yellow; color: red; font-weight: bold; padding: 5px; \">Xóa user thất bại</span>");
        			}
					if("4".equals(err)){
        				out.print("<span style=\"background: yellow; color: red; font-weight: bold; padding: 5px; \">Không tìm thấy user trên Database</span>");
        			}
					if("5".equals(err)){
        				out.print("<span style=\"background: yellow; color: red; font-weight: bold; padding: 5px; \">Sửa người dùng thất bại</span>");
        			}
					if("1".equals(msg)){
        				out.print("<span style=\"background: yellow; color: blue; font-weight: bold; padding: 5px; \">Thêm người dùng thành công </span>");
        			}
					if("2".equals(msg)){
        				out.print("<span style=\"background: yellow; color: blue; font-weight: bold; padding: 5px; \">Xóa người dùng thành công </span>");
        			}
					if("3".equals(msg)){
        				out.print("<span style=\"background: yellow; color: blue; font-weight: bold; padding: 5px; \">Sửa người dùng thành công </span>");
        			}
        		%>
				<div class="function">
					<div class="left"><a href="<%=request.getContextPath()%>/admin/user/add"><i class="fa fa-plus"></i>Thêm</a></div>
					<div class="right">
						<form action="<%=request.getContextPath()%>/admin/user/search?active=3" method="post"  id="form">
						<%	
                        	String keyWord = (String) request.getAttribute("keyWord");
                        	String value = "";
                       		 if(keyWord != null){ value = keyWord; 
                       		 }else{keyWord = "";}
                       	%>
							<input type="text" id="keyWord" name="keyWord" placeholder="Nhập username" value="<%=keyWord%>" />
							<button type="submit" name="submit">Tìm kiếm</button>
						</form>
					</div>
					<div class="clr"></div>
				</div>
				<div class="table">
					<table>
						<tr class="title">
							<th>ID</th>
							<th>UserName</th>
							<th>PassWord</th>
							<th>FullName</th>
							<th>Email</th>
							<th>Chức vụ</th>
							<th>Chức năng</th> 
						</tr>
						<%
							ArrayList<User> users = (ArrayList<User>) request.getAttribute("users");
							if(users != null && users.size() > 0){
								for(User item: users){
						%>
						<tr class="info">
							<td><%=item.getId() %></td>
							<td><%=item.getUsername() %></td>
							<td>
								<% 	 
									if(item.getId()==userLogin.getId()){  
											out.print(item.getPassword());
									}
									if("1".equals(String.valueOf(userLogin.getId())) ){	
										if(!"1".equals(String.valueOf(item.getRole().getId()))){out.print(item.getPassword()); 
										}
									}
									if("2".equals(String.valueOf(userLogin.getRole().getId())) && !"2".equals(String.valueOf(item.getRole().getId()))){	
										if(!"1".equals(String.valueOf(item.getRole().getId())) ){ 
											out.print(item.getPassword()); 
										}
									}
								%>
							</td>
							<td><%=item.getFullname() %></td>
							<td><%=item.getEmail() %></td>
							<td><%=item.getRole().getName()%></td>
							<td>
								<% 	 
									if(item.getId()==userLogin.getId() || userLogin.getRole().getId() == 1 || userLogin.getRole().getId() == 2 && item.getId() != 1){ %>
									<a href="<%=request.getContextPath() %>/admin/user/edit?id=<%=item.getId() %>" class="edit">Sửa </a>
								<% 
									}
									if("1".equals(String.valueOf(userLogin.getId())) ){	
										if(!"1".equals(String.valueOf(item.getRole().getId()))){
								%>	
									<a href="<%=request.getContextPath() %>/admin/user/del?id=<%=item.getId() %>" class="del" onclick =" return confirm('Bạn có chắc muốn xóa ?')">Xóa </a>
								<%} }%>
								
								 
								<%if("2".equals(String.valueOf(userLogin.getRole().getId())) && !"2".equals(String.valueOf(item.getRole().getId()))){	
										if(!"1".equals(String.valueOf(item.getRole().getId())) ){
								%>	
									<a href="<%=request.getContextPath() %>/admin/user/del?id=<%=item.getId() %>" class="del" onclick =" return confirm('Bạn có chắc muốn xóa ?')">Xóa </a>
								<%} }%>
							</td>
							
						</tr>
						<%}}else{ %>
									<tr class="info">
										<td colspan="7">Không có người dùng nào!</td>
									</tr>
						<%} %>
					</table>
				</div>
				<div class="page">
					<%
						int numberOfPages = (Integer) request.getAttribute("numberOfPages");
						int currentPage = (Integer) request.getAttribute("currentPage");
					%>
						<a href="<%=request.getContextPath()%>/admin/users?page=<%=1 %>"> « </a>
						<%	if(currentPage + 1 <= numberOfPages){ //chạy từ 1-> n-1
								for(int i = currentPage -1 ; i <= currentPage + 1 ; i ++ ){
									if(i==0){i=1;}	%>
									<a class="<%if(currentPage == i ){out.print("active");} %>"  href="<%=request.getContextPath()%>/admin/users?page=<%=i %>"> <%=i %> </a>
						<%} }else{	// đây là 2 trang cuối
								for(int i = currentPage - 1 ; i <= numberOfPages; i++){ %>
								<a class="<%if(currentPage == i ){out.print("active");} %>"  href="<%=request.getContextPath()%>/admin/users?page=<%=i %>"> <%=i %> </a>
						<%} }%>
						<a href="<%=request.getContextPath()%>/admin/users?page=<%=numberOfPages %>"> » </a>
				</div>		
			</div>
			<div class="clr"></div>
			<%@ include file="/templates/admin/inc/footer.jsp" %>