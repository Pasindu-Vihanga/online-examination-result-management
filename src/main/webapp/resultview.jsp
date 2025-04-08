<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    String[][] subjects = (String[][]) request.getAttribute("subjects");
    String studentName = (String) request.getAttribute("studentName");
    String dob = (String) request.getAttribute("dob");
    String uid = (String) request.getAttribute("uid");
    String fatherName = (String) request.getAttribute("fatherName");
    String studentClass = (String) request.getAttribute("class");
    String section = (String) request.getAttribute("section");
    String spDict = (String) request.getAttribute("spDict");
    String moralGrade = (String) request.getAttribute("moralGrade");
    String obtained = (String) request.getAttribute("obtained");
    String totalMarks = (String) request.getAttribute("totalMarks");
    String percentage = (String) request.getAttribute("percentage");
    String rank = (String) request.getAttribute("rank");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Student Result</title>
    <style>
        body { font-family: Arial; padding: 20px; background-color: #f8f8f8; }
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { border: 1px solid black; padding: 8px; text-align: center; }
        h1, h2, h3 { text-align: center; }
        tr:nth-child(even) { background-color: #f2f2f2; }
    </style>
</head>
<body>
<h1>SCHOOL NAME HERE</h1>
<h2>Exam Results (Session 2020-21)</h2>

<p><strong>Student Name:</strong> <%= (studentName != null ? studentName : "N/A") %>
    &nbsp;&nbsp; <strong>DOB:</strong> <%= (dob != null ? dob : "N/A") %>
    &nbsp;&nbsp; <strong>Unique ID:</strong> <%= (uid != null ? uid : "N/A") %></p>
<p><strong>Father's Name:</strong> <%= (fatherName != null ? fatherName : "N/A") %>
    &nbsp;&nbsp; <strong>Class:</strong> <%= (studentClass != null ? studentClass : "N/A") %>
    &nbsp;&nbsp; <strong>Section:</strong> <%= (section != null ? section : "N/A") %></p>

<table>
    <tr>
        <th>Subject</th><th>UT-40</th><th>C/H-5</th><th>ATTN-5</th><th>T1-50</th><th>Total</th>
    </tr>
    <%
        if (subjects != null && subjects.length > 0) {
            for (int i = 0; i < subjects.length; i++) {
    %>
    <tr>
        <td><%= subjects[i][0] != null ? subjects[i][0] : "N/A" %></td>
        <td><%= subjects[i][1] != null ? subjects[i][1] : "0" %></td>
        <td><%= subjects[i][2] != null ? subjects[i][2] : "0" %></td>
        <td><%= subjects[i][3] != null ? subjects[i][3] : "0" %></td>
        <td><%= subjects[i][4] != null ? subjects[i][4] : "0" %></td>
        <td><%= subjects[i][5] != null ? subjects[i][5] : "0" %></td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="6">No subject data available</td>
    </tr>
    <%
        }
    %>
    <tr>
        <td>SP/DICT</td><td colspan="4">-</td><td><%= (spDict != null ? spDict : "N/A") %></td>
    </tr>
    <tr>
        <td>MORAL SCIENCE (GRADE)</td><td colspan="5"><%= (moralGrade != null ? moralGrade : "N/A") %></td>
    </tr>
</table>

<p><strong>Obtained:</strong> <%= (obtained != null ? obtained : "0") %> out of <%= (totalMarks != null ? totalMarks : "0") %></p>
<p><strong>Percentage:</strong> <%= (percentage != null ? percentage : "0.00") %>%</p>
<p><strong>Rank:</strong> <%= (rank != null ? rank : "N/A") %></p>

<br>
<p><em>Disclaimer: Neither the webmaster nor the board is responsible for any inadvertent errors in the results being published online.</em></p>
</body>
</html>
