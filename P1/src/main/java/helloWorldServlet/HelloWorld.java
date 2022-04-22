package helloWorldServlet;

import java.io.IOException;
import utils.*;
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
		final PrintWriter writer = response.getWriter();
		String query = "SELECT * FROM user";
		ResultSet results;
		init();
		
		try {
			// initial tags
			StringBuilder output = new StringBuilder(
					String.join("\n",
							HTML.HTML_OPEN.tag(),
							HTML.HEAD_OPEN.tag(),
							HTML.TITLE_OPEN.tag(),
							"Hello world!",
							HTML.TITLE_CLOSE.tag(),
							HTML.HEAD_CLOSE.tag(),
							HTML.BODY_OPEN.tag(),
							HTML.TABLE_OPEN.tag()
					)
			);
			
			// execute query and get metadata
			results = db.executeSQL(query);
			ResultSetMetaData metadata = results.getMetaData();
			int numberOfColumns = metadata.getColumnCount();
			
			// set column names
			output.append(HTML.TABLEROW_OPEN.tag());
			for(int i = 1; i <= numberOfColumns; ++i) {
				output.append(HTML.TABLEHEADER_OPEN.tag());
				output.append(metadata.getColumnLabel(i));
				output.append(HTML.TABLEHEADER_CLOSE.tag());
			}
			output.append(HTML.TABLEROW_CLOSE.tag());
			
			// set data
			while(results.next()) {
				int i = 1;	
				output.append(HTML.TABLEROW_OPEN.tag());
				while(i <= numberOfColumns){
					output.append(HTML.TABLEDATA_OPEN.tag());
					output.append(results.getString(i++));
					output.append(HTML.TABLEDATA_CLOSE.tag());
				}
				output.append(HTML.TABLEROW_CLOSE.tag());
			}
			
			// closing tags
			output.append(
					String.join("\n",
							HTML.TABLE_CLOSE.tag(),
							HTML.BODY_CLOSE.tag(),
							HTML.HTML_CLOSE.tag()
					)
			);
			
			// display response
			writer.println(output.toString());
			
			results.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	    destroy(); 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
