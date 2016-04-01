<%@ page import = "java.io.*, java.util.*, java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%
String subject = request.getParameter("sub");
String place = request.getParameter("place");
String perm = request.getParameter("perm");
String desc = request.getParameter("desc");
String date = request.getParameter("date");
String picid = request.getParameter("picid");

String message = "An error has occurred";
HttpSession sess = request.getSession();
String name = (String) sess.getAttribute("username");

if (subject.equals("")) {
	subject = "null";
} else {
	subject = "'" + subject + "'";
}

if (place.equals("")) {
	place = "null";
} else {
	place = "'" + place + "'";
}

if (desc.equals("")) {
	desc = "null";
} else {
	desc = "'" + desc + "'";
}

if (date.equals("")) {
	date = "null";
} else {
	date = "TO_DATE('" + date + "', 'YYYY/MM/DD')";
}

String sql = "UPDATE images SET subject = " + subject + ", place = " + place + ", description = " + desc + ", timing = " + date + ", permitted = " + perm + " WHERE photo_id = "+ picid;

String m_driverName = "oracle.jdbc.driver.OracleDriver";
String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
String m_userName = "peijen";
String m_password = "z23867698";
Connection m_con;
Statement stmt;
%>
<html>
	<head>
			<font size = "5"> <b> Update process! </b> </font> <br>
	</head>

	<body>
		<%
			try {
            	Class drvClass = Class.forName(m_driverName);
            	DriverManager.registerDriver((Driver)
              	drvClass.newInstance());

			} catch(Exception e) {
				System.err.print("ClassNotFoundException: ");
				System.err.println(e.getMessage());
			}

			try{ 
				m_con = DriverManager.getConnection(m_url, m_userName, m_password);
				m_con.setAutoCommit(false);
				stmt = m_con.createStatement();


				stmt.executeUpdate(sql);
				message = "Successful update!";
				m_con.commit();
				m_con.close();
			} catch (Exception e) {
				e.printStackTrace();
				out.print(e);
		}


		%>
		<%= message %> <br>
		<a href = Private.jsp> Click here to return </a>
		
	</body>
</html>
