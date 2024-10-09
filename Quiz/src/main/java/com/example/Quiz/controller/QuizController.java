package com.example.Quiz.controller;

import com.example.Quiz.exception.UserException;
import com.example.Quiz.model.Contestant;
import com.example.Quiz.model.Question;
import com.example.Quiz.service.QuizService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.time.Instant;
import java.util.List;
import java.util.Map;

@RestController
public class QuizController {
    @Autowired
    private QuizService quizService;

    @PostMapping("/add-question")
    public ModelAndView addQuestion(@RequestParam("question") String questionText,
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
    public ModelAndView startQuiz(
            @RequestParam(value = "username") String username,
            @RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam Map<String, String> allParams,
            HttpSession session) {

        if (quizService.usernameExists(username)) {
            throw new UserException("Username already exists. Please choose a different username.");
        }

        ModelAndView model = new ModelAndView("quizPage");

        // Fetch paginated questions based on the current page
        Pageable pageable = PageRequest.of(page, 1); // Assuming 1 question per page
        Page<Question> questionPage = quizService.getPagedQuestions(pageable);
        if (!questionPage.hasContent()) {
            model.addObject("message", "No questions available for the quiz.");
            return model;
        }

        Question currentQuestion = questionPage.getContent().get(0);

        // Save the selected answer in the session
        String selectedAnswerKey = "question_" + currentQuestion.getId();
        if (allParams.containsKey("selectedAnswer")) {
            String selectedAnswer = allParams.get("selectedAnswer");
            session.setAttribute(selectedAnswerKey, selectedAnswer); // Save the selected answer in the session
        }

        // Retrieve the previously selected answer from the session for the current question
        String previousSelectedAnswer = (String) session.getAttribute(selectedAnswerKey);

        // Set additional attributes
        model.addObject("currentQuestion", currentQuestion);
        model.addObject("currentPage", page);
        model.addObject("totalPages", questionPage.getTotalPages());
        model.addObject("username", username);
        model.addObject("selectedAnswer", previousSelectedAnswer); // Add the previously selected answer

        return model;
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

    @ControllerAdvice
    public class GlobalExceptionHandler {

        @ExceptionHandler(UserException.class)
        public ModelAndView handleUsernameAlreadyExistsException(UserException ex) {
            ModelAndView model = new ModelAndView("errorPage"); // Change this to the appropriate view name
            model.addObject("errorMessage", ex.getMessage());  // Pass the error message to the view
            return model;
        }

        // Other exception handlers (if needed) can go here
    }

}