package controllers;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.Date;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.converters.DateConverter;

import managers.ManageUsers;
import models.User;

/**
 * Servlet implementation class FormController
 */
@WebServlet("/RegisterController")
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterController() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = new User();
		System.out.print("RegisterController: ");
		ManageUsers manager = new ManageUsers();
		String view = "ViewRegisterForm.jsp";

	   try {
	
		   Date defaultValue = null;
		   DateConverter converter = new DateConverter(defaultValue);
		   converter.setPattern("yyyy-mm-dd");
		   ConvertUtils.register(converter, Date.class); // to convert the date from JS to a Date object.
		   
		   BeanUtils.populate(user, request.getParameterMap());
		   if (manager.isComplete(user) && !manager.isUserRegistered(user)) {
			   manager.addUser(
						user.getName(), user.getUsername(), user.getEmail(),
						user.getPassword(), user.getGender(),  user.getUniversity(), user.getDegree(), user.getCountry(),
						user.getBirthday(), user.getPosition(), user.getImagePath(), user.getSalt());
				manager.finalize();
			   System.out.println(" user ok, forwarding to ViewLoginForm");
			   view = "ViewLoginForm.jsp";
		   
		   } 
		   else {
			   System.out.println(" forwarding to ViewRegisterForm");
		   }
	   
	   } catch (IllegalAccessException | InvocationTargetException | SQLException e) {
			e.printStackTrace();
	   } 
	   request.setAttribute("user", user);
	   RequestDispatcher dispatcher = request.getRequestDispatcher(view);
	   dispatcher.forward(request, response);		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
