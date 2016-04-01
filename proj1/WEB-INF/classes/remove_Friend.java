import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import oracle.sql.*;
import oracle.jdbc.*;

public class remove_Friend extends HttpServlet {
    public String response_message;
    public void doPost(HttpServletRequest request,HttpServletResponse response)
		throws ServletException, IOException {

	if(request.getParameter("adding")!=null){

	//HttpSession sess = request.getSession(true);
	HttpSession sess = request.getSession();
	String Uname = (String)sess.getAttribute("username");
	String Grname = (String)sess.getAttribute("Gr_name");
	String Gr_id =  (String)sess.getAttribute("Gr_id");
	String Friendname = request.getParameter("Friendname");
	//  change the following parameters to connect to the oracle database
	String m_username = "peijen";
	String password = "z23867698";
	String drivername = "oracle.jdbc.driver.OracleDriver";
	String dbstring ="jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
	int G_id;
	try{
	// Connect to the database and create a statement
        Connection conn = getConnected(drivername,dbstring, m_username,password);
	
	conn.setAutoCommit(false);
	
	Statement stmt = conn.createStatement();
	
	
	String sql = "select * from group_lists where group_id='"+Gr_id+"'and friend_id='"+Friendname+"'";
	
	ResultSet rs = stmt.executeQuery(sql);
	if(rs.next()){ // Specified user is in the group
		stmt.execute("delete from group_lists where friend_id='"+Friendname+"'");
		
		conn.commit();
	
		response_message = "Fk yaaa!! Friend removed ";
	 	
	}else{ // The specified username is not associated with the group
		
		response_message = "person do not exist in your Group.";
	
		
	        conn.close();
	           	

        }
	}catch( Exception ex ) {
	    //System.out.println( ex.getMessage());
	    response_message = ex.getMessage();
	}


	response.setContentType("text/html");
	PrintWriter out = response.getWriter();
	out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 " +
		"Transitional//EN\">\n" +
		"<HTML>\n" +
		"<HEAD><TITLE>Upload Message</TITLE></HEAD>\n" +
		"<BODY>\n" +
		"<H1>" +
	        response_message +
		"</H1>\n" +
		"<td colspan=2> Go back to remove Friend: <a href = removeFriend.jsp>Here</a></td>\n" +
		"\n"+
		"<td colspan=2>GO TO Group List: <a href=Group_List.jsp>Group List</a></td>\n"+
		"</BODY></HTML>");



}else{ // Empty text field
	response_message = "Please Don't leave the name field empty!";
	response.setContentType("text/html");
	PrintWriter out = response.getWriter();
	out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 " +
		"Transitional//EN\">\n" +
		"<HTML>\n" +
		"<HEAD><TITLE>Upload Message</TITLE></HEAD>\n" +
		"<BODY>\n" +
		"<H1>" +
	        response_message +
		"</H1>\n" +
		"<td colspan=2> Go back to add More Friend: <a href = addFriend.jsp>Here</a></td>\n" +
		"</BODY></HTML>");
}

}

  /*
    /*   To connect to the specified database
     */
    private static Connection getConnected( String drivername,
					    String dbstring,
					    String username, 
					    String password  ) 
	throws Exception {
	Class drvClass = Class.forName(drivername); 
	DriverManager.registerDriver((Driver) drvClass.newInstance());
	return( DriverManager.getConnection(dbstring,username,password));
	} 
} 
