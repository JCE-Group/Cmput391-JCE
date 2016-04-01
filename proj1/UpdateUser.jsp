<%@ page import = "java.io.*, java.util.*, java.sql.*, javax.servlet.*, javax.servlet.http.*" %>

<%
	String Npass = (request.getParameter("password")).trim();
	String Fname = (request.getParameter("first_name")).trim();
	String Lname = (request.getParameter("last_name")).trim();
	String addr = (request.getParameter("address")).trim();
	String email = (request.getParameter("email")).trim();
	String phoneNum = (request.getParameter("phone")).trim();
	String m_driverName = "oracle.jdbc.driver.OracleDriver";
	String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";

	String m_userName = "peijen";
	String m_password = "z23867698";

	Connection m_con;
	Statement stmt;
	HttpSession sess = request.getSession();
	String Uname = (String) sess.getAttribute("username");
	String sql = "UPDATE users SET password = '" + Npass + "' WHERE user_name = '" + Uname + "'";
	String sql2 = "UPDATE persons SET first_name = '" + Fname + "', last_name = '" + Lname + "', address = '" + addr + "', email = '" + email + "', phone = '" + phoneNum + "' WHERE user_name = '" + Uname + "'";

%>

<html>
	<head>
		<font size = "6"> <b>
<%
	if( !Uname.equals("admin")) {
		if( Fname.length() != 0 && Lname.length() != 0 && addr.length() != 0 && email.length() != 0 && phoneNum.length() != 0 && Npass.length() >= 3) {
			try{
				m_con = DriverManager.getConnection(m_url, m_userName,m_password);
				m_con.setAutoCommit(false);
				stmt = m_con.createStatement();
				stmt.executeUpdate(sql);
				stmt.executeUpdate(sql2);
				m_con.commit();
				m_con.close();			
				%>
					 <%= Uname %>, your user information has been updated!
				<%
			} catch (Exception e) {
				%>
					Something has gone wrong, please try again!
				<%
			}
		} else {
			%>
				One of the fields are not filled or the password less than three characters, please try again.
			<%
		}
		
	} else {
		%>
			Sorry Admin, you are not allowed to change information! 
		<%
	}
%>
		<br> </b> </font>
	</head>

	<body>
		<center>
			<a href = Profile.jsp> Click here to go back </a>
		</center>
	</body>
</html>
