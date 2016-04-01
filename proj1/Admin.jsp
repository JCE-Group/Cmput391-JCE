<%@ page import="java.sql.*, java.util.*, java.io.*" %>

<html>
	<head>
		<font size = "5"> <b> Hello ${username} </b> </font> 
		<br>
		<br>
	</head>

<%
	HttpSession sess = request.getSession();

	String id = request.getParameter("m_userName");
	String m_driverName = "oracle.jdbc.driver.OracleDriver";
	String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
	String m_userName = "peijen";
	String m_password = "z23867698";

	String uname = (String) sess.getAttribute("username");
	
	if(uname.equals("admin")){	
	
	Connection con, con2;
	Statement stmt, stmt2;
	
	try{
		con = DriverManager.getConnection(m_url, m_userName, m_password); 
		stmt = con.createStatement();
		ResultSet rs, rt;
		
		String usql = "select u.user_name, count(*) from images i right join users u on i.owner_name = u.user_name group by u.user_name";
		String ssql = "select subject, count(*) from images i group by subject";
		
		rs = stmt.executeQuery(usql);
		
		%>
		
	

	<body>
		<center>
			<b> Number of images uploaded per user </b>
			<table border = "2">
				<tr>
					<td> Username </td>
					<td> Images uploaded </td>	
				</tr>
				<% while(rs.next()){ %>
				<!-- While loop here -->
				<tr>
					<td> <%=rs.getString(1)%></td>
					<td> <%=rs.getInt(2)%> </td>
				<tr>
				<%}%>
			</table>
			
<%			con.close();
			con2 = DriverManager.getConnection(m_url, m_userName, m_password);
			stmt2 = con2.createStatement();
			
			rt = stmt2.executeQuery(ssql);
			
%>		

			<br>
			<b> Number of images uploaded per subject </b>
			<table border = "2">
				<tr>	
					<td> Subject </td>
					<td> Images uploaded </td>
				</tr>

<%				while(rt.next()){ %>
				<!-- While loop here -->
				<tr>
					<td> <%=rt.getString(1)%></td>
					<td> <%=rt.getInt(2)%> </td>
				</tr>
			<%}%>
			</table>
			<form action = AdminRollup.jsp>
			<input type = submit value = Rollup Information>
			</form>
	<%			
			}
		catch (Exception e){
		e.printStackTrace();
	}	
	}
	else{
	%>
		<center>
		Sorry, this page is only accessible to administrators.
	<%}%>
	</body>
</html>
