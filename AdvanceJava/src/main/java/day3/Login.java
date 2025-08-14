package day3;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/Login")
public class Login extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			if(req.getParameter("submit") != null) {
				
				String Email = req.getParameter("email");
				String Password = req.getParameter("password");
				
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_data","root","root");
				
				PreparedStatement ps = con.prepareStatement("SELECT * FROM stu_login_info WHERE s_email=? AND s_password=?");
				ps.setString(1, Email);
				ps.setString(2, Password);
				
				ResultSet rs = ps.executeQuery();
				
				if(rs.next()) {
					resp.sendRedirect("Profile.html");
				}
				else {
					resp.sendRedirect("Register1.html");
				}
			}
			
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}

}
