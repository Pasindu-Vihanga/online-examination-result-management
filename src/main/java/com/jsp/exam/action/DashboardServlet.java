package com.jsp.exam.action;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/dashboard")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 5,  // 5MB
        maxRequestSize = 1024 * 1024 * 10 // 10MB
)
public class DashboardServlet extends HttpServlet {

    private static final String USERS_FILE = "D:/IP/proj/Examination/Online-Examinations-and-result-management-system/src/main/webapp/logincreds/studentinfo.txt";
    private static final String UPLOAD_DIR = "src/main/webapp/pictures/user";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");


        // Handle photo upload
        Part filePart = request.getPart("photo");
        String fileName = (filePart != null) ? extractFileName(filePart) : "";
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        if (filePart != null && fileName != null && !fileName.isEmpty()) {
            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);
        }

        // Save user details (append)
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(USERS_FILE, true))) {
            writer.write(name + "," + email + "," + password + "," + address + "," + telephone + "," + fileName);
            writer.newLine();
        }

        response.sendRedirect("index.jsp"); // redirect to home or dashboard
    }

    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        for (String content : contentDisposition.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 2, content.length() - 1);
            }
        }
        return null;
    }
}
