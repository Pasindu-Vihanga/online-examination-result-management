package com.jsp.exam.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import com.jsp.exam.model.ExamPaper;
import com.jsp.exam.util.DBConnection;

public class Examservice {

    public Examservice() {
    }

    public Examservice(String ignoredPath) {
    }

    public boolean createExamQuestion(String examTitle, String faculty, String moduleCode, String duration,
                                      String numberQuestions, String questionTitle, String optionA,
                                      String optionB, String optionC, String optionD, String questionNumber,
                                      String correctAnswer) {
        String sql = "INSERT INTO questions (exam_type, faculty, subject_code, duration_mins, total_marks, " +
                "question_text, option1, option2, option3, option4, question_no, correct_answer) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, examTitle);
            ps.setString(2, faculty);
            ps.setString(3, moduleCode);
            int dur = 30;
            try { dur = Integer.parseInt(duration.trim()); } catch (Exception ignored) {}
            ps.setInt(4, dur);
            int total = 10;
            try { total = Integer.parseInt(numberQuestions.trim()); } catch (Exception ignored) {}
            ps.setInt(5, total);
            ps.setString(6, questionTitle);
            ps.setString(7, optionA);
            ps.setString(8, optionB);
            ps.setString(9, optionC);
            ps.setString(10, optionD);
            ps.setString(11, questionNumber);
            ps.setString(12, correctAnswer);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[Examservice.createExamQuestion] Error: " + e.getMessage());
            return false;
        }
    }

    public boolean deleteExam(String examCode) {
        if (examCode == null || examCode.trim().isEmpty()) {
            return false;
        }
        String sql = "DELETE FROM questions WHERE subject_code = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, examCode);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[Examservice.deleteExam] Error: " + e.getMessage());
            return false;
        }
    }

    public boolean updateExamQuestion(String examTitle, String faculty, String moduleCode, String duration,
                                      String numberQuestions, String questionTitle, String optionA,
                                      String optionB, String optionC, String optionD, String correctAnswer,
                                      String questionNumber) {
        String sql = "UPDATE questions SET exam_type = ?, faculty = ?, duration_mins = ?, total_marks = ?, " +
                "question_text = ?, option1 = ?, option2 = ?, option3 = ?, option4 = ?, correct_answer = ? " +
                "WHERE subject_code = ? AND question_no = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, examTitle);
            ps.setString(2, faculty);
            int dur = 30;
            try { dur = Integer.parseInt(duration.trim()); } catch (Exception ignored) {}
            ps.setInt(3, dur);
            int total = 10;
            try { total = Integer.parseInt(numberQuestions.trim()); } catch (Exception ignored) {}
            ps.setInt(4, total);
            ps.setString(5, questionTitle);
            ps.setString(6, optionA);
            ps.setString(7, optionB);
            ps.setString(8, optionC);
            ps.setString(9, optionD);
            ps.setString(10, correctAnswer);
            ps.setString(11, moduleCode);
            ps.setString(12, questionNumber);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[Examservice.updateExamQuestion] Error: " + e.getMessage());
            return false;
        }
    }

    public ExamPaper getExamDetails(String examCode) {
        if (examCode == null) return null;
        String sql = "SELECT exam_type, faculty, subject_code, duration_mins, total_marks " +
                "FROM questions WHERE subject_code = ? LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, examCode);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new ExamPaper(
                            rs.getString("exam_type"),
                            rs.getString("faculty"),
                            rs.getString("subject_code"),
                            String.valueOf(rs.getInt("duration_mins")),
                            String.valueOf(rs.getInt("total_marks"))
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("[Examservice.getExamDetails] Error: " + e.getMessage());
        }
        return null;
    }

    public List<String[]> getExamQuestions(String examCode) {
        List<String[]> questionList = new ArrayList<>();
        String sql;
        if (examCode != null && !examCode.trim().isEmpty()) {
            sql = "SELECT exam_type, faculty, subject_code, duration_mins, total_marks, " +
                    "question_text, option1, option2, option3, option4, question_no, correct_answer " +
                    "FROM questions WHERE subject_code = ? ORDER BY id ASC";
        } else {
            sql = "SELECT exam_type, faculty, subject_code, duration_mins, total_marks, " +
                    "question_text, option1, option2, option3, option4, question_no, correct_answer " +
                    "FROM questions ORDER BY id ASC";
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            if (examCode != null && !examCode.trim().isEmpty()) {
                ps.setString(1, examCode);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String[] parts = new String[12];
                    parts[0] = rs.getString("exam_type");
                    parts[1] = rs.getString("faculty");
                    parts[2] = rs.getString("subject_code");
                    parts[3] = String.valueOf(rs.getInt("duration_mins"));
                    parts[4] = String.valueOf(rs.getInt("total_marks"));
                    parts[5] = rs.getString("question_text");
                    parts[6] = rs.getString("option1");
                    parts[7] = rs.getString("option2");
                    parts[8] = rs.getString("option3");
                    parts[9] = rs.getString("option4");
                    parts[10] = rs.getString("question_no");
                    parts[11] = rs.getString("correct_answer");
                    questionList.add(parts);
                }
            }
        } catch (SQLException e) {
            System.err.println("[Examservice.getExamQuestions] Error: " + e.getMessage());
        }

        return questionList;
    }
}
