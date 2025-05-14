package com.jsp.exam.service;

import com.jsp.exam.model.AdminLog;
import com.jsp.exam.service.AdminLogger;
import java.io.*;

public class Adminservice implements AdminAuthService {
    private static final String CREDENTIAL_FILE = "D:/IP/proj/Online-Examinations-and-result-management-system/src/main/webapp/logincreds/admin.txt";

    @Override
    public boolean authenticate(AdminLog adminLog) {
        if (!adminLog.isValid()) return false;

        boolean success = false;
        try (BufferedReader reader = new BufferedReader(new FileReader(CREDENTIAL_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 2 &&
                        parts[0].equals(adminLog.getUsername()) &&
                        parts[1].equals(adminLog.getPassword())) {
                    success = true;
                    break;
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading credentials: " + e.getMessage());
        }

        AdminLogger.log("D:/IP/proj/Online-Exam-System/logs/admin_log.txt",
                adminLog.getUsername(), success ? "Successful login" : "Failed login");

        return success;
    }

    @Override
    public boolean register(AdminLog adminLog) {
        if (!adminLog.isValid()) return false;

        if (usernameExists(adminLog.getUsername())) {
            return false; // Username already exists
        }
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(CREDENTIAL_FILE, true))) {
            writer.write(adminLog.getUsername() + "," + adminLog.getPassword());
            writer.newLine();
            AdminLogger.log("D:/IP/proj/Online-Exam-System/logs/admin_log.txt",
                    adminLog.getUsername(), "Registration successful");
            return true;
        } catch (IOException e) {
            System.err.println("Error writing credentials: " + e.getMessage());
        }

        return false;
    }

    private boolean usernameExists(String username) {
        try (BufferedReader reader = new BufferedReader(new FileReader(CREDENTIAL_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 1 && parts[0].equals(username)) {
                    return true;
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading credentials: " + e.getMessage());
        }
        return false;
    }
}
