package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AuthLogoutController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AuthLogoutController() {
        super();

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		session.invalidate();	// xóa tất cả các session
								// cách 2 :  session.removeAttribute("userLogin");
		String display = request.getParameter("display");
		if("admin".equals(display)) {
			response.sendRedirect(request.getContextPath() + "/login?display=admin");
			return;
		}else {
			response.sendRedirect(request.getContextPath() + "/login?display=public");
			return;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	
	}

}
