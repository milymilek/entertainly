package com.example.kosciuszkon.controller;

import com.example.kosciuszkon.entity.Users;
import com.example.kosciuszkon.service.UsersService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/users")
public class UsersController {

    private final UsersService service;

    @GetMapping("/add")
    public Users addUser(@RequestBody Users user){
        return service.save(user);
    }
}
