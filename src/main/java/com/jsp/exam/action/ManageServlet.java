package com.jsp.exam.action;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.HashMap;
import java.util.Map;

public class ManageServlet {
    @WebServlet("/adminManagement")
    public class AdminManagementServlet extends HttpServlet {

        // In-memory storage for members (simulating a database)
        private final Map<String, String> members = new HashMap<>();

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String action = request.getParameter("action");

            if ("addMember".equals(action)) {
                addMember(request, response);
            } else if ("removeMember".equals(action)) {
                removeMember(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
            }
        }

        private void addMember(HttpServletRequest request, HttpServletResponse response) throws IOException {
            String memberName = request.getParameter("memberName");
            String role = request.getParameter("role");

            if (memberName != null && !memberName.isEmpty() && role != null && !role.isEmpty()) {
                // Generate a unique Member ID (for simplicity, using the current timestamp)
                String memberId = "MEM" + System.currentTimeMillis();
                members.put(memberId, memberName + "," + role);

                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<h3>Member Added Successfully!</h3>");
                out.println("<p>Name: " + memberName + "</p>");
                out.println("<p>Role: " + role + "</p>");
                out.println("<p>Member ID: " + memberId + "</p>");
                out.println("<a href='adminPanel.jsp'>Back to Admin Panel</a>");
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Member name and role are required.");
            }
        }

        private void removeMember(HttpServletRequest request, HttpServletResponse response) throws IOException {
            String memberId = request.getParameter("memberId");

            if (memberId != null && !memberId.isEmpty() && members.containsKey(memberId)) {
                members.remove(memberId);

                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<h3>Member Removed Successfully!</h3>");
                out.println("<p>Member ID: " + memberId + "</p>");
                out.println("<a href='adminPanel.jsp'>Back to Admin Panel</a>");
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Member ID is invalid or does not exist.");
            }
        }

        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<h3>Admin Management Actions</h3>");
            out.println("<p>Use the forms provided in the Admin Panel to add or remove members.</p>");
            out.println("<a href='adminPanel.jsp'>Back to Admin Panel</a>");
        }
    }

}
