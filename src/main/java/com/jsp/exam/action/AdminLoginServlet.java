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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Get user input
        String username = request.getParameter("memusername");
        String password = request.getParameter("mempassword");

        boolean isAuthenticated = false;

        // Verify credentials from the stored file
        String filePath = "D:/IP/proj/Examination/Online-Examinations-and-result-management-system/src/main/webapp/logincreds/admin.txt";
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] credentials = line.split(",");
                if (credentials.length >= 2) {
                    if (credentials[0].trim().equals(username) && credentials[1].trim().equals(password)) {
                        isAuthenticated = true;
                        break;
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Output HTML response
        out.println("<!DOCTYPE html>");
        out.println("<html lang='en'>");
        out.println("<head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
        out.println("<title>Admin Login</title>");
        out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css' rel='stylesheet'>");
        out.println("</head>");
        out.println("<body>");
        out.println("<div class='container mt-5'>");

        if (isAuthenticated) {
            out.println("<div class='alert alert-success text-center'>");
            out.println("<h3>Login successful!</h3>");
            out.println("<p>Welcome, <strong>" + username + "</strong></p>");
            out.println("<a href='manage.jsp' class='btn btn-success mt-3'>Enter Admin Panel</a>");
            out.println("</div>");
        } else {
            out.println("<div class='alert alert-danger text-center'>");
            out.println("<h3>Access Denied!</h3>");
            out.println("<p>Incorrect username or password.</p>");
            out.println("<a href='login.jsp' class='btn btn-secondary mt-3'>Back to Login</a>");
            out.println("</div>");
        }

        out.println("</div>");
        out.println("<script src='https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js'></script>");
        out.println("</body>");
        out.println("</html>");
    }
}
