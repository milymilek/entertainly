package com.example.kosciuszkon.controller;


import com.example.kosciuszkon.dto.CredentialsDTO;
import com.example.kosciuszkon.entity.User;
import com.example.kosciuszkon.exceptions.UserNotFoundException;
import com.example.kosciuszkon.service.UserService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@AllArgsConstructor
public class UserController {

    private UserService service;

    @PostMapping("/login")
    public void login(@RequestBody CredentialsDTO credentials) {
    }

    @PostMapping("/signout")
    public void logout(@RequestHeader(HttpHeaders.AUTHORIZATION) String token) {
        service.logout(token);
    }

    @PostMapping("/signup")
    public ResponseEntity<CredentialsDTO> signup(@RequestBody User user) {
        return Optional.ofNullable(service.createUser(user))
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.status(HttpStatus.BAD_REQUEST).build());
    }

    @ExceptionHandler(UserNotFoundException.class)
    public String userNotFoundError() {
        return "No user with such a username";
    }
}
