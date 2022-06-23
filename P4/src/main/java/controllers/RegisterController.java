package controllers;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.TimeZone;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.converters.DateConverter;

import models.User;
import services.UserService;

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
	   UserService userService = new UserService();
	   String view = "ViewRegisterForm.jsp";
	
	   try {
		   Date defaultValue = null;
		   DateConverter converter = new DateConverter(defaultValue);
		   converter.setPattern("yyyy-MM-dd");
		   converter.setTimeZone(TimeZone.getTimeZone("UTC"));
		   ConvertUtils.register(converter, Date.class); // to convert the date from JS to a Date object.
	
		   BeanUtils.populate(user, request.getParameterMap());
		   
		   if (user.isComplete() && !userService.isUserRegistered(user)) {
			   userService.addUser(user);
			   userService.finalize();
			   view = "ViewLoginForm.jsp";
			   
			   user.destroyLoginPassword();
		   } 
		   
		   else  {
			   request.setAttribute("user",user);
			   view = "ViewRegisterForm.jsp";
		   }
	   
	   } catch (IllegalAccessException | InvocationTargetException e) {
			e.printStackTrace();
	   } catch (SQLException e) {
		   	user.setError("12", true);
		   	request.setAttribute("user",user);
		   	view = "ViewRegisterForm.jsp";
		   	e.printStackTrace();
	   }
		
	   RequestDispatcher dispatcher = request.getRequestDispatcher(view);
	   dispatcher.forward(request, response);
	   
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}
	
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
