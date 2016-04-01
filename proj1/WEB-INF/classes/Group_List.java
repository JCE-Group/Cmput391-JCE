import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import oracle.sql.*;
import oracle.jdbc.*;

public class Group_List extends HttpServlet {
    public String response_message;
    public void doPost(HttpServletRequest request,HttpServletResponse response)
		throws ServletException, IOException {

	if(request.getParameter("adding")!=null){

	//HttpSession sess = request.getSession(true);
	HttpSession sess = request.getSession();
	String Uname = (String)sess.getAttribute("username");
	String Gname = request.getParameter("Groupname");
	//  change the following parameters to connect to the oracle database
	String m_username = "peijen";
	String password = "z23867698";
	String drivername = "oracle.jdbc.driver.OracleDriver";
	String dbstring ="jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
	int G_id;
	try{
	// Connect to the database and create a statement
        Connection conn = getConnected(drivername,dbstring, m_username,password);
	Connection conn2 = getConnected(drivername,dbstring, m_username,password);
	conn.setAutoCommit(false);
	conn2.setAutoCommit(false);
	Statement stmt = conn.createStatement();
	Statement stmt2 = conn2.createStatement();
	
	String sql = "select * from groups where user_name='"+Uname+"'and group_name='"+Gname+"'";
	ResultSet rs = stmt.executeQuery(sql);
	if(rs.next()){ // The group with the specified name already exists
		response_message = "The Group Name is already exist!";
	 	
	}else{// Create the group with the given name
		ResultSet rset1 = stmt.executeQuery("SELECT MAX(group_id) from groups");
		rset1.next();
		int j = rset1.getInt(1) + 1; // Group ID is the largest ID found in the database + 1
		G_id = j;
	

		stmt.execute("INSERT INTO groups VALUES("+G_id+",'"+Uname+"','"+Gname+"',sysdate)");
		conn.commit();
		stmt2.execute("Insert into group_lists values("+G_id+",'"+Uname+"',sysdate,'')");
		
		conn2.commit();
		response_message = "Your Group has been created! ";
     
		
	        conn.close();
	        conn2.close();   	

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
		"<td colspan=2> Go back to add Group: <a href = addGroup.jsp>Here</a></td>\n" +
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
		"<td colspan=2> Go back to add Group: <a href = addGroup.jsp>Here</a></td>\n" +
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
