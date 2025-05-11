<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Admin Login</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to bottom right, #0077b6, #00b4d8);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-container {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 15px;
            padding: 40px;
            width: 100%;
            max-width: 400px;
            backdrop-filter: blur(10px);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
            color: white;
            text-align: center;
        }

        .login-container img {
            width: 100px;
            border-radius: 50%;
            margin-bottom: 20px;
        }

        .form-control {
            background: transparent;
            border: none;
            border-bottom: 1px solid white;
            border-radius: 0;
            color: white;
            padding-left: 35px;
            transition: all 0.3s ease;
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .form-control:focus {
            background: white;
            color: #000;
            border-bottom: 2px solid #0077b6;
            outline: none;
        }

        .form-control:focus::placeholder {
            color: #666;
        }

        .form-label {
            display: none;
        }

        .form-group {
            position: relative;
            margin-bottom: 30px;
        }

        .form-group i {
            position: absolute;
            top: 10px;
            left: 10px;
            color: white;
        }

        .form-check-label, .forgot-link {
            color: white;
        }

        .btn-login {
            border: 1px solid white;
            color: white;
            background: transparent;
            width: 100%;
            padding: 10px;
            border-radius: 25px;
        }

        .btn-login:hover {
            background: white;
            color: #0077b6;
        }

        .form-check {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .forgot-link {
            font-size: 0.9rem;
            text-decoration: none;
        }

        .forgot-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="login-container">
    <img src="/pictures/avatar-placeholder.png" alt="Admin Portal" />
    <form action="memberslogin" method="post">
        <div class="form-group">
            <i class="bi bi-envelope-fill"></i>
            <input type="text" class="form-control" name="username" placeholder="User name" required />
        </div>
        <div class="form-group">
            <i class="bi bi-lock-fill"></i>
            <input type="password" class="form-control" name="password" placeholder="Password" required />
        </div>
        <div class="form-check">
            <div>
                <input type="checkbox" class="form-check-input" id="rememberMe" />
                <label class="form-check-label" for="rememberMe">Remember me</label>
            </div>
            <a href="adminreg.jsp" class="forgot-link">Forgot Password?</a>
        </div>
        <button type="submit" class="btn btn-login">LOGIN</button>
    </form>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
