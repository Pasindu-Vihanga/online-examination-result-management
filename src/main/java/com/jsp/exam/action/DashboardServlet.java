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

    // Path to the file storing user details
    private static final String USERS_FILE = "data/users.txt";
    private static final String UPLOAD_DIR = "uploads"; // Directory for storing uploaded images

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set content type
        response.setContentType("text/html");

        // Read user data
        List<String> userDetails = readUserDetails();

        // Generate dynamic HTML response
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html>");
        out.println("<html lang=\"en\">");
        out.println("<head>");
        out.println("<meta charset=\"UTF-8\">");
        out.println("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">");
        out.println("<title>Dashboard</title>");
        out.println("<link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">");
        out.println("</head>");
        out.println("<body>");
        out.println("<div class=\"container mt-5\">");
        out.println("<h1>Dashboard</h1>");

        // User details table
        out.println("<table class=\"table table-bordered\">");
        out.println("<thead><tr><th>Name</th><th>Email</th><th>Role</th></tr></thead>");
        out.println("<tbody>");
        for (String user : userDetails) {
            String[] details = user.split(",");
            if (details.length >= 3) {
                out.println("<tr><td>" + details[0] + "</td><td>" + details[1] + "</td><td>" + details[2] + "</td></tr>");
            }
        }
        out.println("</tbody>");
        out.println("</table>");

        // Update Member Details Form
        out.println("<div class=\"card mt-5\">");
        out.println("<div class=\"card-header\">Update Member Details</div>");
        out.println("<div class=\"card-body\">");
        out.println("<form method=\"POST\" action=\"dashboard\" enctype=\"multipart/form-data\">");
        out.println("<div class=\"mb-3\"><label for=\"name\" class=\"form-label\">Name</label>");
        out.println("<input type=\"text\" class=\"form-control\" id=\"name\" name=\"name\" required></div>");
        out.println("<div class=\"mb-3\"><label for=\"email\" class=\"form-label\">Email</label>");
        out.println("<input type=\"email\" class=\"form-control\" id=\"email\" name=\"email\" required></div>");
        out.println("<div class=\"mb-3\"><label for=\"fileInput\" class=\"form-label\">Upload Photo</label>");
        out.println("<input type=\"file\" class=\"form-control\" id=\"fileInput\" name=\"photo\" accept=\".jpg,.png\" required></div>");
        out.println("<button type=\"submit\" class=\"btn btn-primary\">Submit</button>");
        out.println("</form>");
        out.println("</div>");
        out.println("</div>");

        out.println("</div>");
        out.println("</body>");
        out.println("</html>");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");

        // Handle file upload
        Part filePart = request.getPart("photo");
        String fileName = extractFileName(filePart);
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;

        // Ensure the upload directory exists
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        // Save the uploaded file
        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        // Add user details to the file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(USERS_FILE, true))) {
            writer.write(name + "," + email + "," + fileName);
            writer.newLine();
        }

        // Redirect back to the dashboard
        response.sendRedirect("dashboard");
    }

    private List<String> readUserDetails() throws IOException {
        List<String> userDetails = new ArrayList<>();
        File file = new File(USERS_FILE);
        if (file.exists()) {
            try (BufferedReader br = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = br.readLine()) != null) {
                    userDetails.add(line);
                }
            }
        }
        return userDetails;
    }

    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        for (String content : contentDisposition.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf("=") + 2, content.length() - 1);
            }
        }
        return "unknown";
    }
}
