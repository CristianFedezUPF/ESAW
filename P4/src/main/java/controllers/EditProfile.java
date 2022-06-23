package controllers;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;

import models.Tweet;
import models.User;
import services.TweetService;
import services.UserService;

/**
 * Servlet implementation class AddTweetFromUser
 */
@WebServlet("/EditProfile")
public class EditProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditProfile() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		User profileUser = new User();
		UserService userService = new UserService();
		
		HttpSession session = request.getSession(false);
		User user = (User) session.getAttribute("user");
		
		try {
			if (session != null || user != null)
				BeanUtils.populate(profileUser, request.getParameterMap());
				if(!profileUser.isEditComplete()) {
					response.sendError(400, "Invalid request");
				}
				else if(userService.isNewUsernameUsed(profileUser, profileUser.getUsername())) {
					response.sendError(409, "Username is already in use");
				}
				else if((user.getId().equals(profileUser.getId())) || user.getIsAdmin()) {
					userService.editUser(profileUser);
					if(user.getId().equals(profileUser.getId())) {
						user.setName(profileUser.getName());
						user.setUsername(profileUser.getUsername());
					}
				}
			userService.finalize();
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch(Exception e) {
			response.sendError(500, "There was an unexpected error with your request");
			e.printStackTrace();
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}