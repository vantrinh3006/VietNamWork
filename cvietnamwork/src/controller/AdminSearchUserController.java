package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.User;
import model.dao.UserDAO;
import util.AuthUtil;
import util.DefineUtil;

public class AdminSearchUserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO;
       
    public AdminSearchUserController() {
        super();
        userDAO = new UserDAO();
      }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		//check login
		if(!AuthUtil.checkLogin(request, response)) {	// dùng thư viện bên util		//chưa login => chuyển đến trang login
			response.sendRedirect(request.getContextPath() + "/login?display=admin");
			return;		
		}
		
		int currentPage = 1;
		try {
			//ở đây em get parameter là page
			currentPage = Integer.parseInt(request.getParameter("page"));	 
		} catch (Exception e) {
			currentPage = 1;
		}
		String keyWord = request.getParameter("keyWord");		 
		int numberOfUsers = userDAO.numberOfItems(keyWord);		 
		int numberOfPages = (int) Math.ceil((float) numberOfUsers / DefineUtil.NUMBER_PER_PAGE);	
		if (currentPage > numberOfPages || currentPage < 1) {
			currentPage = 1;
		}
		int offset = (currentPage -1) * DefineUtil.NUMBER_PER_PAGE;
				
		ArrayList<User> users = userDAO.getItemsPagination(offset,keyWord);	
		request.setAttribute("numberOfUsers", numberOfUsers);
		request.setAttribute("numberOfPages", numberOfPages);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("users", users);
		request.setAttribute("keyWord", keyWord);
		request.getRequestDispatcher("/admin/user/index.jsp?active=3").forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
