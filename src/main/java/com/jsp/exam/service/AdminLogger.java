package com.jsp.exam.service;

import java.io.*;
import java.time.LocalDateTime;

public class AdminLogger {

    public static void log(String logPath, String username, String action) {
        if (logPath == null || logPath.trim().isEmpty()) {
            System.err.println("Log path not provided.");
            return;
        }

        synchronized (AdminLogger.class) {
            try (BufferedWriter writer = new BufferedWriter(
                    new OutputStreamWriter(new FileOutputStream(logPath, true), "UTF-8"))) {
                String logEntry = LocalDateTime.now() + " | Admin: " + username + " | Action: " + action;
                writer.write(logEntry);
                writer.newLine();
            } catch (IOException e) {
                System.err.println("Error writing to log file: " + e.getMessage());
            }
        }
    }
}
