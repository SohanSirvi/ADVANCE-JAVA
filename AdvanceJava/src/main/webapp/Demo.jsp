<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP DEMO</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
<style>
    body {
      min-height: 100vh;
      background: linear-gradient(135deg, #1f3b73, #2e5799);
      display: grid;
      place-items: center;
    }
    .card {
      border: none;
      border-radius: 1.25rem;
      box-shadow: 0 10px 30px rgba(0,0,0,.15);
    }
  </style>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-lg-5">
				<h3 class="text-center mb-4">Register</h3>
      <form>
        <div class="mb-3">
          <label for="name" class="form-label">Full Name</label>
          <input type="text" name="name" class="form-control" id="name" placeholder="Enter your name">
        </div>

        <div class="mb-3">
          <label for="email" class="form-label">Email address</label>
          <input type="email" name="email" class="form-control" id="email" placeholder="Enter your email">
        </div>

        <div class="mb-3">
          <label for="password" class="form-label">Password</label>
          <input type="password" name="password" class="form-control" id="password" placeholder="Enter your password">
        </div>

        <button type="submit" name="register" class="btn btn-primary w-100">Register</button>
      </form>			
			</div>
			
			<div class="col-lg-7">
				
			</div>
		</div>
	</div>
</body>
</html>