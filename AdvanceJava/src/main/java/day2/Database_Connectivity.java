package day2;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/Database_Connectivity")
public class Database_Connectivity extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		PrintWriter out = resp.getWriter();
		
		try {
			
			if(req.getParameter("student") !=null) {
				
				String Name = req.getParameter("name");
				String Email = req.getParameter("email");
				String Password = req.getParameter("pass");
				String Dob = req.getParameter("date");
				
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_data", "root", "root");
				Statement st = con.createStatement();
				st.executeUpdate("insert into student_info (s_name, s_email, s_password, s_dob) values ('"+ Name +"' , '"+ Email +"', '"+Password+"', '"+Dob+"')");
				
				out.print("<script>alert('Registered Successfully !!!')</script>");
				
				out.println("<div style='max-width:600px; margin: 50px auto; font-family:sans-serif;'>");
		        out.println("<h2 style='text-align:center; color:blue;'>Registration Successful</h2>");
		        out.println("<hr>");
		        out.println("<p><strong>Name:</strong> " + Name + "</p>");
		        out.println("<p><strong>Email:</strong> " + Email + "</p>");
		        out.println("<p><strong>Gender:</strong> " + Password + "</p>");
		        out.println("<p><strong>Address:</strong> " + Dob + "</p>");
		        out.println("</div>");
			
			}
			
		}catch(Exception e) {
			e.getMessage();
		}
		
	}
	
}