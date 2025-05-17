package com.jsp.exam.service;

import com.jsp.exam.model.feedbackmodel;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class feedbackservice {
    public static final String FEEDBACK_FILE = "D:/IP/proj/Examination/Online-Examinations-and-result-management-system/src/main/webapp/logincreds/feedback.txt";

    // Create Feedback
    public boolean createFeedback(feedbackmodel feedback) {
        if (!feedback.isValid()) return false;
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FEEDBACK_FILE, true))) {
            writer.write(feedback.getName() + "," + feedback.getEmail() + "," + feedback.getMessage() + "," + feedback.getRating());
            writer.newLine();
            return true;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Read Feedback
    public List<feedbackmodel> readFeedback() {
        List<feedbackmodel> feedbackList = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FEEDBACK_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",", 4);
                if (parts.length == 4) {
                    feedbackList.add(new feedbackmodel(parts[0], parts[1], parts[2], parts[3]));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return feedbackList;
    }

    // Remove Feedback by Name
    public boolean removeFeedback(String name) {
        List<feedbackmodel> feedbackList = readFeedback();
        boolean deleted = false;

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FEEDBACK_FILE))) {
            for (feedbackmodel feedback : feedbackList) {
                if (!feedback.getName().equals(name)) {
                    writer.write(feedback.getName() + "," + feedback.getEmail() + "," + feedback.getMessage() + "," + feedback.getRating());
                    writer.newLine();
                } else {
                    deleted = true;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return deleted;
    }
}
