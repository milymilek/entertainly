package com.example.kosciuszkon.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Fetch;

import javax.persistence.*;
import java.util.List;

@Entity
@Getter
@Setter
@Table(name = "Users")
public class User {
    @Id
    private String username;

    @JsonIgnore
    private Long id;

    private String email;

    private String password;

    @JsonIgnore
    private int enabled = 1;

    @ManyToMany(fetch = FetchType.EAGER)
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
