<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Registered Users</title>
</head>
<body>
<h2>Registered Users</h2>

<%
    // Path to the file where user data is saved (relative to the web app root)
    String filePath = getServletContext().getRealPath("/logincreds/studentinfo.txt");
    File file = new File(filePath);

    // Check if the file exists
    if (!file.exists()) {
        out.println("<p>File not found!</p>");
    } else {
        // List to hold the user data
        List<String> usersList = new ArrayList<>();

        // Read the file and store each line
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                usersList.add(line);
            }
        } catch (IOException e) {
            out.println("<p>Error reading the file: " + e.getMessage() + "</p>");
        }

        // Display the user data
        if (usersList.isEmpty()) {
            out.println("<p>No users found!</p>");
        } else {
            out.println("<ul>");
            for (String userData : usersList) {
                out.println("<li>" + userData + "</li>");
            }
            out.println("</ul>");
        }
    }
%>

</body>
</html>