<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP DEMO</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	min-height: 100vh;
	background: linear-gradient(135deg, #1f3b73, #2e5799);
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 30px;
}

.card {
	border: none;
	border-radius: 1rem;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
}

h3 {
	color: #2e5799;
	font-weight: bold;
}

.table {
	background: white;
	border-radius: 0.5rem;
	overflow: hidden;
}

hr {
	border-top: 2px solid #fff;
}
</style>
</head>
<body>
	<div class="container">
		<div class="row g-4">
			<!-- Register Form -->
			<div class="col-lg-5">
				<div class="card p-4">
					<h3 class="text-center mb-4">Register</h3>
					<form action="#" method="get">
						<div class="mb-3">
							<label class="form-label">Full Name</label> <input type="text"
								name="name" class="form-control" placeholder="Enter your name">
						</div>
						<div class="mb-3">
							<label class="form-label">Email address</label> <input
								type="email" name="email" class="form-control"
								placeholder="Enter your email">
						</div>
						<div class="mb-3">
							<label class="form-label">Password</label> <input type="password"
								name="password" class="form-control"
								placeholder="Enter your password">
						</div>
						<button type="submit" name="register"
							class="btn btn-primary w-100">Register</button>
					</form>
				</div>
			</div>

			<!-- Register Backend -->
			<%
			try {
				if (request.getParameter("register") != null) {
					String Name = request.getParameter("name");
					String Email = request.getParameter("email");
					String Password = request.getParameter("password");

					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_data", "root", "root");

					Statement st = con.createStatement();
					st.executeUpdate("INSERT INTO emp_info(e_name, e_email, e_password) VALUES('" + Name + "','" + Email + "','"
					+ Password + "')");
			%>
			<script>
				alert("Registration Done Successfully!!");
			</script>
			<%
			}
			} catch (Exception e) {
			e.printStackTrace();
			}
			%>

			<!-- Table -->
			<div class="col-lg-7">
				<div class="card p-4">
					<h3 class="text-center mb-4">Registered Users</h3>
					<table class="table table-bordered text-center align-middle">
						<thead class="table-primary">
							<tr>
								<th>Name</th>
								<th>Email</th>
								<th>Password</th>
							</tr>
						</thead>
						<tbody>
							<%
							Class.forName("com.mysql.cj.jdbc.Driver");
							Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_data", "root", "root");

							PreparedStatement ps = con.prepareStatement("SELECT * FROM emp_info");
							ResultSet rs = ps.executeQuery();

							while (rs.next()) {
							%>
							<tr>
								<td><%=rs.getString("e_name")%></td>
								<td><%=rs.getString("e_email")%></td>
								<td><%=rs.getString("e_password")%></td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>
			</div>
		</div>

		<hr class="my-5">

		<!-- Login Section -->
		<div class="row g-4">
			<div class="col-lg-5">
				<div class="card p-4">
					<h3 class="text-center mb-4">Login</h3>
					<form action="#" method="get">
						<div class="mb-3">
							<label class="form-label">Email address</label> <input
								type="email" name="email1" class="form-control"
								placeholder="Enter your email">
						</div>
						<div class="mb-3">
							<label class="form-label">Password</label> <input type="password"
								name="password1" class="form-control"
								placeholder="Enter your password">
						</div>
						<button type="submit" name="login" class="btn btn-success w-100">Login</button>
					</form>

					<%
					String Email1 = request.getParameter("email1");
					String Password1 = request.getParameter("password1");

					if (Email1 != null && Password1 != null) {
						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_data", "root", "root");

						PreparedStatement ps1 = con1.prepareStatement("SELECT * FROM emp_info WHERE e_email=? AND e_password=?");
						ps1.setString(1, Email1);
						ps1.setString(2, Password1);

						ResultSet rs1 = ps1.executeQuery();
						if (rs1.next()) {
							HttpSession ses = request.getSession();
							ses.setAttribute("name", rs1.getString("e_name"));
							ses.setAttribute("email", rs1.getString("e_email"));
							ses.setAttribute("password", rs1.getString("e_password"));
					%>
					<script>
						alert("Login Done Successfully!!");
					</script>
					<%
					}
					}
					%>
				</div>
			</div>

			<!-- Session Data -->
			<div class="col-lg-7">
				<div class="card p-4 text-center">
					<%
					String Name2 = (String) session.getAttribute("name");
					String Email2 = (String) session.getAttribute("email");
					String Password2 = (String) session.getAttribute("password");
					%>
					<h4>
						Name: <span class="text-primary"><%=Name2%></span>
					</h4>
					<h4>
						Email: <span class="text-primary"><%=Email2%></span>
					</h4>
					<h4>
						Password: <span class="text-primary"><%=Password2%></span>
					</h4>
				</div>
			</div>
		</div>

		<hr class="my-5">

		<!-- Admin Login -->
		<div class="row justify-content-center">
			<div class="col-lg-6">
				<div class="card p-4">
					<h3 class="text-center mb-4">Admin Login</h3>
					<form action="#" method="get">
						<div class="mb-3">
							<label class="form-label">Email address</label> <input
								type="email" name="email2" class="form-control"
								placeholder="Enter your email">
						</div>
						<div class="mb-3">
							<label class="form-label">Password</label> <input type="password"
								name="password2" class="form-control"
								placeholder="Enter your password">
						</div>
						<button type="submit" name="adminlogin"
							class="btn btn-danger w-100">Login</button>
					</form>

					<%
					if (request.getParameter("adminlogin") != null) {
						String Email3 = request.getParameter("email2");
						String Password3 = request.getParameter("password2");

						if (Email3.equals("sohansirvi@gmail.com") && Password3.equals("1234")) {
							out.print("<script>alert('Successful Login')</script>");
						} else {
							out.print("<script>alert('Email and Password Did Not Match')</script>");
						}
					}
					%>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
