package com.example.kosciuszkon.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import java.util.List;

@Entity
@Getter
@Setter
@Table(name = "Users")
public class User {
    @Id
    private String username;

    private String email;

    private String password;

    @JsonIgnore
    private int enabled = 1;

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

}
