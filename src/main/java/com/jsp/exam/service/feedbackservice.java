package com.jsp.exam.service;

import com.jsp.exam.model.feedbackmodel;
import com.jsp.exam.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class feedbackservice {

    // Create Feedback
    public boolean createFeedback(feedbackmodel feedback) {
        if (!feedback.isValid()) return false;
        String sql = "INSERT INTO feedbacks (name, email, comments, rating) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, feedback.getName());
            ps.setString(2, feedback.getEmail());
            ps.setString(3, feedback.getMessage());
            ps.setString(4, feedback.getRating());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[feedbackservice.createFeedback] Error: " + e.getMessage());
            return false;
        }
    }

    // Read Feedback
    public List<feedbackmodel> readFeedback() {
        List<feedbackmodel> feedbackList = new ArrayList<>();
        String sql = "SELECT name, email, comments, rating FROM feedbacks ORDER BY id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                feedbackList.add(new feedbackmodel(
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("comments"),
                        rs.getString("rating")
                ));
            }
        } catch (SQLException e) {
            System.err.println("[feedbackservice.readFeedback] Error: " + e.getMessage());
        }
        return feedbackList;
    }

    // Remove Feedback by Name
    public boolean removeFeedback(String name) {
        String sql = "DELETE FROM feedbacks WHERE name = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[feedbackservice.removeFeedback] Error: " + e.getMessage());
            return false;
        }
    }
}
