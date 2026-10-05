package com.jsp.exam.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import com.jsp.exam.dsa.ResultLinkedList;
import com.jsp.exam.util.DBConnection;

public class ExamResultService {

    // Store student's answers in database
    public boolean storeAnswers(String studentId, String examCode, Map<String, String> answers) {
        StringBuilder sb = new StringBuilder();
        for (Map.Entry<String, String> entry : answers.entrySet()) {
            if (sb.length() > 0) sb.append("|");
            sb.append(entry.getKey()).append(":").append(entry.getValue());
        }

        String sql = "INSERT INTO student_attempts (student_name, subject_code, answers) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, studentId);
            ps.setString(2, examCode);
            ps.setString(3, sb.toString());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[storeAnswers] Error: " + e.getMessage());
            return false;
        }
    }

    // Get unique exam codes from questions table
    public List<String> getExamCodes() {
        List<String> examCodes = new ArrayList<>();
        String sql = "SELECT DISTINCT subject_code FROM questions ORDER BY subject_code ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                examCodes.add(rs.getString("subject_code"));
            }
        } catch (SQLException e) {
            System.err.println("[getExamCodes] Error: " + e.getMessage());
        }
        return examCodes;
    }

    // Evaluate student answers correctness
    public Map<String, Boolean> evaluateStudentAnswers(String studentId, String examCode) {
        Map<String, Boolean> resultMap = new HashMap<>();
        Map<String, String> correctAnswers = getCorrectAnswers(examCode);

        String sql = "SELECT answers FROM student_attempts WHERE student_name = ? AND subject_code = ? ORDER BY id DESC LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, studentId);
            ps.setString(2, examCode);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String raw = rs.getString("answers");
                    if (raw != null) {
                        String[] pairs = raw.split("\\|");
                        for (String pair : pairs) {
                            String[] kv = pair.split(":");
                            if (kv.length == 2) {
                                String qNum = kv[0].trim();
                                String userAns = kv[1].trim();
                                boolean isCorrect = userAns.equalsIgnoreCase(correctAnswers.getOrDefault(qNum, ""));
                                resultMap.put(qNum, isCorrect);
                            }
                        }
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("[evaluateStudentAnswers] Error: " + e.getMessage());
        }

        return resultMap;
    }

    // Get correct answers for given exam code
    public Map<String, String> getCorrectAnswers(String examCode) {
        Map<String, String> correctAnswers = new HashMap<>();
        String sql = "SELECT question_no, correct_answer FROM questions WHERE subject_code = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, examCode);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    correctAnswers.put(rs.getString("question_no").trim(), rs.getString("correct_answer").trim());
                }
            }
        } catch (SQLException e) {
            System.err.println("[getCorrectAnswers] Error: " + e.getMessage());
        }
        return correctAnswers;
    }

    // Calculate total correct score
    public int calculateScore(String studentId, String examCode) {
        Map<String, Boolean> results = evaluateStudentAnswers(studentId, examCode);
        return (int) results.values().stream().filter(Boolean::booleanValue).count();
    }

    // Save final exam result
    public boolean saveExamResult(String studentId, String examCode) {
        int score = calculateScore(studentId, examCode);
        String sql = "INSERT INTO student_results (student_id, subject_code, marks) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, studentId);
            ps.setString(2, examCode);
            ps.setInt(3, score);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[saveExamResult] Error: " + e.getMessage());
            return false;
        }
    }

    // Load all results into custom ResultLinkedList (DSA requirement) and return as List<String[]>
    public List<String[]> getAllResults() {
        ResultLinkedList list = new ResultLinkedList();
        String sql = "SELECT student_id, subject_code, marks FROM student_results ORDER BY id ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(rs.getString("student_id"), rs.getString("subject_code"), rs.getInt("marks"));
            }
        } catch (SQLException e) {
            System.err.println("[getAllResults] Error: " + e.getMessage());
        }
        return list.toListOfStringArrays();
    }

    // Delete a result
    public boolean deleteResult(String studentId, String examCode) {
        String sql = "DELETE FROM student_results WHERE student_id = ? AND subject_code = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, studentId);
            ps.setString(2, examCode);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[deleteResult] Error: " + e.getMessage());
            return false;
        }
    }

    // Update a result
    public boolean updateResult(String studentId, String examCode, int newScore) {
        String sql = "UPDATE student_results SET marks = ? WHERE student_id = ? AND subject_code = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, newScore);
            ps.setString(2, studentId);
            ps.setString(3, examCode);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[updateResult] Error: " + e.getMessage());
            return false;
        }
    }
}
