package com.example.Quiz.model;


import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name="question")
public class Question {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String question;
    private String option1;
    private String option2;
    private String option3;
    private int correctOption;

    public Question(String question, String option1, String option2, String option3,int correctOption ) {
        this.correctOption = correctOption;
        this.option1 = option1;
        this.option2 = option2;
        this.option3 = option3;
        this.question = question;
    }
}

