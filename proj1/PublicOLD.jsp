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

				String sql ="SELECT photo_id FROM images WHERE permitted = 1";
				ResultSet resultSet = null;

				resultSet = stmt.executeQuery(sql);
				while(resultSet.next()){
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
