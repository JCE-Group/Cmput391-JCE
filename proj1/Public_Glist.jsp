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

		menuString += "<form action = Group_List.jsp method = post style = text-align:center>";
		menuString += "<input type = submit value = \"Your Group List\">";
		menuString += "</form>";

		menuString += "<form action = addGroup.jsp method = post style = text-align:center>";
		menuString += "<input type = submit value = \"Add Group\">";
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
}
%>

<html>
    <head>
<style type="text/css">
		.divider{width:5px; height:auto;display:inline-block;}
</style>
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

<center><font size="10"color="purple"> <b>Public Group List</b> </font>  </center>
<br>
			<center><table border="1">
<%
		try{ 
			m_con = DriverManager.getConnection(m_url, m_userName, m_password);
			stmt = m_con.createStatement();

			String sql ="SELECT group_name FROM groups where group_id != 1 and group_id !=2";
			ResultSet resultSet = null;

			resultSet = stmt.executeQuery(sql);
			while(resultSet.next()){
		%>
			<div class="list-group">

			<tr>
			
  			<center><!--<a href="Group_Info.jsp" class="list-group-item" name="g_name">-->
			<td><font size="5"color="green"><%=resultSet.getString(1) %></font></a></td>

			<form action=Group_Info.jsp>
		       <td> <input type=submit name="button" value="go in"></td>
			<input type=hidden name="Info" value=<%= resultSet.getString(1) %>>
			</form>
		</tr>
<%

}
		m_con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}


%>
</table></center>


