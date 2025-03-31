package com.jsp.exam.action;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Get user input
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        boolean isAuthenticated = false;
        String role = null; // To store the user role if authentication is successful

        // Verify credentials from the stored data file
        try (BufferedReader reader = new BufferedReader(new FileReader("D:/IP/proj/Exam/src/main/webapp/logincreds/credentials.txt"))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] credentials = line.split(",");
                // Use the specified condition to validate username and password
                if (credentials.length >= 4 && credentials[1].equals(username) && credentials[2].equals(password)) {
                    isAuthenticated = true;
                    role = credentials[0]; // Extract role if authentication is successful
                    break;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Response to user
        out.println("<html><body>");
        if (isAuthenticated) {
            out.println("<h3>Login successful!</h3>");
            out.println("<p>Welcome, " + username + " (" + role + ")</p>");
            if ("student".equalsIgnoreCase(role)) {
                out.println("<a href='dashboard.jsp'>Go to Student Dashboard</a>");
            } else if ("member".equalsIgnoreCase(role)) {
                out.println("<a href='member.jsp'>Go to Member Page</a>");
            }
        } else {
            out.println("<h3>Invalid username or password. Please try again.</h3>");
            out.println("<a href='login.jsp'>Back to Login</a>");
        }
        out.println("</body></html>");
    }
}
