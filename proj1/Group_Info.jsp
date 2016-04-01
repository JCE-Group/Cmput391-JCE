
<%@ page import="java.sql.*, java.util.*, java.io.*" %>
<html>

<%
String Gr_name = request.getParameter("Info");



HttpSession sess = request.getSession();
session.setAttribute("Gr_name",Gr_name);


String m_driverName = "oracle.jdbc.driver.OracleDriver";
String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";

String m_userName = "peijen";
String m_password = "z23867698";

Connection m_con;
Connection g_con;
Connection h_con;
Statement stmt;
Statement stmt2;
Statement stmt3;
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
	h_con = DriverManager.getConnection(m_url, m_userName, 	m_password);
	
	stmt = m_con.createStatement();
	stmt2 = g_con.createStatement();
	stmt3 = h_con.createStatement();
	
        //get username and group id
	String sql ="SELECT user_name, group_id  FROM groups where group_name='"+Gr_name+"'";
	

	
	ResultSet rs = null;
	ResultSet rs2 = null;
	ResultSet rs3 = null;
	rs = stmt.executeQuery(sql);
	
	
	rs.next();
	//rs2.next();
%>


<font size="10" color="Green"><%out.println(Gr_name);%></font>
<form action="demo_form.asp" id="usrform">
<br>
<font size="5" color="Green">Owner of the Group: <%out.println(rs.getString(1));%></font>

</form>
<br>


<br>






<form action = addFriend.jsp method = post style = display:inline>
<input type = submit value = "Add Friend">
<input type=hidden name="Info" value= >
</form>

<form action = removeFriend.jsp method = post style = display:inline>
<input type = submit value = "Remove Friend">
<input type=hidden name="Info" value= >
</form>
<br>
<br>
<br>
<font size="5"color="purple"> <b>Friend list</b> </font>  </center>
<table border="1">

<%
//store group_id into session
sess.setAttribute("Gr_id",rs.getString(2));
String G_id= (String)sess.getAttribute("Gr_id");

String sql3 ="SELECT friend_id  FROM group_lists where group_id='"+G_id+"'";
rs3 = stmt3.executeQuery(sql3);
while(rs3.next()){
%>
<td><font size="5"color="green"><%=rs3.getString(1) %></font></a></td>

<%
}
%></table>

<font size="5"color="blue"> <b>Group Photo</b> </font>  </center>
<%

	//get photo id
	String sql2 ="SELECT photo_id FROM images WHERE permitted ="+G_id+"";
	rs2 = stmt2.executeQuery(sql2);
	while(rs2.next()){

%>
<tr>
<td><center>
<a href= "/proj1/GetBigPic?big<%=rs2.getString(1)%>" />
<img src = "/proj1/GetOnePic?<%=rs2.getString(1)%>" />
</a>
</td>
</tr>

<%
}
m_con.close();
g_con.close();
h_con.close();
} catch (Exception e) {
			e.printStackTrace();
		}
%></table></center>


<br>
<br>
<br>
<a href = Group_List.jsp>Your Group List</a>
<br>
<a href = Public_Glist.jsp>Public Group List</a>
<br>
<a href=Public.jsp>Back to Main Page</a>

</html>
