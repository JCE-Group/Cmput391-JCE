import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import oracle.sql.*;
import oracle.jdbc.*;

public class add_Friend extends HttpServlet {
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
	
	if(rs.next()){ // If a friend already exists in the group, show a message
		response_message = "The Friend already exist in your Group!";
	 	
	}else{ // If not, add them into the group by adding an entry into group_lists
		ResultSet rset1 = stmt.executeQuery("SELECT MAX(group_id) from groups");
		rset1.next();
		int j = rset1.getInt(1) + 1;
		G_id = j;
	
		
		stmt.execute("INSERT INTO group_lists VALUES("+Gr_id+",'"+Friendname+"',sysdate,'')");
		
		conn.commit();
		
		response_message = "Friend added to your group! ";
     
		
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
		"<td colspan=2> Go back to add Friend: <a href = addFriend.jsp>Here</a></td>\n" +
		"\n"+
		"<td colspan=2>GO TO Group List: <a href=Group_List.jsp>Group List</a></td>\n"+
		"</BODY></HTML>");



}else{ // Called if the name text field is left empty
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
