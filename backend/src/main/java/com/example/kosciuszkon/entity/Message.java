package com.example.kosciuszkon.entity;

import lombok.Getter;
import lombok.NonNull;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Getter
@Setter
public class Message {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long messageId;

    @NonNull
    String content;

    @ManyToOne(cascade = CascadeType.REMOVE)
    @JoinColumn(name = "username")
    @NonNull
    User owner;

    @NonNull
    LocalDateTime createdAt = LocalDateTime.now();

    @ManyToOne(cascade = CascadeType.REMOVE)
    @JoinColumn(name = "category_id", referencedColumnName = "id")
    Categories category;

}
