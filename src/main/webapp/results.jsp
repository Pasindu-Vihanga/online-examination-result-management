<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exam Results Portal - Check Your Results</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .result-form {
            max-width: 500px;
            margin: 2rem auto;
            padding: 2rem;
            background: white;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">Exam Results Portal</a>
    </div>
</nav>

<main class="container">
    <section class="result-form">
        <h2 class="h4 mb-4 text-center">Result Inquiry</h2>
        <form action="ViewAnswersServlet" method="get">
            <div class="mb-3">
                <label for="studentId" class="form-label fw-bold">Index Number</label>
                <input type="text" class="form-control form-control-lg" id="studentId"
                       name="studentId" required placeholder="e.g., IT1150">
            </div>
            <div class="mb-3">
                <label for="examCode" class="form-label fw-bold">Exam Code</label>
                <input type="text" class="form-control form-control-lg" id="examCode"
                       name="examCode" required placeholder="e.g., DM1120">
            </div>
            <button type="submit" class="btn btn-primary btn-lg w-100 py-2">View Results</button>
        </form>
    </section>

    <section id="resultContainer" class="mt-5" style="display: none;">
        <h3 class="text-center">Exam Results</h3>
        <div class="alert alert-info text-center" id="scoreDisplay"></div>
        <table class="table table-bordered mt-3">
            <thead>
            <tr>
                <th>Question Number</th>
                <th>Correct</th>
            </tr>
            </thead>
            <tbody id="resultsTable"></tbody>
        </table>
    </section>
</main>

<script>
    document.querySelector("form").addEventListener("submit", function(event) {
        event.preventDefault();
        let studentId = document.getElementById("studentId").value;
        let examCode = document.getElementById("examCode").value;

        fetch("ViewAnswersServlet?studentId=" + studentId + "&examCode=" + examCode)
            .then(response => response.json())
            .then(data => {
                document.getElementById("scoreDisplay").innerText = "Final Score: " + data.score;
                document.getElementById("resultContainer").style.display = "block";

                let resultsTable = document.getElementById("resultsTable");
                resultsTable.innerHTML = "";
                data.answers.forEach(answer => {
                    let row = `<tr>
                    <td>${answer.questionNumber}</td>
                    <td class="${answer.correct ? 'text-success' : 'text-danger'}">
                        ${answer.correct ? "✔" : "✘"}
                    </td>
                </tr>`;
                    resultsTable.innerHTML += row;
                });
            })
            .catch(error => console.error("Error fetching results:", error));
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
