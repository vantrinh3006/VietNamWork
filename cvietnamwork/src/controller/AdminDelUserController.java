package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.bean.User;
import model.dao.UserDAO;
import util.AuthUtil;
public class AdminDelUserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private UserDAO userDAO;   
    public AdminDelUserController() {
        super();
        userDAO = new UserDAO();

    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//check login
		if(!AuthUtil.checkLogin(request, response)) {	// dùng thư viện bên util		//chưa login => chuyển đến trang login
			response.sendRedirect(request.getContextPath() + "/login?display=admin");
			return;		
		}
		
		
		int id = 0;
		try {
			id = Integer.parseInt(request.getParameter("id"));
		} catch (NumberFormatException e) {
			response.sendRedirect(request.getContextPath() + "/admin/users?err=3");
			return;
		}
		
		User user = userDAO.getItems(id);
		if (userDAO.delItem(id) > 0) {
			response.sendRedirect(request.getContextPath() + "/admin/users?msg=2");
			return;
				}else {
					response.sendRedirect(request.getContextPath() + "/admin/users?err=3");
					return;
				}
		
	}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
