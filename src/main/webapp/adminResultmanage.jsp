<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Arrays, com.jsp.exam.service.ExamResultService" %>
<%
    ExamResultService examService = new ExamResultService();
    List<String[]> results = examService.getAllResults();

    // Selection Sort algorithm to sort results by marks (column index 2)
    if (request.getParameter("sort") != null) {
        for (int i = 0; i < results.size() - 1; i++) {
            int minIndex = i;
            for (int j = i + 1; j < results.size(); j++) {
                int marks1 = Integer.parseInt(results.get(minIndex)[2].replaceAll("[^0-9]", "0"));
                int marks2 = Integer.parseInt(results.get(j)[2].replaceAll("[^0-9]", "0"));

                if (marks2 < marks1) {
                    minIndex = j;
                }
            }
            String[] temp = results.get(i);
            results.set(i, results.get(minIndex));
            results.set(minIndex, temp);
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Admin Dashboard - Exam Records</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        body {
            background-color: #f4f4f4;
        }
        .admin-panel {
            max-width: 900px;
            margin: 50px auto;
            padding: 20px;
            border-radius: 10px;
            background: #ffffff;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
        .table-hover tbody tr:hover {
            background-color: #f8f9fa;
        }
        .btn {
            border-radius: 5px;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-danger {
            background-color: #dc3545;
        }
        .btn-danger:hover {
            background-color: #c82333;
        }
        .btn-warning {
            background-color: #ffc107;
        }
        .btn-warning:hover {
            background-color: #e0a800;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="admin-panel">
        <h2 class="text-center text-primary">Admin - Manage Exam Results</h2>

        <form action="adminResultManagement.jsp" method="get" class="text-center">
            <button type="submit" name="sort" class="btn btn-primary mb-3">🔄 Sort by Marks (Ascending)</button>
        </form>

        <div class="table-responsive">
            <table class="table table-hover table-bordered text-center">
                <thead class="table-dark">
                <tr>
                    <th>Student ID</th>
                    <th>Exam Code</th>
                    <th>Marks</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <% if (results != null && !results.isEmpty()) { %>
                <% for (String[] result : results) {
                    int score = Integer.parseInt(result[2].replaceAll("[^0-9]", "0"));
                    String status = score >= 250 ? "✅ Pass" : "❌ Fail";
                %>
                <tr>
                    <td><%= result[0] %></td>
                    <td><%= result[1] %></td>
                    <td><strong><%= score %></strong></td>
                    <td class="<%= score >= 250 ? "text-success" : "text-danger" %>"><%= status %></td>
                    <td>
                        <form action="AdminResultManagementServlet" method="post" style="display:inline;">
                            <input type="hidden" name="studentId" value="<%= result[0] %>">
                            <input type="hidden" name="examCode" value="<%= result[1] %>">
                            <input type="hidden" name="action" value="delete">
                            <button type="submit" class="btn btn-danger">🗑️ Delete</button>
                        </form>

                        <form action="AdminResultManagementServlet" method="post" style="display:inline;">
                            <input type="hidden" name="studentId" value="<%= result[0] %>">
                            <input type="hidden" name="examCode" value="<%= result[1] %>">
                            <input type="hidden" name="action" value="update">
                            <input type="number" name="newScore" class="form-control form-control-sm d-inline w-50" placeholder="New Score" required>
                            <button type="submit" class="btn btn-warning">✏️ Edit</button>
                        </form>
                    </td>
                </tr>
                <% } %>
                <% } else { %>
                <tr>
                    <td colspan="5" class="alert alert-warning text-center">No exam results found.</td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div><br>
        <div class="text-center">
            <a href="add-record.html" class="btn btn-success">➕ Add New Record</a>
        </div>
    </div>
</div>
</body>
</html>
