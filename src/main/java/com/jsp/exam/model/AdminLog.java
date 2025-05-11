package com.jsp.exam.model;

public class AdminLog {
    private String username;
    private String password;
    private String filename;

    public AdminLog(String username, String password, String filename) {
        this.username = username;
        this.password = password;
        this.filename = filename;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public boolean isValid() {
        return username != null && !username.isEmpty()
                && password != null && !password.isEmpty();
    }
}
