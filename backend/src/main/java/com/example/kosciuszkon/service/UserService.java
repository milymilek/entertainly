package com.example.kosciuszkon.service;

import com.example.kosciuszkon.dto.CredentialsDTO;
import com.example.kosciuszkon.entity.Authority;
import com.example.kosciuszkon.entity.Token;
import com.example.kosciuszkon.entity.User;
import com.example.kosciuszkon.repository.AuthorityRepository;
import com.example.kosciuszkon.repository.TokenRepository;
import com.example.kosciuszkon.repository.UserRepository;
import lombok.AllArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@AllArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final AuthorityRepository authorityRepository;

    private final TokenRepository tokenRepository;

    public CredentialsDTO createUser(User user){
        if(userRepository.findByUsername(user.getUsername()).isPresent()){
            return null;
        }
        user.setPassword("{bcrypt}" + new BCryptPasswordEncoder().encode(user.getPassword()));
        var authority = new Authority();
        authority.setAuthority("ROLE_USER");
        authority.setUsername(user);
        authorityRepository.save(authority);
        return new CredentialsDTO(user.getUsername(), user.getPassword());
    }

    public void logout(String rawToken){
        var token = new Token();
        token.setToken(rawToken);
        token.setCreated(LocalDateTime.now());
        tokenRepository.save(token);
    }
}
