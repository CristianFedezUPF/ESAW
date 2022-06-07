package controllers;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.Date;

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

	   System.out.print("RegisterController: ");
	   User user = new User();
	   UserService userService = new UserService();
	   boolean cn = false;
	   boolean cm = false;
	
	   try {
		   Date defaultValue = null;
		   DateConverter converter = new DateConverter(defaultValue);
		   converter.setPattern("yyyy-mm-dd");
		   ConvertUtils.register(converter, Date.class); // to convert the date from JS to a Date object.
	
		   BeanUtils.populate(user, request.getParameterMap());
		   
		   cn = userService.checkUser(user.getName());
		   cm = userService.checkEmail(user.getEmail());
		   
		   
		   // TODO THIS ON USER CLASS
		   //user.setError("user", cn);
		   //user.setError("mail", cm);
		   
		   if (userService.isComplete(user) && !cn && !cm) {
			   
			   userService.addUser(user);
			   userService.finalize();
			   System.out.println(" user ok, forwarding to ViewLoginForm.");
			   RequestDispatcher dispatcher = request.getRequestDispatcher("ViewLoginForm.jsp");
			   dispatcher.forward(request, response);
		   
		   } 
		   
		   else  {
		
			   System.out.println(" forwarding to ViewRegisterForm.");
			   request.setAttribute("user",user);
			   RequestDispatcher dispatcher = request.getRequestDispatcher("ViewRegisterForm.jsp");
			   dispatcher.forward(request, response);
		   }
	   
	   } catch (IllegalAccessException | InvocationTargetException e) {
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
	
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}
	
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
