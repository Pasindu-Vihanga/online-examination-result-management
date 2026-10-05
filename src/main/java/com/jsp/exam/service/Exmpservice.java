package com.jsp.exam.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import com.jsp.exam.util.DBConnection;

public class Exmpservice {

    public Exmpservice() {
    }

    public Exmpservice(String ignoredPath) {
    }

    public boolean startExamSession(String studentId, String examCode) {
        // Session tracking
        return true;
    }

    public boolean submitAnswer(String studentId, String examCode, Map<String, String> answers) {
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
            System.err.println("[Exmpservice.submitAnswer] Error: " + e.getMessage());
            return false;
        }
    }

    public int generateMarks() {
        Random random = new Random();
        return random.nextInt(101);
    }

    public boolean endExamSession(String studentId, String examCode) {
        int marks = generateMarks();
        String sql = "INSERT INTO student_results (student_id, subject_code, marks) VALUES (?, ?, ?) " +
                "ON DUPLICATE KEY UPDATE marks = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, studentId);
            ps.setString(2, examCode);
            ps.setInt(3, marks);
            ps.setInt(4, marks);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[Exmpservice.endExamSession] Error: " + e.getMessage());
            return false;
        }
    }

    public int getStudentMarks(String studentId, String examCode) {
        String sql = "SELECT marks FROM student_results WHERE student_id = ? AND subject_code = ? ORDER BY id DESC LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, studentId);
            ps.setString(2, examCode);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("marks");
                }
            }
        } catch (SQLException e) {
            System.err.println("[Exmpservice.getStudentMarks] Error: " + e.getMessage());
        }
        return -1;
    }
}
