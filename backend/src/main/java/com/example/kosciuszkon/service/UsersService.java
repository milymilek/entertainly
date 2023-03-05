package com.example.kosciuszkon.service;

import com.example.kosciuszkon.entity.Users;
import com.example.kosciuszkon.repository.UsersRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class UsersService {

    private final UsersRepository usersRepository;

    public Users save(Users user){
        return usersRepository.save(user);
    }
}
