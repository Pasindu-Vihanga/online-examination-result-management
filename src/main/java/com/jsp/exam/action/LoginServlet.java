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
        try (BufferedReader reader = new BufferedReader(new FileReader("D:/IP/proj/Examination/Online-Examinations-and-result-management-system/src/main/webapp/logincreds/credentials.txt"))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] credentials = line.split(",");
                // Validate username and password
                if (credentials.length >= 4 && credentials[1].equals(username) && credentials[2].equals(password)) {
                    isAuthenticated = true;
                    role = credentials[0]; // Extract role if authentication is successful
                    break;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Bootstrap-styled response
        out.println("<!DOCTYPE html>");
        out.println("<html lang='en'>");
        out.println("<head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
        out.println("<title>Login Response</title>");
        out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css' rel='stylesheet'>");
        out.println("</head>");
        out.println("<body>");
        out.println("<div class='container mt-5'>");

        if (isAuthenticated) {
            out.println("<div class='alert alert-success text-center'>");
            out.println("<h3>Login successful!</h3>");
            out.println("<p>Welcome, <strong>" + username + "</strong> (" + role + ")</p>");
            if ("student".equalsIgnoreCase(role)) {
                out.println("<a href='dashboard.jsp' class='btn btn-primary'>Go to Student Dashboard</a>");
            } else if ("member".equalsIgnoreCase(role)) {
                out.println("<a href='member.jsp' class='btn btn-primary'>Go to Member Page</a>");
            }
            out.println("</div>");
        } else {
            out.println("<div class='alert alert-danger text-center'>");
            out.println("<h3>Credentials not found. Please register!</h3>");
            out.println("<a href='registration.jsp' class='btn btn-warning'>Register Here</a>");
            out.println("<a href='login.jsp' class='btn btn-secondary'>Back to Login</a>");
            out.println("</div>");
        }

        out.println("</div>");
        out.println("<script src='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js'></script>");
        out.println("</body>");
        out.println("</html>");
    }
}
