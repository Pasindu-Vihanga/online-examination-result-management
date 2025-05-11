package com.jsp.exam.action;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import com.jsp.exam.service.Examservice;

@WebServlet("/DeleteExam")
public class DeleteExamServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String examCode = request.getParameter("examCode");
        System.out.println("[DeleteExam] Received request to delete exam: " + examCode);

        Examservice examService = new Examservice();

        boolean deleted = examService.deleteExam(examCode);

        if (deleted) {
            response.sendRedirect("Exmindex.jsp?delete=success");
        } else {
            response.sendRedirect("Exmindex.jsp?delete=failure");
        }
    }
}
