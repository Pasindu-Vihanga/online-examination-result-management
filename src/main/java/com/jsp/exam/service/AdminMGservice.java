package com.jsp.exam.service;

import com.jsp.exam.model.AdminLog;
import com.jsp.exam.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminMGservice {

    // Create Admin
    public boolean createAdmin(AdminLog adminLog) {
        if (!adminLog.isValid()) {
            return false;
        }
        String sql = "INSERT INTO admins (username, password) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, adminLog.getUsername());
            ps.setString(2, adminLog.getPassword());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[AdminMGservice.createAdmin] Error: " + e.getMessage());
            return false;
        }
    }

    // Read Admin
    public List<AdminLog> readAdmin() {
        List<AdminLog> readAdmins = new ArrayList<>();
        String sql = "SELECT username, password FROM admins ORDER BY id ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                readAdmins.add(new AdminLog(rs.getString("username"), rs.getString("password"), "MySQL_DB"));
            }
        } catch (SQLException e) {
            System.err.println("[AdminMGservice.readAdmin] Error: " + e.getMessage());
        }
        return readAdmins;
    }

    // Delete Admin
    public boolean deleteAdmin(String adminName) {
        String sql = "DELETE FROM admins WHERE username = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, adminName);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[AdminMGservice.deleteAdmin] Error: " + e.getMessage());
            return false;
        }
    }

    // Update Admin Credentials
    public boolean updateAdmin(String username, String newPassword) {
        String sql = "UPDATE admins SET password = ? WHERE username = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setString(2, username);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[AdminMGservice.updateAdmin] Error: " + e.getMessage());
            return false;
        }
    }
}
