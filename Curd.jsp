<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CRUD Operations</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    body {
        background: linear-gradient(135deg, #e3f2fd, #ffffff);
    }
    .table {
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }
    .table thead {
        background: #0d6efd;
        color: white;
    }
    .table tbody tr:hover {
        background: #f1f7ff;
        transition: 0.2s ease-in-out;
    }
    .btn {
        border-radius: 20px;
        padding: 5px 12px;
    }
    .modal-content {
        border-radius: 15px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.2);
    }
    .modal-header {
        background: #0d6efd;
        color: white;
        border-top-left-radius: 15px;
        border-top-right-radius: 15px;
    }
    .modal-footer button {
        border-radius: 20px;
    }
    h3 {
        font-weight: bold;
        color: #0d6efd;
        text-shadow: 1px 1px 2px #cce0ff;
    }
</style>
</head>
<body>

	<div class="container mt-5">
		<div class="card shadow-lg border-0 rounded-4">
			<div class="card-body">
				<h3 class="text-center mb-4">📚 Students Information</h3>

				<table class="table table-bordered table-hover text-center align-middle">
					<thead>
						<tr>
							<th>ID</th>
							<th>Profile Photo</th>
							<th>Name</th>
							<th>Email</th>
							<th>Password</th>
							<th>Contact No.</th>
							<th>City</th>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
						<%
						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_data", "root", "root");
						PreparedStatement ps = con.prepareStatement("select * from curd_operation");
						ResultSet rs = ps.executeQuery();
						while (rs.next()) {
						%>
						<tr>
							<td><%=rs.getInt("c_id")%></td>
							<td><img class="img-fluid rounded-circle border border-2 border-primary shadow-sm" width="70"
								src="<%=rs.getString("c_profilephoto")%>" /></td>
							<td><%=rs.getString("c_name")%></td>
							<td><%=rs.getString("c_email")%></td>
							<td><%=rs.getString("c_password")%></td>
							<td><%=rs.getString("c_contactno")%></td>
							<td><%=rs.getString("c_city")%></td>
							<td>
								<button type="button" class="btn btn-sm btn-info text-white"
									data-bs-toggle="modal"
									data-bs-target="#editModal<%=rs.getInt("c_id")%>">
									✏ Edit
								</button>
								<form action="#" method="post" style="display: inline;">
									<input type="hidden" name="deleteId" value="<%=rs.getInt("c_id")%>" />
									<button type="submit" class="btn btn-sm btn-danger">
										🗑 Delete
									</button>
								</form>
							</td>
						</tr>

						<!-- Edit Modal -->
						<div class="modal fade" id="editModal<%=rs.getInt("c_id")%>" tabindex="-1">
							<div class="modal-dialog">
								<div class="modal-content">
									<form action="#" method="get">
										<div class="modal-header">
											<h5 class="modal-title">Edit Student</h5>
											<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
										</div>
										<div class="modal-body">
											<input type="hidden" name="editId" value="<%=rs.getInt("c_id")%>" />
											<input type="url" class="form-control mb-3" name="c_profilephoto" value="<%=rs.getString("c_profilephoto")%>" placeholder="Profile Photo URL" required />
											<input type="text" class="form-control mb-3" name="c_name" value="<%=rs.getString("c_name")%>" placeholder="Name" required />
											<input type="email" class="form-control mb-3" name="c_email" value="<%=rs.getString("c_email")%>" placeholder="Email" required />
											<input type="password" class="form-control mb-3" name="c_password" value="<%=rs.getString("c_password")%>" placeholder="Password" required />
											<input type="tel" class="form-control mb-3" name="c_contactno" value="<%=rs.getString("c_contactno")%>" placeholder="Contact No" required />
											<input type="text" class="form-control mb-3" name="c_city" value="<%=rs.getString("c_city")%>" placeholder="City" required />
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
											<button type="submit" class="btn btn-primary" name="update">💾 Save changes</button>
										</div>
									</form>
								</div>
							</div>
						</div>
						<%
						}
						%>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<%
	
	if (request.getParameter("deleteId") != null) {
		try {
			int id = Integer.parseInt(request.getParameter("deleteId"));
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_data", "root", "root");
			PreparedStatement ps1 = con1.prepareStatement("delete from curd_operation where c_id=?");
			ps1.setInt(1, id);
			ps1.executeUpdate();
			con1.close();
			response.sendRedirect("Curd.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	if (request.getParameter("update") != null) {
		try {
			int id = Integer.parseInt(request.getParameter("editId"));
			String photo = request.getParameter("c_profilephoto");
			String name = request.getParameter("c_name");
			String email = request.getParameter("c_email");
			String password = request.getParameter("c_password");
			String phone = request.getParameter("c_contactno");
			String city = request.getParameter("c_city");

			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_data", "root", "root");
			PreparedStatement ps2 = con2.prepareStatement(
			"update curd_operation set c_profilephoto=?, c_name=?, c_email=?, c_password=?, c_contactno=?, c_city=? where c_id=?");
			ps2.setString(1, photo);
			ps2.setString(2, name);
			ps2.setString(3, email);
			ps2.setString(4, password);
			ps2.setString(5, phone);
			ps2.setString(6, city);
			ps2.setInt(7, id);
			ps2.executeUpdate();
			response.sendRedirect("Curd.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
