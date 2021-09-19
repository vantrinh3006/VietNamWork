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
import model.dao.NewsDAO;
import util.DefineUtil;

public class PublicCatController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private CategoryDAO categoryDAO;
    private NewsDAO newsDAO;
    public PublicCatController() {
        super();
        categoryDAO = new CategoryDAO();
        newsDAO = new NewsDAO();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int cat_id = 0;
		try {
			cat_id = Integer.parseInt(request.getParameter("cat_id"));
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
		
		Category category = categoryDAO.getItem(cat_id);
		if(category == null) {
			response.sendRedirect(request.getContextPath() +"/404");							 
			return;
		}
		int numberOfItems = newsDAO.numberOfItems(cat_id);
		int numberOfPages = (int) Math.ceil( (float) numberOfItems / DefineUtil.NUMBER_PER_PAGE);
		
		
		if(currentPage > numberOfPages || currentPage < 1) {
			currentPage = 1;
		}
		int offset = (currentPage - 1) * DefineUtil.NUMBER_PER_PAGE;
		
		ArrayList<News> news = newsDAO.getItemsByCategoryPagination(offset, cat_id);

		request.setAttribute("numberOfPages", numberOfPages);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("category", category);
		request.setAttribute("news", news);
		
		request.getRequestDispatcher("/public/cat.jsp").forward(request, response);
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	
	}

}
