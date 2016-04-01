
<%@ page import = "java.io.*, java.util.*, java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<html>

<%
if(request.getParameter("Register!") != null){

String Uname = (request.getParameter("username")).trim();
String pass = (request.getParameter("password")).trim();
String Fname = (request.getParameter("first_name")).trim();
String Lname = (request.getParameter("last_name")).trim();
String addr = (request.getParameter("address")).trim();
String mail = (request.getParameter("email")).trim();
String phone = (request.getParameter("phone")).trim();

		boolean condition = true;
	        //Check validaty of all items before connecting to the db
	        if(Uname.length() >24 || Uname.length()<4){
	        	condition = false;
		        out.println("<p><b>Invalid Userid</b></p>"); 
		    }
			if(pass.length() >24 || pass.length()<3){
	        	condition = false;
		        out.println("<p><b>Invalid Password</b></p>");
	   		}
	   		if(Fname.length() >24){
	        	condition = false;
	        	out.println("<p><b>Invalid Firstname</b></p>");
	   		}
	   		if(Lname.length() >24){
	        	condition = false;
		        out.println("<p><b>Invalid Lastname</b></p>");
	   		}
	   		if(addr.length() >128){
	        	condition = false;
		        out.println("<p><b>Invalid Address</b></p>");
	   		}
	   		if(mail.length() >128){
	        	condition = false;
		        out.println("<p><b>Invalid Email</b></p>");
	   		}
			if(phone.length() > 10 && phone.length()!=0){
	        	condition = false;
		        out.println("<p><b>Invalid PhoneNumber</b></p>");
	   		}
			
			if(condition){
		        boolean Leave = false;
			String m_driverName = "oracle.jdbc.driver.OracleDriver";
			String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";

			String m_userName = "peijen";
			String m_password = "z23867698";

			Connection m_con;

			Statement stmt;
			try
       			{

              			Class drvClass = Class.forName(m_driverName);
              			DriverManager.registerDriver((Driver)
              			drvClass.newInstance());
	

       			} catch(Exception e)
       			{

              			System.err.print("ClassNotFoundException: ");
             			System.err.println(e.getMessage());

       			}
			m_con = DriverManager.getConnection(m_url, m_userName,m_password);
			m_con.setAutoCommit(false);
		        ResultSet rs = null;
	        	String sql = "select u.user_name from users u, persons p where u.user_name=p.user_name and (u.user_name = '"+Uname+"'or p.email='"+mail+"')";
			stmt = m_con.createStatement();
			rs = stmt.executeQuery(sql);
			



			if(rs != null && rs.next())
		        	Leave = true;
			if(Leave)
			        out.println("<p><b>UserName/Email already Exist!</b></p>");
			else{

				sql = "insert into users values  (?, ?, sysdate)";
				PreparedStatement ps = m_con.prepareStatement(sql);
				ps.setString(1, Uname);
				ps.setString(2, pass);
				// execute insert SQL stetement
				ps.executeUpdate();
				sql ="INSERT INTO persons VALUES ('"+Uname+"','"+Fname+"','"+Lname+"','"+addr+"','"+mail+"','"+phone+"')";
				try{
					stmt=m_con.createStatement();
				rs = stmt.executeQuery(sql);
				}
				catch(Exception ex){
					out.println("<hr>" + ex.getMessage() + "<hr>");
				}
				m_con.commit();
				out.println("<p><b>Your account has been registered!</b></p>");
        			out.println("<td colspan=2>GO TO LOGIN PAGE: <a href=LoginPage_JCE.html>Login Here</a></td>");
				try{
	            		m_con.close();
	           		}
	            	catch(Exception ex){
	                	out.println("<hr>" + ex.getMessage() + "<hr>");
	           		}
			   }
			   }
}
else
{
out.println("request failed");
}

%>	

</html>
