<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Register</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #00b4d8, #0077b6);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .register-container {
            background: rgba(255, 255, 255, 0.15);
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 450px;
            backdrop-filter: blur(15px);
            box-shadow: 0 8px 40px rgba(0, 0, 0, 0.2);
            color: white;
            text-align: center;
        }

        .register-container img {
            width: 90px;
            height: 90px;
            object-fit: cover;
            border-radius: 50%;
            margin-bottom: 15px;
            border: 3px solid white;
        }

        .form-group {
            position: relative;
            margin-bottom: 25px;
        }

        .form-control {
            background: transparent;
            border: none;
            border-bottom: 1px solid white;
            border-radius: 0;
            color: white;
            padding-left: 38px;
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

        .form-group i {
            position: absolute;
            top: 9px;
            left: 10px;
            color: white;
        }

        .btn-register {
            width: 100%;
            padding: 12px;
            border-radius: 25px;
            border: 1px solid white;
            color: white;
            background: transparent;
            font-weight: bold;
            transition: all 0.3s ease;
        }

        .btn-register:hover {
            background-color: white;
            color: #0077b6;
        }

        .bottom-text {
            margin-top: 20px;
            font-size: 0.9rem;
        }

        .bottom-text a {
            color: white;
            text-decoration: underline;
        }

        .bottom-text a:hover {
            color: #d9f2ff;
        }
    </style>
</head>
<body>
<div class="register-container">
    <h3 class="mb-4">Create Account</h3>
    <form action="registerAD" method="post">
        <div class="form-group">
            <i class="bi bi-person-fill"></i>
            <input type="text" class="form-control" name="username" placeholder="User Name" required />
        </div>
        <div class="form-group">
            <i class="bi bi-lock-fill"></i>
            <input type="password" class="form-control" name="password" placeholder="Password" required />
        </div>
        <div class="form-group">
            <i class="bi bi-lock-fill"></i>
            <input type="password" class="form-control" name="confirm_password" placeholder="Confirm Password" required />
        </div>
        <div class="form-group">
            <i class="bi bi-envelope-fill"></i>
            <input type="email" class="form-control" name="email" placeholder="Email Address" required />
        </div>
        <button type="submit" class="btn btn-register">Register</button>
    </form>
    <div class="bottom-text">
        Already have an account? <a href="adminlogin.jsp">Login here</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
