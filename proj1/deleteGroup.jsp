<%@ page import="java.sql.*, java.util.*, java.io.*" %>
<HTML>
<HEAD>
<p><font size="10" color="Green">Delete your Group,  ${username}</font></p>
</HEAD>
<Hr>
<BODY>
<%
			HttpSession sess = request.getSession();
			String Uname = (String)sess.getAttribute("username");
			String G_id= (String)sess.getAttribute("Gr_id");
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

<font size="5"color="purple"> <b>Your Group List</b> </font>  
<br>
<form action = "delete_Group" method = "post">
<select name="Groupname">
<%
		try{ 
			m_con = DriverManager.getConnection(m_url, m_userName, m_password);
			stmt = m_con.createStatement();

			String sql ="SELECT group_name FROM groups where user_name='"+Uname+"'";
			ResultSet resultSet = null;

			resultSet = stmt.executeQuery(sql);
			while(resultSet.next()){
		%>
			

		
  		<option> <%=resultSet.getString(1) %></option>
  	

<%

}
%></select> <%
		m_con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}


%>

</table>
		

<br>
<br>
<br>
<br>
<br>

<center>

<input type = "submit" name = "deleting" value = "Delete Group">
</form>
</center>
<br>
<br>
<td colspan=2><a href=Group_List.jsp>Back To Your Group List</a></td>
<br>
<br>
<td colspan=2><a href=Public.jsp>Back to Main Page</a></td>

</BODY>

</HTML>	
