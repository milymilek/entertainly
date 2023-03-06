package com.example.kosciuszkon.entity;

import javax.persistence.*;
import lombok.*;

@Entity(name = "users")
@ToString
@RequiredArgsConstructor
@NoArgsConstructor
public class User {

    @Id
    @NonNull
    private String username;

    @NonNull
    private String password;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
