package com.jsp.exam.action;

import com.jsp.exam.model.AdminLog;
import com.jsp.exam.service.AdminLogger;
import com.jsp.exam.service.Adminservice;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;

@WebServlet("/registerAD")
public class AdminRegServlet extends HttpServlet {
    private final Adminservice adminservice = new Adminservice();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String regusername = request.getParameter("username");
        String regpassword = request.getParameter("password");
        String confirm = request.getParameter("confirm_password");

        regusername = regusername != null ? regusername.trim() : "";
        regpassword = regpassword != null ? regpassword.trim() : "";
        confirm = confirm != null ? confirm.trim() : "";

        if (regusername.isEmpty() || regpassword.isEmpty() || confirm.isEmpty()) {
            response.sendRedirect("adminreg.jsp?error=empty");
            return;
        }

        if (!regpassword.equals(confirm)) {
            response.sendRedirect("adminreg.jsp?error=mismatch");
            return;
        }

        AdminLog newAdmin = new AdminLog(regusername, regpassword, "MySQL");
        boolean success = adminservice.register(newAdmin);

        if (success) {
            AdminLogger.log(null, regusername, "Registration successful");
            response.sendRedirect("adminlogin.jsp?registered=success");
        } else {
            AdminLogger.log(null, regusername, "Registration failed");
            response.sendRedirect("adminreg.jsp?error=exists");
        }
    }
}
