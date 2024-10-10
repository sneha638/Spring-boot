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
import java.util.Map;


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
        contestant.setUsername(username);
        quizService.addContestant(contestant);
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
    public ModelAndView submitQuiz(@ModelAttribute Contestant contestant,
                                   @RequestParam Map<String, String> answers) {
        int marks = 0;

        // Loop through the answers and calculate the score
        for (String questionId : answers.keySet()) {
            try {
                Integer id = Integer.parseInt(questionId);
                Question question = quizService.findById(id).orElse(null);
                if (question != null) {
                    String submittedAnswer = answers.get(questionId);
                    if (submittedAnswer != null && Integer.parseInt(submittedAnswer) == question.getCorrectOption()) {
                        marks++;
                    }
                }
            } catch (NumberFormatException e) {
                System.err.println("Invalid question ID: " + questionId);
            }
        }

        // Set the marks in the contestant object
        contestant.setMarks(marks);

        // Check if the contestant already exists
        Contestant existingContestant = quizService.getContestantByUsername(contestant.getUsername());
        if (existingContestant != null) {
            existingContestant.setMarks(marks); // Update marks if the contestant exists
            quizService.updateContestant(existingContestant);
        } else {
            // If the contestant is new, create a new entry
            quizService.addContestant(contestant);
        }

        // Create a ModelAndView for the results page
        ModelAndView modelAndView = new ModelAndView("resultPage");
        modelAndView.addObject("marks", marks);
        modelAndView.addObject("username", contestant.getUsername());

        return modelAndView;
    }


//    @PostMapping("/submit-quiz")
//    public String submitQuiz(@ModelAttribute Contestant contestant,
//                             @RequestParam Map<String, String> answers,
//                             @RequestParam("currentIndex") int currentIndex,
//                             @RequestParam(required = false) String action) {
//        // Handle answer submission for the current question
//        if (answers.containsKey("answer")) {
//            String submittedAnswer = answers.get("answer");
//            // Store or process the answer for this question
//            // (e.g., save to the contestant object or a temporary storage)
//        }
//
//        // Determine the next index based on action
//        if ("next".equals(action)) {
//            currentIndex++;
//        } else if ("previous".equals(action)) {
//            currentIndex--;
//        }
//
//        // Ensure currentIndex stays within bounds
//        if (currentIndex < 0) {
//            currentIndex = 0;
//        } else if (currentIndex >= questions.size()) {
//            // Optionally redirect to results or final submission
//            return "redirect:/quiz-results"; // Example redirect
//        }
//
//        // Prepare the model with the new current question
//        model.addAttribute("questions", questions);
//        model.addAttribute("currentIndex", currentIndex);
//        model.addAttribute("username", contestant.getUsername());
//
//        return "quiz-page"; // Return to the quiz JSP page
//    }


    @GetMapping("/all-contestants")
            public ModelAndView viewAllContestantsPage () {
                List<Contestant> contestants = quizService.getAllContestants();
                // Print contestants in console
                System.out.println("Results of all contestants:");
                contestants.forEach(contestant ->
                        System.out.println("Username: " + contestant.getUsername() + ", Marks: " + contestant.getMarks()));
                // If you want to show them in a view (for example, a Thymeleaf or JSP page)
                ModelAndView model = new ModelAndView("allContestants");
                model.addObject("contestants", contestants);
                return model;
            }

            @PostMapping("/view-results")
            public ModelAndView viewResults (@RequestParam String username){
                Contestant contestant = quizService.getContestantByUsername(username);
                System.out.println(contestant);
                ModelAndView model = new ModelAndView("viewResults");
                model.addObject("contestant", contestant);  // Ensure this matches your JSP file name
                return model;
            }

        }
