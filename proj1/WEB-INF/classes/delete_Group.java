import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import oracle.sql.*;
import oracle.jdbc.*;

public class delete_Group extends HttpServlet {
    public String response_message;
    public void doPost(HttpServletRequest request,HttpServletResponse response)
		throws ServletException, IOException {
	
	if(request.getParameter("Groupname")!=null){
    	PrintWriter out = response.getWriter();
    	//HttpSession sess = request.getSession(true);
    	HttpSession sess = request.getSession();
    	String Uname = (String)sess.getAttribute("username");
    	String Grname = (String)request.getParameter("Groupname");
    	//String Gr_id =  (String)sess.getAttribute("Gr_id");
    
    	//  change the following parameters to connect to the oracle database
    	String m_username = "peijen";
    	String password = "z23867698";
    	String drivername = "oracle.jdbc.driver.OracleDriver";
    	String dbstring ="jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";

    	try{
        	// Connect to the database and create a statement
                Connection conn = getConnected(drivername,dbstring, m_username,password);
        	Connection conn2 = getConnected(drivername,dbstring, m_username,password);
        	Connection conn3 = getConnected(drivername,dbstring, m_username,password);
        	conn.setAutoCommit(false);
        	conn2.setAutoCommit(false);
        	conn3.setAutoCommit(false);
        	Statement stmt = conn.createStatement();
        	Statement stmt2 = conn2.createStatement();
        	Statement stmt3 = conn3.createStatement();
        	
        	String sql = "select group_id from groups where group_name = '"+ Grname +"'and user_name='"+Uname+"'";
        	ResultSet rs = stmt.executeQuery(sql);
        	if(rs.next()){
            	String sql2 = "select photo_id from images where permitted ="+rs.getString(1)+"";
            	String sql3 = "select * from group_lists where group_id ="+rs.getString(1)+"";
            	
            
            	// if the group exist	  
            	
            	ResultSet rs2 = stmt2.executeQuery(sql2);
            	if(rs2.next()){ // change images with permission set to a group to private
            	stmt2.executeUpdate("update images set permitted = 2 where permitted="+rs.getString(1)+"");
            		
            	conn2.commit();
        	}
        	conn2.close();
        
        	ResultSet rs3 = stmt3.executeQuery(sql3);
        	if(rs3.next()){
            	//delete group members
            	stmt3.execute("delete from group_lists where group_id="+rs.getString(1)+"");
            	conn3.commit();
        	}
    	    conn3.close();
    	
    	
        	//delete the group	
        	stmt.execute("delete from groups where group_id="+rs.getString(1)+"");
        	conn.commit();
        	
        	
        	
        	conn.close();
        	response_message = "Fk yaaa!! Group removed ";
    		
    	 	
    	    }
    	    else{
    		    response_message = "Group name does not exist/fail to remove.";
            }
    	
    	}catch( Exception ex ) {
    	    //System.out.println( ex.getMessage());
    	    response_message = ex.getMessage();
    	}
    
    
    	response.setContentType("text/html");
    	out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 " +
    		"Transitional//EN\">\n" +
    		"<HTML>\n" +
    		"<HEAD><TITLE>Upload Message</TITLE></HEAD>\n" +
    		"<BODY>\n" +
    		"<H1>" +
    	        response_message +
    		"</H1>\n" +
    		"<td colspan=2> Go back to remove Group: <a href = deleteGroup.jsp>Here</a></td>\n" +
    		"\n"+
    		"<td colspan=2>GO TO Public Group List: <a href=Public_Glist.jsp>Public Group List</a></td>\n"+
    		"</BODY></HTML>");
    }
    else{
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
    		"<td colspan=2> Go back to remove Group: <a href = deleteGroup.jsp>Here</a></td>\n" +
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
