package com.jsp.exam.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.jsp.exam.model.Student;
import com.jsp.exam.util.DBConnection;

public class Studentservice {

    // Create student
    public boolean addStudent(Student student) {
        if (!student.isValid()) {
            return false;
        }
        String sql = "INSERT INTO students (student_name, student_password, student_email) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, student.getStudent_name());
            ps.setString(2, student.getStudent_password());
            ps.setString(3, student.getStudent_email());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[Studentservice.addStudent] Error: " + e.getMessage());
            return false;
        }
    }

    // Read students
    public List<Student> readStudents() {
        List<Student> list = new ArrayList<>();
        String sql = "SELECT student_name, student_password, student_email FROM students ORDER BY id ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Student(
                        rs.getString("student_name"),
                        rs.getString("student_password"),
                        rs.getString("student_email")
                ));
            }
        } catch (SQLException e) {
            System.err.println("[Studentservice.readStudents] Error: " + e.getMessage());
        }
        return list;
    }

    // Delete student
    public boolean deleteStudent(String student_name) {
        String sql = "DELETE FROM students WHERE student_name = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, student_name);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[Studentservice.deleteStudent] Error: " + e.getMessage());
            return false;
        }
    }

    // Modify student
    public boolean updateStudent(String student_name, String student_password, String student_email) {
        String sql = "UPDATE students SET student_password = ?, student_email = ? WHERE student_name = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, student_password);
            ps.setString(2, student_email);
            ps.setString(3, student_name);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[Studentservice.updateStudent] Error: " + e.getMessage());
            return false;
        }
    }
}
