package com.jsp.exam.action;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Get user input
        String role = request.getParameter("role"); // Fetch the 'role' value
        String username = request.getParameter("name"); // Fetch the 'name' value
        String password = request.getParameter("password"); // Fetch the 'password' value
        String email = request.getParameter("email"); // Fetch the 'email' value

        // Validate inputs (optional)
        if (role == null || username == null || password == null || email == null ||
                role.isEmpty() || username.isEmpty() || password.isEmpty() || email.isEmpty()) {
            out.println("<html><body>");
            out.println("<h3>Error: All fields are required!</h3>");
            out.println("<a href='registration.jsp'>Back to Registration</a>");
            out.println("</body></html>");
            return;
        }

        // Save data to a text file
        try (FileWriter writer = new FileWriter("D:/IP/proj/Examination/Online-Examinations-and-result-management-system/src/main/webapp/logincreds/credentials.txt", true)) {
            writer.write(role + "," + username + "," + password + "," + email + "\n");
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Response to user
        out.println("<html><body>");
        out.println("<h3>Registration successful!</h3>");
        out.println("<a href='login.jsp'>Go to Login</a>");
        out.println("</body></html>");
    }
}
