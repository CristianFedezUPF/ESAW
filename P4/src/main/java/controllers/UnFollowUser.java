package controllers;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;

import models.User;
import services.UserService;

/**
 * Servlet implementation class UnFollowUser
 */
@WebServlet("/UnFollowUser")
public class UnFollowUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UnFollowUser() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		User fuser = new User();
		UserService userManager = new UserService();
		HttpSession session = request.getSession(false);
		User user = (User) session.getAttribute("user");
		
		try {
			
			if (session != null || user != null)
				BeanUtils.populate(fuser, request.getParameterMap());
				userManager.unfollowUser(user.getId(),fuser.getId());
				userManager.finalize();

		} catch (IllegalAccessException | InvocationTargetException e) {
			e.printStackTrace();
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
