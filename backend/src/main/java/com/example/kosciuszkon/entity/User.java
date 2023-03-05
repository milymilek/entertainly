package com.example.kosciuszkon.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity(name = "users")
@Getter
@Setter
@ToString
@RequiredArgsConstructor
public class User {

    @Id
    private String username;

    private String password;

    private int enabled;

}
