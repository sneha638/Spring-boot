package com.example.Quiz.controller;

import com.example.Quiz.model.Users;
import com.example.Quiz.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
@Controller
public class UserController {

    @Autowired
    private UserService userService;


    @GetMapping("/login")
    public String showLoginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String login(Users user, RedirectAttributes redirectAttributes) {
        boolean isValidUser = userService.verify(user);
        if (isValidUser) {
            redirectAttributes.addFlashAttribute("username", user.getUsername());
            return "redirect:/quiz";
        } else {
            redirectAttributes.addFlashAttribute("error", "Invalid username or password!");
            return "redirect:/login";
        }
    }
    @GetMapping("/logout")
    public String logout() {
        return "logout";
    }

}