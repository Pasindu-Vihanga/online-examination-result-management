<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            /* Modify background here */
            background: linear-gradient(120deg, #00bcd4, #ffc107); /* Example: Gradient background */
        }
        .login-card {
            max-width: 420px;
            margin: 60px auto;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }
        .login-header {
            font-weight: 600;
            color: #343a40;
        }
        .form-control:focus {
            box-shadow: 0 0 0 0.2rem rgba(13,110,253,.25);
        }
    </style>
</head>
<body>
<div class="container">
    <div class="card login-card p-4">
        <h3 class="text-center login-header mb-4">Login Portal</h3>
        <form method="POST" action="login">
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" id="username" name="username" class="form-control" required placeholder="Enter your username" />
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" id="password" name="password" class="form-control" required placeholder="Enter your password" />
            </div>
            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary w-100">Login</button>
                <a href="index.jsp" class="btn btn-secondary w-100">Back to Main</a>
            </div>

        </form>
        <div class="text-center mt-3">
            <p>Not registered? <a href="registration.jsp" class="btn btn-outline-secondary">Register Here</a></p>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
