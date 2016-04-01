import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

public class SQLServlet extends HttpServlet {
	public void init() throws ServletException {
	}

	public void doGet(HttpServletRequest request,
                    HttpServletResponse response)
            throws ServletException, IOException
  {
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

			String sql = "SELECT photo FROM images";
			ResultSet resultSet = null;
			//out.println(sql);
			resultSet = stmt.executeQuery(sql);
			while(resultSet.next()){
				Blob blob = resultSet.getBlob(2);
                byte[] image = blob.getBytes(1, (int) blob.length());
                OutputStream outputStream = response.getOutputStream();
                outputStream.write(image);
			}
			m_con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
  }
  
  public void destroy()
  {
      // do nothing.
  }


}
