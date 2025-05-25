<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>

<%
    // Retrieve the list of results from the request attribute
    List<String[]> results = (List<String[]>) request.getAttribute("results");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Admin Dashboard - Exam Results Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>
<div class="container mt-5">
    <h2 class="text-primary text-center">Exam Results Management</h2>
    <table class="table table-bordered text-center mt-3">
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
        <% if (results != null && !results.isEmpty()) {
            for (String[] result : results) {
                String studentId = result[0];
                String examCode = result[1];
                int score = Integer.parseInt(result[2]);
                String status = score >= 45 ? "✅ Pass" : "❌ Fail";
        %>
        <tr>
            <td><%= studentId %></td>
            <td><%= examCode %></td>
            <td><%= score %></td>
            <td><%= status %></td>
            <td>
                <form method="post" action="AdminResultManagementServlet" style="display:inline;">
                    <input type="hidden" name="studentId" value="<%= studentId %>">
                    <input type="hidden" name="examCode" value="<%= examCode %>">
                    <input type="hidden" name="action" value="delete">
                    <button type="submit" class="btn btn-danger btn-sm">🗑️ Delete</button>
                </form>
                <form method="post" action="AdminResultManagementServlet" style="display:inline;">
                    <input type="hidden" name="studentId" value="<%= studentId %>">
                    <input type="hidden" name="examCode" value="<%= examCode %>">
                    <input type="hidden" name="action" value="update">
                    <input type="number" name="newScore" class="form-control form-control-sm d-inline w-25" placeholder="New Score" required>
                    <button type="submit" class="btn btn-warning btn-sm">✏️ Edit</button>
                </form>
            </td>
        </tr>
        <%   }
        } else { %>
        <tr><td colspan="5" class="text-center text-muted">No results available.</td></tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
