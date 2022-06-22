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
@WebServlet("/GetGlobalTweets")
public class GetGlobalTweets extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetGlobalTweets() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		User user = (User) session.getAttribute("user");
		
		List<Tweet> tweets = Collections.emptyList();
		TweetService tweetService = new TweetService();
		tweets = tweetService.getGlobalTweets(0, 20);
		if (session != null && user != null) {
			for(Tweet tweet : tweets) {
				tweet.setIsLiked(tweetService.checkIfLikeExists(tweet.getId(), user.getId()));
				tweet.setIsRetweeted(tweetService.checkIfRetweetExists(tweet.getId(), user.getId()));
			}
		}
		tweetService.finalize();

		request.setAttribute("tweets", tweets);
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

