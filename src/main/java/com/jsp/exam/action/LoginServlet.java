package com.jsp.exam.action;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final String CREDENTIAL_FILE = "D:/IP/proj/Examination/Online-Examinations-and-result-management-system/src/main/webapp/logincreds/credentials.txt"; // at project root

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {

            String inputUsername = request.getParameter("username");
            String inputPassword = request.getParameter("password");

            boolean loginSuccess = false;

            try (BufferedReader reader = new BufferedReader(new FileReader(CREDENTIAL_FILE))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split(",");
                    if (parts.length == 3) {
                        String fileUser = parts[0];
                        String filePass = parts[1];
                        if (fileUser.equals(inputUsername) && filePass.equals(inputPassword)) {
                            loginSuccess = true;
                            break;
                        }
                    }
                }
            }

            response.setContentType("text/html");
            PrintWriter out = response.getWriter();

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

            if (loginSuccess) {
                out.println("<div class='alert alert-success text-center'>");
                out.println("<h3>Login successful!</h3>");
                out.println("<p>Welcome, <strong>" + inputUsername + "</strong></p>");
                out.println("<a href='dashboard.jsp' class='btn btn-primary'>Go to Dashboard</a>");
                out.println("<a href='login.jsp' class='btn btn-secondary'>Back to Login</a>");
                out.println("</div>");
            } else {
                out.println("<div class='alert alert-danger text-center'>");
                out.println("<h3>Credentials not found. Please register!</h3>");
                out.println("<a href='registration.jsp' class='btn btn-warning'>Register Here</a>");
                out.println("<a href='login.jsp' class='btn btn-secondary'>Back to Login</a>");
                out.println("</div>");
            }
        }
    }


