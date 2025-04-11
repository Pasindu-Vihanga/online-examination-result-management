package com.jsp.exam.action;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.util.logging.Logger;
import java.util.logging.Level;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    // Logger for tracking events and errors
    private static final Logger LOGGER = Logger.getLogger(DashboardServlet.class.getName());

    // File to store student information
    private static final String USERS_FILE = "D:/IP/proj/Examination/Online-Examinations-and-result-management-system/src/main/webapp/logincreds/studentinfo.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");

        // Validate form data
        if (name == null || email == null || password == null || address == null || telephone == null ||
                name.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty() ||
                address.trim().isEmpty() || telephone.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "All fields are required!");
            return;
        }

        // Save details to the file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(USERS_FILE, true))) {
            writer.write(name + "," + email + "," + password + "," + address + "," + telephone);
            writer.newLine();
            LOGGER.log(Level.INFO, "User information saved: {0}", name);
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error writing to file", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while saving the data.");
            return;
        }

        // Respond with a Bootstrap-styled page
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html>");
        out.println("<html lang='en'>");
        out.println("<head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
        out.println("<title>Registration Response</title>");
        out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css' rel='stylesheet'>");
        out.println("</head>");
        out.println("<body>");
        out.println("<div class='container mt-5'>");
        out.println("<div class='alert alert-success text-center'>");
        out.println("<h3>Registration Successful!</h3>");
        out.println("<a href='dashboard.jsp' class='btn btn-primary'>Back</a>");
        out.println("</div>");
        out.println("</div>");
        out.println("<script src='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js'></script>");
        out.println("</body>");
        out.println("</html>");
    }
}
