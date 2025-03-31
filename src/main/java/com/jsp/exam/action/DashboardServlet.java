package com.jsp.exam.action;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    // Path to the file storing user details
    private static final String USERS_FILE = "data/users.txt";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set content type
        response.setContentType("text/html");

        // Read user data from the files
        List<String> userDetails = readUserDetails();

        // Generate HTML response
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
        out.println("</div>");
        out.println("</body>");
        out.println("</html>");
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
}
