package com.jsp.exam.action;

import com.jsp.exam.model.AdminLog;
import com.jsp.exam.service.AdminLogger;
import com.jsp.exam.service.AdminMGservice;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/manage")
public class ManageServlet extends HttpServlet {
    private AdminMGservice adminService = new AdminMGservice();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action"); // Can be "create", "read", "update", or "delete"
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        boolean result = false;
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");

        out.println("<!DOCTYPE html>");
        out.println("<html lang='en'><head><title>Admin Management</title>");
        out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css' rel='stylesheet'>");
        out.println("</head><body><div class='container mt-5'>");

        HttpSession session = request.getSession();
        session.setAttribute("inputUsername", username);

        switch (action) {
            case "create":
                AdminLog newAdmin = new AdminLog(username, password, "D:/IP/proj/Online-Exam-System/src/main/webapp/logincreds/admin.txt");
                result = adminService.createAdmin(newAdmin);
                AdminLogger.log("D:/IP/proj/Online-Exam-System/src/main/webapp/logincreds/log.txt", username,
                        result ? "Admin created successfully" : "Failed to create admin");
                out.println(result ? "<div class='alert alert-success'>Admin created successfully!</div>"
                        : "<div class='alert alert-danger'>Failed to create admin!</div>");
                break;

            case "update":
                AdminLog updatedAdmin = new AdminLog(username, password, "D:/IP/proj/Online-Exam-System/src/main/webapp/logincreds/admin.txt");
                result = adminService.updateAdmin(username, password);
                AdminLogger.log("D:/IP/proj/Online-Exam-System/src/main/webapp/logincreds/log.txt", username,
                        result ? "Admin credentials updated successfully" : "Failed to update admin");
                out.println(result ? "<div class='alert alert-success'>Admin updated successfully!</div>"
                        : "<div class='alert alert-danger'>Failed to update admin!</div>");
                break;

            case "delete":
                result = adminService.deleteAdmin(username);
                AdminLogger.log("D:/IP/proj/Online-Exam-System/src/main/webapp/logincreds/log.txt", username,
                        result ? "Admin deleted successfully" : "Failed to delete admin");
                out.println(result ? "<div class='alert alert-success'>Admin deleted successfully!</div>"
                        : "<div class='alert alert-danger'>Failed to delete admin!</div>");
                break;

            case "read":
                List<AdminLog> admins = adminService.readAdmin();
                AdminLogger.log("D:/IP/proj/Online-Exam-System/src/main/webapp/logincreds/log.txt", username, "Admin list viewed");
                out.println("<div class='container mt-3'>");
                out.println("<h4 class='text-center mb-2'>Admin List</h4>");
                out.println("<div class='card p-2'>");
                out.println("<div class='card-body p-1'>");

                if (admins != null && !admins.isEmpty()) {
                    out.println("<ul class='list-group list-group-flush'>");
                    for (AdminLog admin : admins) {
                        out.println("<li class='list-group-item d-flex align-items-center p-1' style='display: flex; justify-content: space-between;'>");
                        out.println("<span class='small'>" + admin.getUsername() + "</span>");
                        out.println("<span class='badge bg-primary ms-1'>Admin</span>");
                        out.println("</li>");
                    }
                    out.println("</ul>");
                } else {
                    out.println("<p class='text-center text-danger small'>No admins found.</p>");
                }

                out.println("</div></div></div>");
                break;

            default:
                AdminLogger.log("D:/IP/proj/Online-Exam-System/src/main/webapp/logincreds/log.txt", username, "Invalid action attempted");
                out.println("<div class='alert alert-warning'>Invalid action!</div>");
                break;
        }

        out.println("<a href='manage.jsp' class='btn btn-secondary mt-3'>Back to Admin Panel</a>");
        out.println("<a href='logview.jsp' class ='btn btn-secondary mt-3'>Log View</a>");
        out.println("</div></body></html>");
        out.close();
    }
}
