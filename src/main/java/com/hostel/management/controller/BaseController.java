package com.nishantwrp.institutemanagement.controller;

import com.nishantwrp.institutemanagement.model.User;
import com.nishantwrp.institutemanagement.service.AuthenticationService;
import com.nishantwrp.institutemanagement.service.StudentService;
import com.nishantwrp.institutemanagement.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import javax.servlet.http.HttpSession;

import java.util.Objects;

import static ch.qos.logback.core.joran.action.ActionConst.NULL;

abstract class BaseController {
    @Autowired
    private AuthenticationService authenticationService;

    @Autowired
    private UserService userService;

    @Autowired
    private StudentService studentService;


    public Boolean isAuthenticated(HttpSession session) {
        return authenticationService.isAuthenticated(session);
    }

    public void addDefaultAttributes(Model model, HttpSession session) {
        String currentUser = authenticationService.getCurrentUser(session);
        if (currentUser != null) {

            model.addAttribute("username", currentUser);
            model.addAttribute("userImageUrl", "https://ui-avatars.com/api/?name=" + currentUser);

            User user= userService.getUser(currentUser);
            model.addAttribute("user", user);
//
            String currRole=user.getRole();

            if (currRole.equals("student")) {
                model.addAttribute("student", studentService.getStudentByRollNo(currentUser));
            }
        }
    }
}
