package com.example.kosciuszkon.entity;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;

import java.util.List;
import java.util.Set;

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

    @ManyToMany
    @JsonIgnore
    private List<Categories> categories;

    public void setCategories(List<Categories> categories) {
        this.categories = categories;
    }

    public List<Categories> getCategories() {
        if(this.categories == null){
            return List.of();
        }
        return categories;
    }

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
