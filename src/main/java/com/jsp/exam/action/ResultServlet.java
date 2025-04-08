package com.jsp.exam.action;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;

@WebServlet("/resultS")
public class ResultServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String indexNumber = request.getParameter("indexNumber");
        boolean found = false;

        try (BufferedReader reader = new BufferedReader(
                new FileReader("D:/IP/proj/Examination/Online-Examinations-and-result-management-system/src/main/webapp/logincreds/results.txt"))) {

            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");

                if (data[0].equals(indexNumber)) {
                    found = true;

                    // Set all data as request attributes
                    request.setAttribute("studentName", data[1]);
                    request.setAttribute("dob", data[2]);
                    request.setAttribute("uid", data[3]);
                    request.setAttribute("fatherName", data[4]);
                    request.setAttribute("class", data[5]);
                    request.setAttribute("section", data[6]);

                    // Store subjects in a 2D array (or list of objects in real cases)
                    int subjectCount = 7;
                    String[][] subjects = new String[subjectCount][6];
                    int startIndex = 7;

                    for (int i = 0; i < subjectCount; i++) {
                        for (int j = 0; j < 6; j++) {
                            subjects[i][j] = data[startIndex + i * 6 + j];
                        }
                    }
                    request.setAttribute("subjects", subjects);

                    request.setAttribute("spDict", data[startIndex + subjectCount * 6]);
                    request.setAttribute("moralGrade", data[data.length - 1]);
                    request.setAttribute("obtained", data[data.length - 5]);
                    request.setAttribute("totalMarks", data[data.length - 4]);
                    request.setAttribute("percentage", data[data.length - 3]);
                    request.setAttribute("rank", data[data.length - 2]);

                    break;
                }
            }
        }

        if (found) {
            request.getRequestDispatcher("resultview.jsp").forward(request, response);
        } else {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<h3 style='color:red;'>No result found for Index Number: " + indexNumber + "</h3>");
            out.println("<a href='index.jsp'>Back</a>");
        }
    }
}
