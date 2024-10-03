package com.example.Quiz.service;

import com.example.Quiz.model.Users;
import com.example.Quiz.repository.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.neo4j.Neo4jProperties;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserService {
@Autowired
  private JWTService jwtService;
   @Autowired
    private UserRepo userrepo;
    @Autowired
    AuthenticationManager authenticationManager;

    private BCryptPasswordEncoder encoder= new BCryptPasswordEncoder(12);

    public Users register(Users user) {
        user.setPassword(encoder.encode(user.getPassword()));
        return userrepo.save(user);
    }
    public String verify(Users user){
     Authentication authentication = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(user.getUsername(), user.getPassword()));
if(authentication.isAuthenticated())
    return jwtService.generateToken(user.getUsername());
return "fail";
    }
}