package com.jsp.exam.service;

import com.jsp.exam.model.StudentLog;
import com.jsp.exam.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StudentMGservice {

    // Create user
    public boolean addStudent(StudentLog studentLog) {
        if (!studentLog.isValid()) {
            return false;
        }
        String sql = "INSERT INTO students (student_name, student_password, student_email) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, studentLog.getUsername());
            ps.setString(2, studentLog.getPassword());
            ps.setString(3, studentLog.getEmail());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[StudentMGservice.addStudent] Error: " + e.getMessage());
            return false;
        }
    }

    // Read users
    public List<StudentLog> readStudent() {
        List<StudentLog> readStudents = new ArrayList<>();
        String sql = "SELECT student_name, student_password, student_email FROM students ORDER BY id ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                readStudents.add(new StudentLog(
                        rs.getString("student_name"),
                        rs.getString("student_password"),
                        rs.getString("student_email")
                ));
            }
        } catch (SQLException e) {
            System.err.println("[StudentMGservice.readStudent] Error: " + e.getMessage());
        }
        return readStudents;
    }

    // Delete user
    public boolean deleteStudent(String username) {
        String sql = "DELETE FROM students WHERE student_name = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[StudentMGservice.deleteStudent] Error: " + e.getMessage());
            return false;
        }
    }
}
