package com.jsp.exam.action;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet("/manage")
public class ManageServlet extends HttpServlet {

    private static final String MEMBER_FILE_PATH = "D:/IP/proj/Examination/Online-Examinations-and-result-management-system/src/main/webapp/logincreds/admin.txt";
    private static final String STUDENT_CREDS_PATH = "D:/IP/proj/Examination/Online-Examinations-and-result-management-system/src/main/webapp/logincreds/credentials.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        String type = request.getParameter("type"); // member or student (for removal)
        String name = request.getParameter("name");
        String password = request.getParameter("password");

        PrintWriter out = response.getWriter();
        String message;

        try {
            if ("addMember".equals(action)) {
                message = addMember(name, password);
            } else if ("remove".equals(action)) {
                if ("member".equals(type)) {
                    message = removeMember(name);
                } else if ("student".equals(type)) {
                    message = removeStudent(name);
                } else {
                    message = "Invalid type specified for removal.";
                }
            } else {
                message = "Invalid action specified.";
            }
        } catch (IOException e) {
            message = "An error occurred: " + e.getMessage();
        }

        // Output feedback and redirect
        out.println("<html><head><meta http-equiv='refresh' content='3;URL=manage.jsp'/>");
        out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css' rel='stylesheet'>");
        out.println("</head><body>");
        out.println("<div class='container mt-5'>");
        out.println("<div class='alert alert-info text-center'>" + message + "</div>");
        out.println("</div></body></html>");
    }

    private String addMember(String username, String password) throws IOException {
        List<String> lines = Files.readAllLines(Paths.get(MEMBER_FILE_PATH));
        for (String line : lines) {
            if (line.trim().startsWith(username.trim() + ",")) {
                return "Member <strong>" + username + "</strong> already exists.";
            }
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(MEMBER_FILE_PATH, true))) {
            writer.write(username.trim() + "," + password.trim());
            writer.newLine();
        }
        return "Member <strong>" + username + "</strong> added successfully.";
    }

    private String removeMember(String username) throws IOException {
        List<String> lines = Files.readAllLines(Paths.get(MEMBER_FILE_PATH));
        List<String> updatedLines = lines.stream()
                .filter(line -> !line.trim().startsWith(username.trim() + ","))
                .collect(Collectors.toList());

        if (lines.size() == updatedLines.size()) {
            return "Member <strong>" + username + "</strong> not found.";
        }

        Files.write(Paths.get(MEMBER_FILE_PATH), updatedLines, StandardOpenOption.TRUNCATE_EXISTING);
        return "Member <strong>" + username + "</strong> removed successfully.";
    }

    private String removeStudent(String username) throws IOException {
        List<String> lines = Files.readAllLines(Paths.get(STUDENT_CREDS_PATH));
        List<String> updatedLines = lines.stream()
                .filter(line -> !line.trim().startsWith(username.trim() + ","))
                .collect(Collectors.toList());

        if (lines.size() == updatedLines.size()) {
            return "Student <strong>" + username + "</strong> not found.";
        }

        Files.write(Paths.get(STUDENT_CREDS_PATH), updatedLines, StandardOpenOption.TRUNCATE_EXISTING);
        return "Student <strong>" + username + "</strong> removed successfully.";
    }

}
