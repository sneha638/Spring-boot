package com.example.Quiz.controller;

import com.example.Quiz.model.Users;
import com.example.Quiz.service.QuizService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class PageController {
    @Autowired
    private QuizService quizService;

    @GetMapping("/add-question")
    public String addQuestion() {
        return "addQuestion";
    }
    @GetMapping("/quiz")
    public String showWelcomePage() {
        return "welcome";
    }
    @GetMapping("/start-quiz")
    public String showStartQuizPage() {
        return "startQuiz";
    }
    @GetMapping("/view-results")
    public String view() {

        return "viewResults";
    }
}
