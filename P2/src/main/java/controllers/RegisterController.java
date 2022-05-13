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
		
		User model = new User();
		ManageUsers manager = new ManageUsers();

		String view = "ConstrainedValidation.jsp";
		
		try {
			Date defaultValue = null;
			DateConverter converter = new DateConverter(defaultValue);
			converter.setPattern("yyyy-mm-dd");
			ConvertUtils.register(converter, Date.class);
			
			BeanUtils.populate(model, request.getParameterMap());
			if (manager.isComplete(model) && !manager.isUserRegistered(model)) {
				manager.addUser(
						model.getName(), model.getUsername(), model.getEmail(),
						model.getPassword(), model.getGender(),  model.getUniversity(), model.getDegree(), model.getCountry(),
						model.getBirthday(), model.getPosition(), model.getImagePath(), model.getSalt());
				manager.finalize();
				view = "Registered.jsp";
			}
				
		} catch (IllegalAccessException | InvocationTargetException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		request.setAttribute("model", model);
		RequestDispatcher dispatcher = request.getRequestDispatcher(view);
		dispatcher.forward(request, response);
			
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
