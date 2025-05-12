package com.jsp.exam.action;

import com.jsp.exam.model.AdminLog;
import com.jsp.exam.service.AdminLogger;
import com.jsp.exam.service.Adminservice;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/registerAD")
public class AdminRegServlet extends HttpServlet {
    private final Adminservice adminservice = new Adminservice();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Correct parameter retrieval (fixing form input names)
        String regusername = request.getParameter("username");
        String regpassword = request.getParameter("password");
        String confirm = request.getParameter("confirm_password"); 

        // Debugging logs
        System.out.println("Received Username: " + regusername);
        System.out.println("Received Password: " + regpassword);
        System.out.println("Received Confirm Password: " + confirm);

        // Trim values to prevent spaces causing issues
        regusername = regusername != null ? regusername.trim() : null;
        regpassword = regpassword != null ? regpassword.trim() : null;
        confirm = confirm != null ? confirm.trim() : null;

        // Check if any field is empty/null
        if (regusername == null || regpassword == null || confirm == null || regusername.isEmpty() || regpassword.isEmpty() || confirm.isEmpty()) {
            request.setAttribute("error", "Invalid input. All fields are required.");
            request.getRequestDispatcher("errornull.jsp").forward(request, response);
            return;
        }

        // Password confirmation check
        if (!regpassword.equals(confirm)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // Path to the text file for storing credentials
        String filePath = "D:/IP/proj/Online-Exam-System/src/main/webapp/logincreds/admin.txt";
        AdminLog newAdmin = new AdminLog(regusername, regpassword, filePath);

        boolean success = adminservice.register(newAdmin);

        // Redirect based on registration success/failure
        if (success) {
            AdminLogger.log("D:/IP/proj/Online-Exam-System/src/main/webapp/logincreds/log.txt",regusername,"Registration successful");
            response.setContentType("text/html");
            response.getWriter().println("<div class='alert alert-success text-center'>");
            response.getWriter().println("<h3>Registration successful!</h3>");
            response.getWriter().println("<p>Welcome, <strong>" + regusername + "</strong></p>");
            response.getWriter().println("</div>");
            response.sendRedirect("adminlogin.jsp");
        } else {
            AdminLogger.log("D:/IP/proj/Online-Exam-System/src/main/webapp/logincreds/log.txt",regusername,"Registration failed");
            response.setContentType("text/html");
            response.getWriter().println("<div class='alert alert-danger text-center'>");
            response.getWriter().println("<h3>Registration failed!</h3>");
            response.getWriter().println("<p>Username might already be taken.</p>");
            response.getWriter().println("<a href='register.jsp' class='btn btn-warning'>Try Again</a>");
            response.getWriter().println("</div>");
            response.sendRedirect("adminlogin.jsp");
        }



    }
}
