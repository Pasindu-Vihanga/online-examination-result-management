package com.jsp.exam.service;

import com.jsp.exam.model.AdminLog;
public interface AdminAuthService {
    boolean authenticate(AdminLog adminLog);
    boolean register(AdminLog adminLog);
}
