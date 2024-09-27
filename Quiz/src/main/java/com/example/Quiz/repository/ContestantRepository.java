package com.example.Quiz.repository;

import com.example.Quiz.model.Contestant;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ContestantRepository extends JpaRepository<Contestant, Integer> {
    Contestant findByUsername(String username);
    boolean existsByUsername(String username);
}
