import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

/**
 *  This servlet sends one picture stored in the table below to the client 
 *  who requested the servlet.
 *
 *   picture( photo_id: integer, title: varchar, place: varchar, 
 *            sm_image: blob,   image: blob )
 *
 *  The request must come with a query string as follows:
 *    GetOnePic?12:        sends the picture in sm_image with photo_id = 12
 *    GetOnePicture?big12: sends the picture in image  with photo_id = 12
 *
 *  @author  Li-Yan Yuan
 *
 */
public class GetBigPic extends HttpServlet 
    implements SingleThreadModel {

    /**
     *    This method first gets the query string indicating PHOTO_ID,
     *    and then executes the query 
     *          select image from yuan.photos where photo_id = PHOTO_ID   
     *    Finally, it sends the picture to the client
     */

    public void doGet(HttpServletRequest request,
		      HttpServletResponse response)
	throws ServletException, IOException {
	
	//  construct the query  from the client's QueryString
	String picid  = request.getQueryString();
	String query;
	
	HttpSession session = request.getSession();
	String user =(String)session.getAttribute("username");

	query = "select subject, place, description, owner_name, TO_CHAR(timing, 'YYYY/MM/DD') from images where photo_id="
	        + picid.substring(3);

	//ServletOutputStream out = response.getOutputStream();
	PrintWriter out = response.getWriter();

	/*
	 *   to execute the given query
	 */
	Connection conn = null, conn2 = null;
	try {
	    conn = getConnected();
	    conn2 = getConnected();
	    Statement stmt = conn.createStatement();
	    Statement stmt2 = conn2.createStatement();
	    
		 String view = "select * from views where photo_id = " + picid.substring(3) + " AND user_name = '" + user + "'";   
		 ResultSet ur = stmt2.executeQuery(view);
		 
		 if(!ur.next()){
		 		view = "insert into views values('" + user + "', " + picid.substring(3) + ")";
		 		Connection con3 = getConnected();
		 		Statement st3 = con3.createStatement();
		 		st3.executeQuery(view);
		 }	    
	    conn2.close();
	    
	    ResultSet rset = stmt.executeQuery(query);
	    response.setContentType("text/html");
            String title, place, desc, owner,Stime;
			Timestamp time;

	    if ( rset.next() ) {
	        title = rset.getString("subject");
	        place = rset.getString("place");
			desc = rset.getString("description");
			owner = rset.getString("owner_name");
			Stime = rset.getString(5);
			if(title == null) {
				title = "No subject";
			}
			if(place == null) {
				place = "No place";
			}
			if(desc == null) {
				desc = "No description availiable";
			}
			if(Stime == null) {
				Stime = "unknown";
			}
                out.println("<html><head><title>"+title+ "</title>+</head>" +
	                 "<body bgcolor=\"#000000\" text=\"#cccccc\">" +
		 "<center><img src = \"/proj1/GetOnePic?big"+ picid.substring(3)+ "\"/>" +
			 "<h3>" + title + "  at " + place + " </h3> <br>" + desc + "<br>" +
			"Taken on " + Stime + " by " + owner + "</body></html>");
		}
	    else
	      out.println("<html> Pictures are not avialable</html>");
	} catch( Exception ex ) {
	    out.println(ex.getMessage() );
	}
	// to close the connection
	finally {
	    try {
		conn.close();
	    } catch ( SQLException ex) {
		out.println( ex.getMessage() );
	    }
	}
    }

    /*
     *   Connect to the specified database
     */
    private Connection getConnected() throws Exception {

	String username = "peijen";
	String password = "z23867698";

        /* one may replace the following for the specified database */
	String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
	String driverName = "oracle.jdbc.driver.OracleDriver";

	/*
	 *  to connect to the database
	 */
	Class drvClass = Class.forName(driverName); 
	DriverManager.registerDriver((Driver) drvClass.newInstance());
	return( DriverManager.getConnection(dbstring,username,password) );
    }
}
