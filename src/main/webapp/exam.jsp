<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Practical Examination</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .hero {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('practical-bg.jpg') center/cover;
            color: white;
            text-align: center;
            padding: 50px 20px;
        }
        .questions-card, .instructions-card, .tasks-card {
            margin: 20px 0;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#">Examination Portal</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link text-danger" href="index.jsp">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<section class="hero">
    <div class="container">
        <h1>Practical Examination</h1>
        <p>Complete the tasks below to showcase your skills and knowledge.</p>
    </div>
</section>

<section id="instructions" class="container py-5">
    <h2 class="text-center">Instructions</h2>
    <div class="card instructions-card">
        <div class="card-body">
            <ul>
                <li>Read all the tasks carefully before attempting them.</li>
                <li>Ensure all steps are followed as mentioned.</li>
                <li>Submit your results within the allocated time.</li>
                <li>Use the resources provided in the lab environment.</li>
            </ul>
        </div>
    </div>
</section>

<section id="tasks" class="container py-5">
    <h2 class="text-center">Practical Tasks</h2>
    <div class="card tasks-card">
        <div class="card-body">
            <p><strong>Task:</strong> Design and implement a dynamic web application that takes user inputs, validates them, and stores the results in a database. Use the provided resources.</p>
            <button class="btn btn-success">Start Task</button>
        </div>
    </div>
</section>

<section id="sample-questions" class="container py-5">
    <h2 class="text-center">20 Sample Questions</h2>
    <div class="card questions-card">
        <div class="card-body">
            <ol>
                <li>Design a webpage with a responsive layout using Bootstrap.</li>
                <li>Create a form that includes validation for all fields using JavaScript.</li>
                <li>Write a SQL query to retrieve data from multiple tables using JOIN.</li>
                <li>Implement a simple REST API in a programming language of your choice.</li>
                <li>Write a function to calculate the factorial of a number in Python.</li>
                <li>Create a webpage to display user information fetched from an API.</li>
                <li>Design a database schema for a student management system.</li>
                <li>Write a Java program to reverse a string without using a library method.</li>
                <li>Develop a static website with HTML, CSS, and JavaScript for an online store.</li>
                <li>Implement a basic login functionality with session handling in PHP.</li>
                <li>Create a script to automate file backups in a local directory.</li>
                <li>Develop a web page that uses AJAX to fetch and display real-time data.</li>
                <li>Write a C program to find the largest and smallest elements in an array.</li>
                <li>Implement a CSS grid layout for an image gallery.</li>
                <li>Write a function to check if a given string is a palindrome in JavaScript.</li>
                <li>Create a bar chart using a JavaScript charting library like Chart.js.</li>
                <li>Design an ER diagram for a library management system.</li>
                <li>Write a Python script to scrape data from a website and store it in a CSV file.</li>
                <li>Develop a webpage with a dropdown menu and styled checkboxes using Bootstrap.</li>
                <li>Write a JavaScript function to calculate the Fibonacci sequence up to a given number.</li>
            </ol>
        </div>
    </div>
</section>

<footer class="bg-dark text-white text-center py-3">
    <p>&copy; 2025 Examination Portal. All Rights Reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
