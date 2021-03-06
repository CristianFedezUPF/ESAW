package controllers;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

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

/**
 * Servlet implementation class dTcontroller
 */
@WebServlet("/GetUserTweets/*")
public class GetUserTweets extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetUserTweets() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String pathInfo = request.getPathInfo();
		Long userId = Long.valueOf(pathInfo.substring(1));
		List<Tweet> tweets = Collections.emptyList();
		
		HttpSession session = request.getSession(false);
		User sessionUser = (User) session.getAttribute("user");
		
		TweetService tweetService = new TweetService();
		tweets = tweetService.getUserTweets(userId,0,10);
		if (session != null && sessionUser != null) {
			for(Tweet tweet : tweets) {
				tweet.setIsLiked(tweetService.checkIfLikeExists(tweet.getId(), sessionUser.getId()));
				tweet.setIsRetweeted(tweetService.checkIfRetweetExists(tweet.getId(), sessionUser.getId()));
			}
		}
		tweetService.finalize();
		
		request.setAttribute("tweets",tweets);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/ViewTweets.jsp"); 
		dispatcher.forward(request,response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

