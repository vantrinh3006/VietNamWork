package controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.bean.Comment;
import model.bean.News;
import model.bean.User;
import model.dao.CommentDAO;
import model.dao.NewsDAO;
import model.dao.VoteDAO;
import util.AuthUtil;

public class PublicDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private NewsDAO NewsDAO;   
    private CommentDAO commentDAO;
    private VoteDAO voteDAO;
    public PublicDetailController() {
        super();
        NewsDAO = new NewsDAO();
        commentDAO = new CommentDAO();
        voteDAO = new VoteDAO();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html");
		
		int id = 0;
		try {
			id = Integer.parseInt(request.getParameter("id"));
		} catch (Exception e) {
			response.sendRedirect(request.getContextPath() + "/404");
			return;
		}
		News  news = NewsDAO.getItem(id);
		if(news == null) {
			response.sendRedirect(request.getContextPath() + "/404");
			return;
		}
		ArrayList<Comment> listcmt = commentDAO.getItems(id); // lấy DB
		int like = voteDAO.numberOfLikes(id);
		
		HttpSession session = request.getSession();
		User userLogin = null;
		Integer check = null ;
		if(session.getAttribute("userLogin") != null) {
			userLogin = (User)session.getAttribute("userLogin");	 
			check = voteDAO.CheckVoted(userLogin.getId(), id);
		}
		request.setAttribute("check", check);  
		request.setAttribute("listcmt", listcmt);
		request.setAttribute("news", news);
		request.setAttribute("like", like);
		request.getRequestDispatcher("/public/detail.jsp").forward(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	
	}

}
