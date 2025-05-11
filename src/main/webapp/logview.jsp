<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>

<html>
<head>
    <title>Admin Log Viewer</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .log-container {
            background-color: #f4f4f4;
            padding: 10px;
            border: 1px solid #ccc;
            max-height: 500px;
            overflow-y: auto;
            white-space: pre-wrap;
        }
        p {
            margin: 0;
        }
    </style>
</head>
<body>
<h2>Application Logs</h2>
<div class="log-container">
    <%
        List<String> logs = new ArrayList<>();

       
        String logFilePath = "D:/IP/proj/Online-Exam-System/src/main/webapp/logincreds/log.txt";

        try (BufferedReader reader = Files.newBufferedReader(Paths.get(logFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                logs.add(line);
            }
        } catch (IOException e) {
            logs.add("Error reading log file: " + e.getMessage());
        }

        if (!logs.isEmpty()) {
            for (String log : logs) {
    %>
    <p><%= log %></p>
    <%
        }
    } else {
    %>
    <p>No logs to display.</p>
    <%
        }
    %>
</div>
</body>
</html>
