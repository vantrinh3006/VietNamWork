package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.Category;
import model.bean.Comment;
import model.dao.CategoryDAO;
import model.dao.CommentDAO;
import util.AuthUtil;
import util.DefineUtil;

public class AdminIndexCommentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CommentDAO commentDAO;	  
    public AdminIndexCommentController() {
        super();
        commentDAO = new CommentDAO();

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
			currentPage = Integer.parseInt(request.getParameter("page")) ;
		} catch (NumberFormatException e) {
			currentPage = 1;
		}
		int numberOfComments = commentDAO.numberOfItems(); 
		int numberOfPages = (int) Math.ceil((float) numberOfComments / DefineUtil.NUMBER_PER_PAGE);
		if (currentPage < 1) {
			currentPage = 1;
		}
		int offset = (currentPage - 1) * DefineUtil.NUMBER_PER_PAGE;
		
		ArrayList<Comment> comments = commentDAO.getItemsPagination(offset);
		
		request.setAttribute("numberOfComments", numberOfComments);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("numberOfPages", numberOfPages);
		request.setAttribute("comments", comments);
		
		request.getRequestDispatcher("/admin/comment/index.jsp?active=6").forward(request, response);
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
