<%@ page import = "java.io.*, java.util.*, java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<html>
	<head>
	Login Process<br>
	</head>
	
	<body>
		<%
			String name = request.getParameter("username");
			String pname = request.getParameter("password");
			out.println(name);
			out.println("<br>");
			out.println(pname);
		%>

	<br>
	<br>

		<%
			String m_driverName = "oracle.jdbc.driver.OracleDriver";
			String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";

			String m_userName = "peijen";
			String m_password = "z23867698";

			Connection m_con;

			Statement stmt;
			try {
				Class drvClass = Class.forName(m_driverName);
				DriverManager.registerDriver((Driver)
				drvClass.newInstance());
			} catch(Exception e) {
    		    System.err.print("ClassNotFoundException: ");
    		    System.err.println(e.getMessage());
    		}

			try{ 
				m_con = DriverManager.getConnection(m_url, m_userName, 			m_password);
				stmt = m_con.createStatement();

				String sql ="SELECT * FROM users where user_name='"+name+"' and password='"+pname+"'";

				ResultSet resultSet = null;
				resultSet = stmt.executeQuery(sql);

				if(resultSet.next()) {
					out.println("<br/><b>You are successfully login........ ");
					HttpSession sess = request.getSession();
					sess.setAttribute("username", name);		
					response.sendRedirect("Public.jsp");
					
				} else {
					out.println("<form action = LoginProcess.jsp method = post>");
					out.println("Enter your username: <br>");
					out.println("<input type = text name = username> <br>");
					out.println("Enter your password: <br>");
					out.println("<input type = text name = password>    <input type = submit name = Enter value = Enter> <br>");
					out.println("</form>");
					out.println("<font color = red> Error wrong user/pass </font>");
					out.println("<br>");
					out.println("<form action = RegisterUser_JCE.html method = post>");
					out.println("<input type = submit name = Register value = Register> <br>");
					out.println("</form>");
				}
			m_con.close();	
		} catch (Exception e) {
			e.printStackTrace();
		}
		%>

	</body>
</html>
