package com.example.Quiz.service;

import com.example.Quiz.model.Contestant;
import com.example.Quiz.model.Question;
import com.example.Quiz.repository.ContestantRepository;
import com.example.Quiz.repository.QuestionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Service
public class QuizService {

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private ContestantRepository contestantRepository;

    public int getTotalQuestions() {

        return (int) questionRepository.count();
    }

    public List<Question> getAllQuestions() {
        return questionRepository.findAll();
    }
    public Page<Question> getPagedQuestions(Pageable pageable) {
        return questionRepository.findAll(pageable);
    }

    public List<Question> getRandomQuestions(int limit) {
        List<Question> allQuestions = questionRepository.findAll();
        Collections.shuffle(allQuestions);
        return allQuestions.size() > limit ? allQuestions.subList(0, limit) : allQuestions;
    }

    public List<Question> getPaginatedQuestions(int page, int pageSize) {
        Pageable pageable = PageRequest.of(page, pageSize);
        Page<Question> questionPage = questionRepository.findAll(pageable);
        return questionPage.getContent();
    }

    public void addQuestion(Question question) {

        questionRepository.save(question);
    }

    public void updateContestant(Contestant contestant) {

        contestantRepository.save(contestant);
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

    public void saveContestant(Contestant contestant) {
        contestantRepository.save(contestant);
    }

    public Optional<Question> findById(Integer id) {

        return questionRepository.findById(id);
    }

    public boolean usernameExists(String username) {

        Contestant contestant = contestantRepository.findByUsername(username);
        return contestant != null;
    }
    }
