<%@ page import = "java.io.*, java.util.*, java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%
	
	HttpSession sess = request.getSession();
	String Uname = (String)sess.getAttribute("username");

	String picid  = request.getQueryString();
	String m_driverName = "oracle.jdbc.driver.OracleDriver";
	String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
	String m_userName = "peijen";
	String m_password = "z23867698";
	Connection m_con;
	Statement stmt;
	ResultSet resultSet;
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
	} catch (Exception e) {
		e.printStackTrace();
		out.print(e);
	}
%>

<html>
	<head>
		<font size = "6"> <b>Give information on your image! </b> </font> <br>
	</head>
	<body>
		<form action = UpdateProcess.jsp method = post>
			Subject: <input type = "text" name = "sub"> <br>
			Place: <input type = "text" name = "place" > <br>
			Permissions: <br>

			<%
				try{ 
					m_con = DriverManager.getConnection(m_url, m_userName, m_password);
					m_con.setAutoCommit(false);
					stmt = m_con.createStatement();
					String sql = "SELECT group_id, group_name FROM groups WHERE group_id != 1 AND group_id != 2 and user_name ='" + Uname + "'";
					resultSet = stmt.executeQuery(sql);

				out.println("Private<input type = radio name = perm value = 2 checked  = checked> <br>");
				out.println("Public<input type = radio name = perm value = 1 ><br>");
					
					while( resultSet.next()) {
					String gname = resultSet.getString("group_name");
					String gid = resultSet.getString("group_id");
				out.println(gname + "<input type = radio name = perm value = " + gid + "> <br>");
					}
					m_con.close();
				} catch (Exception e) {
				}
			%>
			Description: <input type = "text" name = "desc" > <br>
			Date taken: <input type = "date" name = "date" > <br>
				<input type = "hidden" name = "picid" value = "<%=picid%>" > <br>
			<input type = "submit" name = "data" value = "Update Info!">
		</form>
	</body>
</html>
