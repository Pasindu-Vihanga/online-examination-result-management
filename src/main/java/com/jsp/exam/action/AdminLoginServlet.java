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

@WebServlet("/memberslogin")
public class AdminLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Get user input
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        boolean isAuthenticated = false;
        String role = null; // To store the user role if authentication is successful

        // Verify credentials from the stored data file
        try (BufferedReader reader = new BufferedReader(new FileReader("D:/IP/proj/Examination/Online-Examinations-and-result-management-system/src/main/webapp/logincreds/admin.txt"))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] credentials = line.split(",");
                // Validate username and password
                if (credentials.length >=2 && credentials[0].equals(username) && credentials[1].equals(password)) {
                    isAuthenticated = true;
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
            out.println("<p>Welcome, <strong>" + username + "</strong> </p>");
            out.println("<a href='manage.jsp' class='btn btn-success'>Enter</a>");
            out.println("</div>");
        } else {
            out.println("<div class='alert alert-danger text-center'>");
            out.println("<h3>You have not right permission to access this page!</h3>");
            out.println("<a href='login.jsp' class='btn btn-secondary'>Back to Login</a>");
            out.println("</div>");
        }

        out.println("</div>");
        out.println("<script src='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js'></script>");
        out.println("</body>");
        out.println("</html>");
    }
}
