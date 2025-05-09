package com.jsp.exam.files;

public class StudentLog extends User {

    public StudentLog(String username, String password, String email) {
        super(username, password, email); // Call to User constructor
    }

    // Getter methods
    public String getUsername() {
        return super.getUsername();
    }

    public String getPassword() {
        return super.getPassword();
    }

    public String getEmail() {
        return super.getEmail();
    }

    // Setter methods
    public void setUsername(String username) {
        super.setUsername(username);
    }

    public void setPassword(String password) {
        super.setPassword(password);
    }

    public void setEmail(String email) {
        super.setEmail(email);
    }

    public boolean isValid() {
        return getUsername() != null && !getUsername().isEmpty()
                && getPassword() != null && !getPassword().isEmpty();
    }
}
