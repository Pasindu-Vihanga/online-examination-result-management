package com.jsp.exam.action;

import com.jsp.exam.model.feedbackmodel;
import com.jsp.exam.service.feedbackservice;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/feedbackS")
public class FeedbackServlet extends HttpServlet {

    private final feedbackservice feedbackService = new feedbackservice();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("delete".equalsIgnoreCase(action)) {
            handleDelete(request, response);
        } else {
            handleCreate(request, response);
        }
    }

    private void handleCreate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");
        String filename = request.getParameter("filename"); // Optional

        feedbackmodel feedback = new feedbackmodel(name, email, message, filename);

        if (feedback.isValid()) {
            feedbackService.createFeedback(feedback);
            request.setAttribute("successMessage", "Your feedback has been submitted successfully!");
        } else {
            request.setAttribute("error", "Please fill in all required fields.");
        }

        response.sendRedirect("feedback.jsp");
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String name = request.getParameter("name");

        if (name != null && !name.trim().isEmpty()) {
            boolean deleted = feedbackService.removeFeedback(name);
            if (deleted) {
                System.out.println("Feedback deleted for: " + name);
            } else {
                System.out.println("Failed to delete feedback for: " + name);
            }
        }

        response.sendRedirect("feedback.jsp");
    }
}
