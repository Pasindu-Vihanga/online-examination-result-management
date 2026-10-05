package com.jsp.exam.service;

import com.jsp.exam.model.AdminLog;
import com.jsp.exam.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Adminservice implements AdminAuthService {

    @Override
    public boolean authenticate(AdminLog adminLog) {
        if (!adminLog.isValid()) return false;

        boolean success = false;
        String sql = "SELECT id FROM admins WHERE username = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, adminLog.getUsername());
            ps.setString(2, adminLog.getPassword());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    success = true;
                }
            }
        } catch (SQLException e) {
            System.err.println("[Adminservice.authenticate] Error: " + e.getMessage());
        }

        AdminLogger.log(null, adminLog.getUsername(), success ? "Successful login" : "Failed login");
        return success;
    }

    @Override
    public boolean register(AdminLog adminLog) {
        if (!adminLog.isValid()) return false;

        if (usernameExists(adminLog.getUsername())) {
            return false;
        }

        String sql = "INSERT INTO admins (username, password) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, adminLog.getUsername());
            ps.setString(2, adminLog.getPassword());
            boolean ok = ps.executeUpdate() > 0;
            if (ok) {
                AdminLogger.log(null, adminLog.getUsername(), "Registration successful");
            }
            return ok;
        } catch (SQLException e) {
            System.err.println("[Adminservice.register] Error: " + e.getMessage());
            AdminLogger.log(null, adminLog.getUsername(), "Registration failed: " + e.getMessage());
            return false;
        }
    }

    private boolean usernameExists(String username) {
        String sql = "SELECT id FROM admins WHERE username = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            System.err.println("[Adminservice.usernameExists] Error: " + e.getMessage());
            return false;
        }
    }
}
