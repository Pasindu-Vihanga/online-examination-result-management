package com.jsp.exam.action;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

import com.jsp.exam.model.ExamPaper;
import com.jsp.exam.service.Examservice;

@WebServlet("/LoadExamServlet")
public class LoadExamPaperServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Examservice examService = new Examservice();
        List<ExamPaper> exams = new ArrayList<>();
        Set<String> seen = new HashSet<>();

        List<String[]> examData = examService.getExamQuestions(null); // Fetch all exams

        if (examData != null) {
            for (String[] parts : examData) {
                if (parts.length >= 5) {
                    String key = parts[0] + "|" + parts[2];
                    if (!seen.contains(key)) {
                        seen.add(key);
                        exams.add(new ExamPaper(parts[0], parts[1], parts[2], parts[3], parts[4]));
                    }
                }
            }
        }

        request.setAttribute("exams", exams);
        RequestDispatcher dispatcher = request.getRequestDispatcher("examList.jsp");
        dispatcher.forward(request, response);
    }
}
