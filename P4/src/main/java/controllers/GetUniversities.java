package controllers;

import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.Country;
import models.Tweet;
import models.University;
import models.User;
import services.CountryService;
import services.TweetService;
import services.UniversityService;

/**
 * Servlet implementation class dTcontroller
 */
@WebServlet("/GetUniversities")
public class GetUniversities extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetUniversities() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UniversityService universityService = new UniversityService();
		List<University> universities = universityService.getUniversities();
		universityService.finalize();
		
		request.setAttribute("universities", universities);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/ViewUniversities.jsp"); 
		dispatcher.forward(request,response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

