package com.example.Quiz.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
@Controller
public class PageController {
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
