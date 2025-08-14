package day3;

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


@WebServlet("/Register")
public class Register extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		PrintWriter out = resp.getWriter();
		
		try {
			if(req.getParameter("submit") != null) {
				String Name = req.getParameter("name");
				String Email = req.getParameter("email");
				String Password = req.getParameter("password");
				String Contact = req.getParameter("contact");
				
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_data","root","root");
				
				Statement st = con.createStatement();
				st.executeUpdate("INSERT INTO stu_login_info(s_name, s_email, s_password, s_contact) VALUES('"+Name+"','"+Email+"','"+Password+"','"+Contact+"')");
				
				out.print("<script>alert('Data Inserted Successfully!!!')</script>");
				
				out.println("<div style='max-width:600px; margin: 50px auto; font-family:sans-serif;'>");
		        out.println("<h2 style='text-align:center; color:blue;'>Registration Successful</h2>");
		        out.println("<hr>");
		        out.println("<p><strong>Name:</strong> " + Name + "</p>");
		        out.println("<p><strong>Email:</strong> " + Email + "</p>");
		        out.println("<p><strong>Password:</strong> " + Password + "</p>");
		        out.println("<p><strong>Contact:</strong> " + Contact + "</p>");
		        out.println("</div>");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}

}
