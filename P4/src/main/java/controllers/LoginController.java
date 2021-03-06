package controllers;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang3.tuple.Pair;

import models.User;
import services.UserService;

/**
 * Servlet implementation class LoginController
 */
@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginController() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		User user = new User();
		UserService userService = new UserService();
		String view = "ViewLoginForm.jsp";
		Pair<Boolean,User> pair = null;
		
	    try {
			
	    	BeanUtils.populate(user, request.getParameterMap());
			
	    	if (user.isLoginComplete() && userService.isUserRegistered(user) && userService.isPasswordCorrect(user) ) {
	    		
	    		pair = userService.getUserByUsername(user); //will always find the user as we have checked it is correct
	    		
    			HttpSession session = request.getSession();
    			session.setAttribute("user",pair.getRight());
    			view = "ViewCustomTimeline.jsp";
	    		
	    		if (pair.getLeft()) {
	    			session.setAttribute("user",pair.getRight());
	    			view = "ViewMainPage.jsp";
	    			
	    		}
	    		else {
	    			request.setAttribute("error", true);
					request.setAttribute("user",user);
				}

		    } 
	    	else {
				request.setAttribute("user",user);
	    	}
	    	
	    	RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			dispatcher.forward(request, response);
		    
		} catch (IllegalAccessException | InvocationTargetException | NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (SQLException e) {
		   	user.setError("12", true);
		   	request.setAttribute("user",user);
		   	view = "ViewRegisterForm.jsp";
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

