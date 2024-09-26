package com.example.Quiz.service;

import com.example.Quiz.model.Contestant;
import com.example.Quiz.model.Question;
import com.example.Quiz.repository.ContestantRepository;
import com.example.Quiz.repository.QuestionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Service
public class QuizService {

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private ContestantRepository contestantRepository;

    public void addQuestion(Question questions) {

        questionRepository.save(questions);
    }

    public List<Question> getRandomQuestions(int limit) {
        List<Question> allQuestions = questionRepository.findAll();
        Collections.shuffle(allQuestions);
        return allQuestions.size() > limit ? allQuestions.subList(0, limit) : allQuestions;
    }

    public Contestant addContestant(Contestant contestant) {
        return contestantRepository.save(contestant);
    }

    public Contestant getContestantByUsername(String username) {
        return contestantRepository.findByUsername(username);
    }

    public List<Contestant> getAllContestants() {
        return contestantRepository.findAll();
    }

}