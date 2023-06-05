package com.example.kosciuszkon.service;

import com.example.kosciuszkon.dto.UserDTO;
import com.example.kosciuszkon.entity.Authority;
import com.example.kosciuszkon.entity.Token;
import com.example.kosciuszkon.entity.User;
import com.example.kosciuszkon.exceptions.UserNotFoundException;
import com.example.kosciuszkon.repository.AuthorityRepository;
import com.example.kosciuszkon.repository.TokenRepository;
import com.example.kosciuszkon.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Comparator;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final AuthorityRepository authorityRepository;
    private final TokenRepository tokenRepository;

    public UserDTO createUser(User user){
        if(userRepository.findByUsername(user.getUsername()).isPresent()){
            return null;
        }
        user.setPassword("{bcrypt}" + new BCryptPasswordEncoder().encode(user.getPassword()));
        user.setId(getNextId());
        var authority = new Authority();
        authority.setAuthority("ROLE_USER");
        authority.setUsername(user);
        authorityRepository.save(authority);
        return new UserDTO(user.getEmail(), user.getUsername());
    }

    public void logout(String rawToken){
        var token = new Token();
        token.setToken(rawToken);
        token.setCreated(LocalDateTime.now());
        tokenRepository.save(token);
    }

    public User findByUsername(String userName){
        return userRepository.findByUsername(userName)
                .orElseThrow(UserNotFoundException::new);
    }

    private Long getNextId() {
        return userRepository.findAll()
                .stream()
                .map(u -> {
                    try {
                        return u.getId();
                    } catch (NullPointerException e) {
                        return 0L;
                    }
                })
                .max(Comparator.naturalOrder()).orElse(0L) + 1;
    }

    public Long getUserId(String username) {
        return findByUsername(username).getId();
    }
}

