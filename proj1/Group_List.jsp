<!-- This page will display groups the user belongs to.
		It will seperate groups which the user has created,
		and groups which the user has joined.

	Here the user can choose to view the group information.

	This file was created by the JCE group.
-->


<%@ page import="java.sql.*, java.util.*, java.io.*" %>
<p><font size="10" color="Green">Your Group List,  ${username}</font></p>
<br>
<html>

<%
HttpSession sess = request.getSession();
String Uname = (String)sess.getAttribute("username");


String m_driverName = "oracle.jdbc.driver.OracleDriver";
String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";

String m_userName = "peijen";
String m_password = "z23867698";

Connection m_con;
Connection g_con;
Statement stmt;
Statement stmt2;
try {
	Class drvClass = Class.forName(m_driverName);
	DriverManager.registerDriver((Driver)
	drvClass.newInstance());
} catch(Exception e) {
    	System.err.print("ClassNotFoundException: ");
    	System.err.println(e.getMessage());
    }

try{ 
	m_con = DriverManager.getConnection(m_url, m_userName, 	m_password);
	g_con = DriverManager.getConnection(m_url, m_userName, 	m_password);
	stmt = m_con.createStatement();
	stmt2 = g_con.createStatement();
	String sql ="SELECT group_name  FROM groups where user_name='"+Uname+"'";
	String sql2 ="select g.group_name from groups g, group_lists gl where g.group_id=gl.group_id and gl.friend_id = '"+Uname+"'";
	ResultSet rs = null;
	rs = stmt.executeQuery(sql);


%>
<TABLE BORDER="1">
            
<b>Group you have created: </b> 
<br>          
<center><table border="1">              
<% while(rs.next()){ %>
        
   <!--  <form action=Group_Info.jsp>
		  <input type=submit name="Info" value=<%= rs.getString(1) %>></form> -->
 
	<tr>
			
  	
	<td><font size="5"color="green"><%=rs.getString(1) %></font></a></td>

	<form action=Group_Info.jsp>
        <td> <input type=submit name="button" value="go in"></td>
	<input type=hidden name="Info" value= "<%= rs.getString(1) %>">
	</form>
	</tr>

<%
}
%>
</table></center>
<br>
<br>
<br>
<br>
<br>
<b>Group You have joined</b>
<table border="1">      

<%
ResultSet rs2 = null;
rs2 = stmt2.executeQuery(sql2);
while(rs2.next()){
%>
<tr>
<td><font size="5"color="green"><%=rs2.getString(1) %></font></a></td>
<form action=Group_Info.jsp>
        <td> <input type=submit name="button2" value="go in"></td>
	<input type=hidden name="Info" value="<%= rs2.getString(1) %>">
	</form>
</tr>
<%
}
m_con.close();
g_con.close();
} catch (Exception e) {
			e.printStackTrace();
		}



%></table>








<br>
<br>
<br>
<a href = addGroup.jsp>Create Group</a>
<br>
<br>
<a href=Public.jsp>Back to Main Page</a>

</html>

