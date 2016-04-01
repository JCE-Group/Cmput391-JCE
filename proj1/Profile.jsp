<%@ page import="java.sql.*, java.util.*, java.io.*" %>
<%!
public class Display {

	public String displayMenu() {

		String menuString = "";
		menuString += "<form action = Profile.jsp method = post style = display:inline>";
		menuString += "<input type = submit value = Profile>";
		menuString += "</form>";

		menuString += "<form action = Private.jsp method = post style = display:inline>";
		menuString += "<input type = submit value = \"Your Images\">";
		menuString += "</form>";

		menuString += "<form action = Public_Glist.jsp method = post style = display:inline>";
		menuString += "<input type = submit value = Groups>";
		menuString += "</form>";
		
		menuString += "<form action = Public.jsp method = post style = display:inline>";
		menuString += "<input type = submit value = Public>";
		menuString += "</form>";

		menuString += "<br>";
		
		menuString += "<form action = Search.jsp method = post >";
		menuString += "<input type = text name = search>";
		menuString += "<input type = submit value = Search>";
		menuString += "</form>";


		menuString += "<form action = LoginPage_JCE.html method = post>";
		menuString += "<input type = submit value = Logout>";
		menuString += "</form>";

		menuString += "<center>";
		menuString += "<form action = UpdateUser.html method = post>";
		menuString += "<input type = submit value = \"Update User Information\"/>";
		menuString += "</form>";
		menuString += "</center>";
		return(menuString);
	}
}
%>

<html>
    <head>
		Welcome!
		${username}
		<%
			out.print("<br>");
			Display display = new Display(); 
			out.print(display.displayMenu());
		%> <br>
	</head>

	<body>
		<%
			HttpSession sess = request.getSession();

			String id = request.getParameter("m_userName");
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
		%>

		<h2 align="center">
			<font>
				<strong>
					This is your profile
				</strong>
			</font>
		</h2>
		<table align="center" cellpadding="6" cellspacing="6" border="1">

		<tr bgcolor = "green">
			<td> <b> Username </b> </td>
			<td> <b> First Name </b> </td>
			<td> <b> Last Name </b> </td>
			<td> <b> Address </b> </td>
			<td> <b> Email </b> </td>
			<td> <b> Phone </b> </td>
		</tr>

		<%
		try{ 
			m_con = DriverManager.getConnection(m_url, m_userName, m_password);
			stmt = m_con.createStatement();

			String sql ="SELECT * FROM persons WHERE user_name = \'"+ sess.getAttribute("username")+"\'";
			ResultSet resultSet = null;

			resultSet = stmt.executeQuery(sql);
			while(resultSet.next()){
		%>

		<tr bgcolor="#DEB887">

			<td><%=resultSet.getString("user_name") %></td>
			<td><%=resultSet.getString("first_name") %></td>
			<td><%=resultSet.getString("last_name") %></td>
			<td><%=resultSet.getString("address") %></td>
			<td><%=resultSet.getString("email") %></td>
			<td><%=resultSet.getString("phone") %></td>
		</tr>

		<%
		}
			m_con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		%>

    </body> 
</html> 
