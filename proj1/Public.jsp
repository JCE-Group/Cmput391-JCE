<!--
	This jsp file displays the top 5 images in the database, and has a display menu
	on the top that allows users to navigate to other pages
	This page also has a data button that allows admins to view statistical data from the
	database.

-->

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

		menuString += "<form action = Admin.jsp method = post style = display:inline>";
		menuString += "<input type = submit value = Data view>";
		menuString += "</form>";

		menuString += "<br>";
		
		menuString += "<form action = Search.jsp method = post >";
		menuString += "<input type = text name = search>";
		menuString += "<input type = submit value = Search>";
		menuString += "</form>";


		menuString += "<form action = LoginPage_JCE.html method = post>";
		menuString += "<input type = submit value = Logout>";
		menuString += "</form>";

		return(menuString);
	}

	public void displayImage() {

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

	<body><center>
			<font size = "5">
				<strong>
					These are the public images
				</strong>
			</font>
			<table border = "1" width="500" height = "10">
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
			try{ 
				m_con = DriverManager.getConnection(m_url, m_userName, m_password);
				stmt = m_con.createStatement();
				String views = "SELECT COUNT(user_name) FROM views GROUP BY photo_id";
				String sql ="SELECT images.photo_id FROM images LEFT JOIN views on images.photo_id = views.photo_id WHERE permitted = 1 GROUP BY images.photo_id ORDER BY count(views.photo_id) DESC";

				ResultSet resultSet = null;

				resultSet = stmt.executeQuery(sql);
				int pass = 0;
				while(resultSet.next() && pass < 5){
					++pass;
		%>
			<tr>
			<td><center>
			<a href= "/proj1/GetBigPic?big<%=resultSet.getString(1)%>" />
				<img src = "/proj1/GetOnePic?<%=resultSet.getString(1)%>" />
			</a>
			</td>
			</tr>
		<%
			}
				m_con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		%>
		</table>
    </body> 
</html> 
