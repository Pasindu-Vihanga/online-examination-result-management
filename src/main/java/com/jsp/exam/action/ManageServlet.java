package com.jsp.exam.action;

import com.jsp.exam.model.AdminLog;
import com.jsp.exam.service.AdminLogger;
import com.jsp.exam.service.AdminMGservice;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/manage")
public class ManageServlet extends HttpServlet {
    private final AdminMGservice adminService = new AdminMGservice();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        boolean result = false;
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html lang='en'><head><meta charset='UTF-8'>");
        out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
        out.println("<title>Admin Management</title>");
        out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css' rel='stylesheet'>");
        out.println("</head><body class='bg-light'><div class='container mt-5'>");

        if (action == null) {
            action = "";
        }

        switch (action) {
            case "create":
                AdminLog newAdmin = new AdminLog(username, password, "MySQL");
                result = adminService.createAdmin(newAdmin);
                AdminLogger.log(null, username, result ? "Admin created successfully" : "Failed to create admin");
                out.println(result ? "<div class='alert alert-success'>Admin created successfully!</div>"
                        : "<div class='alert alert-danger'>Failed to create admin (username might already exist)!</div>");
                break;

            case "update":
                result = adminService.updateAdmin(username, password);
                AdminLogger.log(null, username, result ? "Admin credentials updated successfully" : "Failed to update admin");
                out.println(result ? "<div class='alert alert-success'>Admin updated successfully!</div>"
                        : "<div class='alert alert-danger'>Failed to update admin!</div>");
                break;

            case "delete":
                result = adminService.deleteAdmin(username);
                AdminLogger.log(null, username, result ? "Admin deleted successfully" : "Failed to delete admin");
                out.println(result ? "<div class='alert alert-success'>Admin deleted successfully!</div>"
                        : "<div class='alert alert-danger'>Failed to delete admin!</div>");
                break;

            case "read":
                List<AdminLog> admins = adminService.readAdmin();
                AdminLogger.log(null, username, "Admin list viewed");
                out.println("<div class='card shadow-sm p-4'>");
                out.println("<h4 class='mb-3'>Registered Admins</h4>");

                if (admins != null && !admins.isEmpty()) {
                    out.println("<ul class='list-group mb-3'>");
                    for (AdminLog admin : admins) {
                        out.println("<li class='list-group-item d-flex justify-content-between align-items-center'>");
                        out.println("<span><strong>" + admin.getUsername() + "</strong></span>");
                        out.println("<span class='badge bg-primary'>Admin</span>");
                        out.println("</li>");
                    }
                    out.println("</ul>");
                } else {
                    out.println("<p class='text-muted'>No admins found.</p>");
                }

                out.println("</div>");
                break;

            default:
                AdminLogger.log(null, username, "Invalid action attempted");
                out.println("<div class='alert alert-warning'>Invalid action!</div>");
                break;
        }

        out.println("<div class='mt-4'>");
        out.println("<a href='manage.jsp' class='btn btn-primary me-2'>Back to Admin Panel</a>");
        out.println("<a href='admindashboard.jsp' class='btn btn-outline-secondary'>Dashboard</a>");
        out.println("</div></div></body></html>");
        out.close();
    }
}
