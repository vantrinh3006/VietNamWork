<%@page import="model.bean.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
	<head>
		<title>VIETNAMWORK</title>
		<meta charset="UTF-8"/>
		<link href="<%=request.getContextPath()%>/templates/public/assets/css/style/style.css" rel="stylesheet" />
		<link href="<%=request.getContextPath()%>/templates/public/assets/css/reset/reset.css" rel="stylesheet" />
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/templates/public/assets/js/jquery.validate.min.js" >	</script>
		
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		
	</head>
	<style type="text/css">	 
    	#form .addContact .error {color: red}
    	#form #form .addContact label  {
    		width: auto;
    		display: block;
    		float: none;
    	}
</style>
	<body>
		<div class="wrapper">
			<div class="header">
				<div>
				<%
					String headerActive = request.getParameter("headerActive");
				%>
					<span class="logo"><a href="<%=request.getContextPath()%>/index?headerActive=1&page=1">VIETNAMWORK</a></span>
<%-- 					<span class="logo"><a href="<%=request.getContextPath()%>/headerActive-1/page-1">VIETNAMWORK</a></span> --%>
					<span class="index<%if("1".equals(headerActive)) out.print("-active");%>"><a href="<%=request.getContextPath()%>/index?headerActive=1&page=1">Trang chủ</a></span>

					<span class="contact<%if("2".equals(headerActive)) out.print("-active");%>"><a href="<%=request.getContextPath()%>/contact?headerActive=2">Liên hệ</a></span>

<%-- 						<span class="contact<%if("2".equals(headerActive)) out.print("-active");%>"><a href="<%=request.getContextPath()%>/lien-he/headerActive-2">Liên hệ</a></span> --%>
				<%
	            	User userLogin = (User) session.getAttribute("userLogin");
	            	if(userLogin != null){
         	    %>
<%-- 					<span class="login"><span><%=userLogin.getFullname() %></span><a href="<%=request.getContextPath()%>/logout?display=public">Đăng xuất</a></a></span> --%>
					
						<span class="login"><%=userLogin.getFullname() %>
							<span class="more">	
									<a href="<%=request.getContextPath()%>/public/user/info"><i class="fa fa-user"></i> Thông tin tài khoản</a>
									<a href="<%=request.getContextPath()%>/public/user/voted?user_id=<%=userLogin.getId()%>&active=0"><i class="fa fa-thumbs-up"></i> Tin đã Like</a>
									<a href="<%=request.getContextPath()%>/public/user/commented?user_id=<%=userLogin.getId()%>&active=0"><i class="fa fa-commenting"></i> Tin đã bình luận</a>
									<a href="<%=request.getContextPath()%>/logout?display=public"><i class="fa fa-sign-out"></i> Đăng xuất</a>
							</span>
						</span>	
				<%}else{ %>
					<span class="login"><span>Khách</span><a href="<%=request.getContextPath()%>/login?display=public">Đăng nhập</a></span>
				<%} %>
				
				</div>	
				<div class="image">
					<img id="img" onclick="changeImage()" src="<%=request.getContextPath() %>/templates/public/images/slide0.jpg" alt="slide" />
				</div>
				<script>
					var index = 1;
					changeImage = function(){
					var imgs = ["<%=request.getContextPath() %>/templates/public/images/slide0.jpg","<%=request.getContextPath() %>/templates/public/images/slide1.jpg","<%=request.getContextPath() %>/templates/public/images/slide2.jpg" ];
					document.getElementById('img').src = imgs[index];
					index ++;
					if(index == 3){index = 0;}
					}
					setInterval(changeImage,1500);		//1000: đơn vị mili giây
				</script>				
			</div>
			