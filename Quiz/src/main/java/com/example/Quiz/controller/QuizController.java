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
        Contestant existingContestant = quizService.getContestantByUsername(username);
        if (existingContestant != null) {
            model1.addObject("message", "User " + username + " has already taken the quiz.");
            return model1;
        }
        contestant.setUsername(username);
        quizService.addContestant(contestant);
        List<Question> questions = quizService.getRandomQuestions(5);
        if (questions.isEmpty()) {
            model1.addObject("message", "No questions available for the quiz.");
            return model1;
        }
        model1.addObject("questions", questions);
        model1.addObject("username", username);
        model1.setViewName("quizPage");
        return model1;
    }
    @PostMapping("/submit-quiz")
    public ResponseEntity<String> submitQuiz(@RequestParam String username, @RequestParam Map<String, String> allParams) {
        int marks = 0;

        // Filter out non-question related parameters
        allParams.entrySet().removeIf(entry -> entry.getKey().equals("username"));

        // Loop through the remaining params which are expected to be question IDs
        for (String questionId : allParams.keySet()) {
            try {
                Integer id = Integer.parseInt(questionId);
                Question question = quizService.findById(id).orElse(null);
                if (question != null) {
                    String submittedAnswer = allParams.get(questionId);
                    if (submittedAnswer != null && Integer.parseInt(submittedAnswer) == question.getCorrectOption()) {
                        marks++;
                    }
                }
            } catch (NumberFormatException e) {
                System.err.println("Invalid question ID: " + questionId);
            }
        }

        // Check if the contestant already exists to prevent duplicates
        Contestant existingContestant = quizService.getContestantByUsername(username);
        if (existingContestant != null) {
            existingContestant.setMarks(marks);
            quizService.updateContestant(existingContestant);
        } else {
            // If the contestant is new, create a new entry
            Contestant contestant = new Contestant();
            contestant.setUsername(username);
            contestant.setMarks(marks);
            quizService.saveContestant(contestant);
        }

        return ResponseEntity.ok("Quiz submitted successfully! Marks: " + marks);
    }

    @GetMapping("/all-contestants")
    public ModelAndView viewAllContestantsPage() {
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
    public ModelAndView viewResults(@RequestParam String username) {
        Contestant contestant = quizService.getContestantByUsername(username);
        System.out.println(contestant);
        ModelAndView model = new ModelAndView("viewResults");
        model.addObject("contestant", contestant);  // Ensure this matches your JSP file name
        return model;
    }

}

