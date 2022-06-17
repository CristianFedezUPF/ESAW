package controllers;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
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

/**
 * Servlet implementation class AddTweetFromUser
 */
@WebServlet("/AddTweet")
public class AddTweet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddTweet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Tweet tweet = new Tweet();
		TweetService tweetManager = new TweetService();
		HttpSession session = request.getSession(false);
		User user = (User) session.getAttribute("user");
		
		try {
			
			if (session != null || user != null)
				BeanUtils.populate(tweet, request.getParameterMap());
				tweet.setUserId(user.getId());
				tweet.setUsername(user.getName());
				tweetManager.addTweet(tweet);
				tweetManager.finalize();

		} catch (IllegalAccessException | InvocationTargetException e) {
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