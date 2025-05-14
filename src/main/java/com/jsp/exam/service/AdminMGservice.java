package com.jsp.exam.service;

import com.jsp.exam.model.AdminLog;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class AdminMGservice {
    private static final String CREDENTIAL_FILE = "D:/IP/proj/Online-Examinations-and-result-management-system/src/main/webapp/logincreds/admin.txt";

    //Create Admin
    public boolean createAdmin(AdminLog adminLog) {
        if (!adminLog.isValid()) {
            return false;
        }
        try (BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(CREDENTIAL_FILE, true))) {
            bufferedWriter.write(adminLog.getUsername() + "," + adminLog.getPassword());
            bufferedWriter.newLine();
            return true;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }
    //Read Admin
    public List<AdminLog> readAdmin() {
        List<AdminLog> readAdmins = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(CREDENTIAL_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 2) {
                    readAdmins.add(new AdminLog(parts[0], parts[1], CREDENTIAL_FILE));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return readAdmins;
    }
    //Delete Admin
    public boolean deleteAdmin(String adminName) {
        List<AdminLog> readAdmins = readAdmin();
        boolean deleted = false;

        try (BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(CREDENTIAL_FILE))) {
            for (AdminLog adminLog : readAdmins) {
                if (!adminLog.getUsername().equals(adminName)) {
                    bufferedWriter.write(adminLog.getUsername() + "," + adminLog.getPassword());
                    bufferedWriter.newLine();
                } else {
                    deleted = true;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return deleted;
    }
    // Update Admin Credentials
    public boolean updateAdmin(String username, String newPassword) {
        List<AdminLog> readAdmins = readAdmin();
        boolean updated = false;

        try (BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(CREDENTIAL_FILE))) {
            for (AdminLog adminLog : readAdmins) {
                if (adminLog.getUsername().equals(username)) {
                    bufferedWriter.write(username + "," + newPassword);
                    updated = true;
                } else {
                    bufferedWriter.write(adminLog.getUsername() + "," + adminLog.getPassword());
                }
                bufferedWriter.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return updated;
    }
}
