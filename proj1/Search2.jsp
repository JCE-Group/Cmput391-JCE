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
		Welcome!
		${username}
		<%
			out.print("<br>");
			Display display = new Display(); 
			out.print(display.displayMenu());
			String keys = request.getParameter("search2k");
			String keylist[] = keys.split("\\s+");

			String mindate = request.getParameter("minDate");
			String maxdate = request.getParameter("maxDate");
			String order = request.getParameter("order");
			String o = "";
			if(Integer.parseInt(order) == 1)
				o = "most recent first";
			else
				o = "least recent first";

		%> <br>
		<center>
			<form action = Search2.jsp>
				Min date: <input type = "date" value = <%=mindate%> name = "minDate" > 
				Max date: <input type = "date" value = <%=maxdate%> name = "maxDate" >
				Keywords: <input type = "text" value = "<%=keys%>" name = "search2k">;
			<br> 	Most Recent<input type = radio name = order value = 1 checked  = checked>
				Least Recent<input type = radio name = order value = 2>
				<input type  = "submit" name = "search2" value = "Search Date">
			</form>
		</center>
	</head>

	<body><center>
		<font size = "5">
			<strong>
				Search results for '<%=keys%>' between <%=mindate%> and <%=maxdate%>, <%=o%>.
			</strong>
		</font>

		<table border = "1" width = 500 height = 10>
	<%
	HttpSession sess = request.getSession();

	String id = request.getParameter("m_userName");
	String m_driverName = "oracle.jdbc.driver.OracleDriver";
	String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
	String m_userName = "peijen";
	String m_password = "z23867698";

	String uname = (String) sess.getAttribute("username");

	Connection m_con, g_con;
	Statement stmt, stmt2;	

	try{
		m_con = DriverManager.getConnection(m_url, m_userName, m_password);
		g_con = DriverManager.getConnection(m_url, m_userName, m_password);
		stmt = m_con.createStatement();
		stmt2 = g_con.createStatement();

		ResultSet rs, rt;

		String sql = "SELECT * FROM images i WHERE timing >= TO_DATE(\'" + mindate + "\', \'YYYY/MM/DD\') AND timing <= TO_DATE(\'" + maxdate + "\', \'YYYY/MM/DD\') AND (i.permitted = 1";
			
		String sql2 = "SELECT group_id FROM groups g WHERE g.user_name = '" + uname + "'";
		
		// Grab all groups which the current user is a part of
		rt = stmt2.executeQuery(sql2);
		
		while(rt.next()){
			// For every group the user is in, add in a group id
			sql = sql + " OR i.permitted = " + rt.getInt(1);
		}
		g_con.close();
		
		sql = sql + ")";

		for(int i = 0; i<keylist.length; ++i){
			sql = sql + " AND (UPPER(i.description) LIKE '%" + keylist[i].toUpperCase() + "%' OR UPPER(i.subject) LIKE '%" + keylist[i].toUpperCase() + "%' OR UPPER(i.place) LIKE '%" + keylist[i].toUpperCase() + "%')";
		}

		if(Integer.parseInt(order) == 1)
			sql = sql + " ORDER BY timing DESC";
		
		else
			sql = sql + " ORDER BY timing";

		rs = stmt.executeQuery(sql);

		while(rs.next()){
		
	%>
	<tr>
	<td><center>
	<a href= "/proj1/GetBigPic?big<%=rs.getString("photo_id")%>" />
	<img src = "/proj1/GetOnePic?<%=rs.getString("photo_id")%>" />
	</a>
	</td>
	</tr>
	<%
		}
		m_con.close();	
	}
	catch (Exception e){
		e.printStackTrace();
	}

	%>
	</table> </center>
	</body>
</html>
