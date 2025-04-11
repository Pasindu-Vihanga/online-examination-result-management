<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Examination & Result Management - Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(120deg, #00B4DB, #0083B0); /* Gradient background */
        }
        .form-container {
            max-width: 420px;
            margin: 60px auto;
            padding: 30px;
            background-color: #ffffff; /* White form background */
            border-radius: 16px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2); /* Shadow for card */
        }
        .form-container h2 {
            color: #004d40; /* Teal heading */
            font-weight: bold;
        }
        .btn-primary, .btn-secondary {
            padding: 10px 20px;
        }
        .footer {
            background-color: #004d40;
            color: white;
            padding: 20px 0;
            text-align: center;
        }
    </style>
</head>
<body>

<section id="register" class="container py-5">
    <div class="form-container">
        <h2 class="text-center mb-4">Registration Portal</h2>

        <form action="register" method="post">
            <div class="mb-3">
                <label for="name" class="form-label">Enter Name</label>
                <input type="text" class="form-control" id="name" name="name" placeholder="Enter name" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Create Password</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Create a password" required>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email Address</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="Enter email address" required>
            </div>
            <!-- Correctly spaced and aligned buttons -->
            <div class="d-grid gap-3">
                <button type="submit" class="btn btn-primary">Register</button>
                <a href="index.jsp" class="btn btn-secondary">Back to Main</a>
            </div>
        </form>
    </div>
</section>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
