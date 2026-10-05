# 🎓 Online Examination & Result Management System

[![Java](https://img.shields.io/badge/Java-21%20LTS-orange.svg?style=flat&logo=openjdk)](https://openjdk.org/)
[![Jakarta EE](https://img.shields.io/badge/Jakarta%20EE-Servlet%206.0-red.svg?style=flat)](https://jakarta.ee/)
[![Apache Tomcat](https://img.shields.io/badge/Apache%20Tomcat-9%20%2F%2010-yellow.svg?style=flat&logo=apachetomcat)](https://tomcat.apache.org/)
[![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3-purple.svg?style=flat&logo=bootstrap)](https://getbootstrap.com/)
[![Maven](https://img.shields.io/badge/Maven-Build%20Tool-C71A36.svg?style=flat&logo=apachemaven)](https://maven.apache.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

An enterprise-ready web-based **Online Examination and Result Management System** engineered with Java Servlets, JavaServer Pages (JSP), and Data Structures & Algorithms (Custom Linked Lists for high-efficiency result sorting and rank generation).

---

## 📌 Features

### 👨‍🎓 Student Portal
- **Secure Authentication**: Dedicated registration and login with session validation.
- **Interactive Exam Interface**: Take online tests with dynamic question rendering.
- **Instant Result Evaluation**: Automatic marking engine computes scores right after test submission.
- **Detailed Performance Insights**: View comprehensive result cards with marks, timestamps, and pass/fail statuses.
- **Student Feedback System**: Submit feedback and rate the testing experience.

### 🛡️ Admin & Instructor Portal
- **Exam Paper Builder**: Add, edit, update, and delete exam questions dynamically.
- **Admin Management**: Multi-admin access control with activity logs (`logview.jsp`).
- **Student Management**: View registered candidates, monitor exam participation, and manage user records.
- **Custom DSA Result Sorter**: High-performance in-memory sorting using custom linked list data structures (`ResultLinkedList.java`).
- **Feedback Inspector**: Review feedback submitted by examinees (`feedbackrecords.jsp`).

---

## 🏗️ System Architecture

```
                       [ Web Client / Browser ]
                                  │
                                  ▼
                        [ JSP Presentation Layer ]
             (index.jsp, dashboard.jsp, admindashboard.jsp)
                                  │
                                  ▼
                       [ Java Servlet Layer ]
      (UserLoginServlet, addExamPaperServlet, FeedbackServlet, etc.)
                                  │
                                  ▼
                       [ Business Service Layer ]
           (Studentservice, Examservice, ExamResultService)
                                  │
                                  ▼
                      [ Data Structure & Storage ]
         (Custom ResultLinkedList & File-Based Storage Engine)
```

---

## 💻 Tech Stack

| Domain | Technology |
|---|---|
| **Language** | Java 21 (LTS) |
| **Presentation Layer** | JSP (JavaServer Pages), JSTL, HTML5, Vanilla CSS |
| **UI Framework** | Bootstrap 5.3 + FontAwesome |
| **Backend Framework** | Jakarta EE / Java Servlets 6.0 |
| **Build & Dependency Tool** | Apache Maven |
| **Web Server** | Apache Tomcat 9 / 10 |
| **Data Structures** | Custom Singly Linked List (`ResultLinkedList`) |

---

## 🚀 Getting Started

### Prerequisites
- **JDK 17 or 21 LTS** installed and added to `PATH`
- **Apache Tomcat 9 or 10** (`CATALINA_HOME` configured)
- **IntelliJ IDEA** (Recommended) or Eclipse / VS Code

### Running with IntelliJ IDEA (SmartTomcat)
1. Clone this repository:
   ```bash
   git clone https://github.com/Pasindu-Vihanga/online-examination-result-management.git
   ```
2. Open the project folder in **IntelliJ IDEA**.
3. Install the **Smart Tomcat** plugin from `Settings -> Plugins`.
4. Go to **Run -> Edit Configurations...**
5. Click **+** and select **Smart Tomcat**:
   - **Tomcat Server**: Browse to your Tomcat directory
   - **Deployment Directory**: Select `src/main/webapp`
   - **Context Path**: `/Exam`
   - **Server Port**: `8080`
6. Click **Apply** and press **Run (Shift + F10)**.
7. Open your browser and navigate to:
   ```
   http://localhost:8080/Exam/
   ```

---

## 📁 Project Directory Structure

```
├── .gitignore
├── pom.xml
├── README.md
└── src/main/
    ├── java/com/jsp/exam/
    │   ├── action/           # Controllers (Servlets)
    │   │   ├── UserLoginServlet.java
    │   │   ├── AdminLoginServlet.java
    │   │   ├── CreateExamQuestionServlet.java
    │   │   ├── LoadExamPaperServlet.java
    │   │   └── ...
    │   ├── dsa/              # Data Structures & Algorithms
    │   │   └── ResultLinkedList.java
    │   ├── model/            # Domain Entities (POJOs)
    │   │   ├── User.java, Student.java, ExamPaper.java
    │   │   └── ...
    │   └── service/          # Core Business Services
    │       ├── Studentservice.java
    │       ├── Examservice.java
    │       └── ExamResultService.java
    └── webapp/               # Web Application Front-end
        ├── index.jsp         # Landing Page
        ├── login.jsp         # Student Login
        ├── admindashboard.jsp# Admin Dashboard
        ├── dashboard.jsp     # Student Dashboard
        ├── Exmhome.jsp       # Exam Taking Workspace
        ├── results.jsp       # Performance & Scorecards
        ├── feedback.jsp      # Candidate Feedback
        └── WEB-INF/
            └── web.xml       # Deployment Descriptor
```

---

## 👤 Author

Developed and maintained by **[Pasindu Vihanga](https://github.com/Pasindu-Vihanga)**  
*Faculty of Computing, Sri Lanka Institute of Information Technology (SLIIT)*

---

## 📄 License
This project is open-source and available under the [MIT License](LICENSE).
