package com.example.kosciuszkon.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;


@Entity(name = "Authorities")
@Setter
@Getter
public class Authority {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String authority;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "username")
    private User username;

}
