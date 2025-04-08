package com.jsp.exam.action;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.HashMap;
import java.util.Map;

    @WebServlet("/manage")
    public class ManageServlet extends HttpServlet {

        // In-memory storage for members (simulating a database)
        private final Map<String, String> members = new HashMap<>();

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String action = request.getParameter("action");

            if ("addMember".equalsIgnoreCase(action)) {
                addMember(request, response);
            } else if ("removeMember".equalsIgnoreCase(action)) {
                removeMember(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
            }
        }

        private void addMember(HttpServletRequest request, HttpServletResponse response) throws IOException {
            String memberName = request.getParameter("memberName");
            String memberPassword = request.getParameter("memberPassword");

            if (memberName != null && !memberName.isEmpty() && memberPassword != null && !memberPassword.isEmpty()) {
                // Add to in-memory storage
                members.put(memberName, memberPassword);

                // Save member to the file (append mode)
                try (BufferedWriter writer = new BufferedWriter(
                        new FileWriter("D:/IP/proj/Examination/Online-Examinations-and-result-management-system/src/main/webapp/logincreds/admin.txt", true))) {
                    writer.write(memberName + "," + memberPassword);
                    writer.newLine(); // Ensure new credentials are written on a new line
                }

                // Respond to the user
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<!DOCTYPE html>");
                out.println("<html lang='en'>");
                out.println("<head>");
                out.println("<meta charset='UTF-8'>");
                out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
                out.println("<title>Registration response</title>");
                out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css' rel='stylesheet'>");
                out.println("</head>");
                out.println("<body>");
                out.println("<div class='container mt-5'>");
                out.println("<html><body>");
                out.println("<div class='alert alert-success text-center'>");
                out.println("<h3>Member added successfully!</h3>");
                out.println("<p>Username: " + memberName + "</p>");
                out.println("<a href='manage.jsp'>Back to Admin Panel</a>");
                out.println("</body></html>");
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Member name and password are required.");
            }
        }
        private void removeMember(HttpServletRequest request, HttpServletResponse response) throws IOException {
            String memberName = request.getParameter("memberName");

            // Check if the member exists
            if (memberName != null && !memberName.isEmpty() && members.containsKey(memberName)) {
                members.remove(memberName); // Remove from in-memory storage

                // Update the file to remove the member
                File file = new File("D:/IP/proj/Examination/Online-Examinations-and-result-management-system/src/main/webapp/logincreds/admin.txt");
                File tempFile = new File(file.getAbsolutePath() + ".tmp");

                try (BufferedReader reader = new BufferedReader(new FileReader(file));
                     BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        String[] memberData = line.split(",");
                        if (!memberData[0].equals(memberName)) { // Skip the line with the specified username
                            writer.write(line);
                            writer.newLine();
                        }
                    }
                }
                file.delete(); // Delete the old file
                tempFile.renameTo(file); // Rename temp file to the original file

                // Respond to the client
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<!DOCTYPE html>");
                out.println("<html lang='en'>");
                out.println("<head>");
                out.println("<meta charset='UTF-8'>");
                out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
                out.println("<title>Registration response</title>");
                out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css' rel='stylesheet'>");
                out.println("</head>");
                out.println("<body>");
                out.println("<div class='container mt-5'>");
                out.println("<html><body>");
                out.println("<div class='alert alert-success text-center'>");
                out.println("<h3>Member removed successfully!</h3>");
                out.println("<p>Username: " + memberName + "</p>");
                out.println("<a href='manage.jsp'>Back to Admin Panel</a>");
                out.println("</body></html>");
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Username is invalid or does not exist.");
            }
        }

        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<!DOCTYPE html>");
            out.println("<html><body>");
            out.println("<h3>Admin Management Actions</h3>");
            out.println("<p>Use the forms provided in the Admin Panel to add or remove members.</p>");
            out.println("<a href='manage.jsp'>Back to Admin Panel</a>");
            out.println("</body></html>");
        }
    }


