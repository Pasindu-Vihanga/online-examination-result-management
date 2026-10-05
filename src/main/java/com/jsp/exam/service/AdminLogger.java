package com.jsp.exam.service;

import com.jsp.exam.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDateTime;

public class AdminLogger {

    public static void log(String ignoredPath, String username, String action) {
        if (username == null || username.trim().isEmpty()) {
            username = "System";
        }
        if (action == null || action.trim().isEmpty()) {
            action = "Unknown Action";
        }

        // Print to console log
        System.out.println("[ADMIN_LOG " + LocalDateTime.now() + "] Admin: " + username + " | Action: " + action);

        // Store into MySQL database
        String sql = "INSERT INTO admin_logs (username, action) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, action);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("[AdminLogger] DB Log Error: " + e.getMessage());
        }
    }
}
