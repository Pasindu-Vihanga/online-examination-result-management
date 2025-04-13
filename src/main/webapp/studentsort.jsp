<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Results</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #f4f4f4;
        }
    </style>
</head>
<body>
<h2>Student Results</h2>
<%
    // Path to the file where results are stored
    String filePath = application.getRealPath("/logincreds/results.txt");
    File file = new File(filePath);

    // Check if file exists
    if (!file.exists()) {
        out.println("<p>Results file not found!</p>");
    } else {
        // LinkedList to hold the results
        LinkedList<String[]> resultsList = new LinkedList<>();

        // Read the file and parse the data
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(","); // Split data by commas
                resultsList.add(parts);
            }
        } catch (IOException e) {
            out.println("<p>Error reading the file: " + e.getMessage() + "</p>");
        }

        // Display the results in a table
        if (resultsList.isEmpty()) {
            out.println("<p>No results found!</p>");
        } else {
            out.println("<table>");
            out.println("<thead>");
            out.println("<tr>");
            out.println("<th>Student ID</th><th>Student Name</th><th>Date of Birth</th><th>UID</th><th>Parent Name</th>");
            out.println("<th>Grade</th><th>Section</th><th>Total Marks</th><th>Percentage</th><th>Remarks</th>");
            out.println("</tr>");
            out.println("</thead>");
            out.println("<tbody>");
            for (String[] result : resultsList) {
                out.println("<tr>");
                out.println("<td>" + result[0] + "</td>"); // Student ID
                out.println("<td>" + result[1] + "</td>"); // Student Name
                out.println("<td>" + result[2] + "</td>"); // Date of Birth
                out.println("<td>" + result[3] + "</td>"); // UID
                out.println("<td>" + result[4] + "</td>"); // Parent Name
                out.println("<td>" + result[5] + "</td>"); // Grade
                out.println("<td>" + result[6] + "</td>"); // Section
                out.println("<td>" + result[37] + "</td>"); // Total Marks
                out.println("<td>" + result[38] + "</td>"); // Percentage
                out.println("<td>" + result[40] + "</td>"); // Remarks
                out.println("</tr>");
            }
            out.println("</tbody>");
            out.println("</table>");
        }
    }
%>
</body>
</html>
