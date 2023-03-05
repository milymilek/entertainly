package com.example.kosciuszkon.service;

import com.example.kosciuszkon.entity.User;
import com.example.kosciuszkon.repository.UsersRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class UsersService {

    private final UsersRepository usersRepository;

    public User save(User user){
        return usersRepository.save(user);
    }
}
