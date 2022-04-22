package helloWorldServlet;

import java.io.IOException;
import utils.DB;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class HelloWorld
 */
@WebServlet("/HelloWorld")
public class HelloWorld extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DB db;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HelloWorld() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    public void init() {
    	try {
			db = new DB();
    	}
		catch (Exception e) {
			e.printStackTrace();
		}
    }
    
    public void destroy() {
    	try {
    		db.disconnectBD();
    	}
    	catch(SQLException e) {
    		e.printStackTrace();
    	}
    	
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		String query = "SELECT * FROM user";
		ResultSet results;
		init();
		try {
			String prefix = "<!DOCTYPE html>\n" +
		    		"<head>\n"+
		    		"<title> Hello World! </title>\n"+
		    		"</head>\n"+
		    		"<body>\n";
			
			results = db.executeSQL(query);
			ResultSetMetaData metadata = results.getMetaData();
			int numberOfColumns = metadata.getColumnCount();
				
			while(results.next()) {
				int i = 1;		
				while(i <= numberOfColumns){
					
				}
			}
			results.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		

		
	     /*out.println
	             ("<!DOCTYPE html>\n" +
	             "<head>\n"+
	             "<title> Hello World!2 </title>\n"+
	             "</head>\n"+
	             "<body>\n" +
	             "<h1> Hello World!2 </h1>\n" +
	             "</body>");*/
	    destroy(); 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
