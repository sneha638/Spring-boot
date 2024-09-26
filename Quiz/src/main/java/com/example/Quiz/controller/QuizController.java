package com.example.Quiz.controller;

import com.example.Quiz.model.Contestant;
import com.example.Quiz.model.Question;
import com.example.Quiz.service.QuizService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@RestController
public class QuizController {
    @Autowired
    private QuizService quizService;

    @PostMapping("/add-question")
    public ModelAndView addQuestion( @RequestParam("question") String questionText,
                                     @RequestParam("option1") String option1,
                                     @RequestParam("option2") String option2,
                                     @RequestParam("option3") String option3,
                                     @RequestParam("correctOption") int correctOption) {
        Question newQuestion = new Question(questionText, option1, option2, option3, correctOption);
        quizService.addQuestion(newQuestion);
        ModelAndView model = new ModelAndView("welcome");
        model.addObject("message", "Question added successfully!");
        return model;
    }


    @PostMapping("/start")
    public ModelAndView startQuiz(@ModelAttribute Contestant contestant, Model model) {
        String username = contestant.getUsername();
        ModelAndView model1 = new ModelAndView("startQuiz");

        if (username == null || username.isEmpty()) {
            model1.addObject("message", "Username is required.");
            return model1;
        }

        // Check if the contestant already exists in the database
        Contestant existingContestant = quizService.getContestantByUsername(username);
        if (existingContestant != null) {
            model1.addObject("message", "User " + username + " has already taken the quiz.");
            return model1;
        }

        // Create a new contestant object and save it
        contestant.setUsername(username); // Make sure to set the username
        quizService.addContestant(contestant); // Save the contestant to the database

        // Fetch random questions for the quiz
        List<Question> questions = quizService.getRandomQuestions(5);
        if (questions.isEmpty()) {
            model1.addObject("message", "No questions available for the quiz.");
            return model1;
        }

        // Pass the questions and username to the quiz page
        model1.addObject("questions", questions);
        model1.addObject("username", username);
        model1.setViewName("quizPage");
        return model1;
    }



    @PostMapping("/submit-quiz")
    public ResponseEntity<String> submitQuiz(@ModelAttribute Contestant contestant, @RequestParam(required = false) Integer marks) {
        if (marks == null) {
            return ResponseEntity.badRequest().body("Successfully completed");
        }

        contestant.setMarks(marks);  // Set the marks in the contestant object
        quizService.addContestant(contestant);
        return ResponseEntity.ok("Quiz completed. You scored: " + marks);
    }


    @PostMapping("/view-results")
    public ModelAndView viewResults(@RequestParam String username) {
        Contestant contestant = quizService.getContestantByUsername(username);
        System.out.println(contestant);
        ModelAndView model = new ModelAndView("viewResults");
        model.addObject("contestant", contestant);  // Ensure this matches your JSP file name
        return model;
    }

    @GetMapping("/all-contestants")
    public ModelAndView viewAllContestantsPage() {
        List<Contestant> contestants = quizService.getAllContestants();
        ModelAndView model = new ModelAndView("allContestants");
        model.addObject("contestants", contestants);
        return model;
    }
}
