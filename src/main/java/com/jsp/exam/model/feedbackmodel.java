package com.jsp.exam.model;

public class feedbackmodel {
    private String name;
    private String email;
    private String message;
    private String filename;

    public feedbackmodel(String name, String email, String message, String filename) {
        this.name = name;
        this.email = email;
        this.message = message;
        this.filename = filename;
    }

    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getMessage() { return message; }
    public String getFilename() { return filename; }

    public void setName(String name) { this.name = name; }
    public void setEmail(String email) { this.email = email; }
    public void setMessage(String message) { this.message = message; }
    public void setFilename(String filename) { this.filename = filename; }

    public boolean isValid() {
        return name != null && !name.isEmpty() &&
                email != null && !email.isEmpty() &&
                message != null && !message.isEmpty();
    }
}
