package controllers;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.FilterChain;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.Tweet;
import models.User;
import services.TweetService;
import services.UserService;

/**
 * Servlet implementation class GetUserInfo
 */
@WebServlet("/GetProfileInfo/*")
public class GetProfileInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetProfileInfo() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		User user = (User) session.getAttribute("user");

		String pathInfo = request.getPathInfo();
		Long profileId = Long.valueOf(pathInfo.substring(1));
		
		
		UserService userService = new UserService();
		
		if(user != null) {
			boolean isUserFollowing = userService.isUserFollowingUser(user.getId(), profileId);
			request.setAttribute("is_user_following", isUserFollowing);
		} else {
			request.setAttribute("is_anonymous_user", true);
		}

		User profile = userService.getUser(profileId);
		
		request.setAttribute("profile", profile);
		response.setContentType("text/html; charset=UTF-8");
		RequestDispatcher dispatcher = request.getRequestDispatcher("/ViewProfile.jsp"); 
		dispatcher.include(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
