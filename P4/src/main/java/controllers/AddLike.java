package controllers;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

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
@WebServlet("/AddLike")
public class AddLike extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddLike() {
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
				tweetManager.addLike(tweet.getId(), user.getId());

		} catch (IllegalAccessException | InvocationTargetException e) {
			e.printStackTrace();
		}
		tweetManager.finalize();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}