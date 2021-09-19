package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.Category;
import model.bean.News;
import model.dao.CategoryDAO;
import model.dao.CommentDAO;
import model.dao.NewsDAO;
import model.dao.VoteDAO;
import util.AuthUtil;
import util.DefineUtil;

public class PublicUserVotedController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private VoteDAO voteDAO;
    private NewsDAO newsDAO;
    public PublicUserVotedController() {
        super();
        voteDAO = new VoteDAO();
        newsDAO = new NewsDAO();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//check login
		if(!AuthUtil.checkLogin(request, response)) {	// dùng thư viện bên util		//chưa login => chuyển đến trang login
			response.sendRedirect(request.getContextPath() + "/login?display=public");
			return;		
		}
		
		int user_id = 0;
		try {
			user_id = Integer.parseInt(request.getParameter("user_id"));
		} catch (Exception e) {
			response.sendRedirect(request.getContextPath() + "/404");							 
			return;
		}
		
		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(request.getParameter("page"));
		} catch (Exception e) {
			currentPage = 1;
		}
		
		int numberOfItems = voteDAO.numberOfItems(user_id);
		int numberOfPages = (int) Math.ceil( (float) numberOfItems / DefineUtil.NUMBER_PER_PAGE);
		
		
		if(currentPage > numberOfPages || currentPage < 1) {
			currentPage = 1;
		}
		int offset = (currentPage - 1) * DefineUtil.NUMBER_PER_PAGE;
		
		ArrayList<News> news = newsDAO.getItemsVotedByUserIdPagination(offset, user_id);
		
		request.setAttribute("numberOfPages", numberOfPages);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("news", news);
		
		request.getRequestDispatcher("/public/uservoted.jsp?active=0").forward(request, response);
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	
	}

}
