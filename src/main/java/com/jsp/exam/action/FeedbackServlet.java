package com.jsp.exam.action;

import com.jsp.exam.model.feedbackmodel;
import com.jsp.exam.service.feedbackservice;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

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
        String rating = request.getParameter("rating");

        feedbackmodel feedback = new feedbackmodel(name, email, message, rating);

        if (feedback.isValid()) {
            feedbackService.createFeedback(feedback);
            response.sendRedirect("feedback.jsp?submitted=true");
        } else {
            response.sendRedirect("feedback.jsp?error=invalid");
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String name = request.getParameter("name");

        if (name != null && !name.trim().isEmpty()) {
            feedbackService.removeFeedback(name);
        }

        response.sendRedirect("feedbackrecords.jsp?deleted=true");
    }
}
