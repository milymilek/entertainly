package com.example.kosciuszkon.entity;

import lombok.*;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Set;

@Entity(name = "events")
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class Event {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long eventCreatorId;

    private LocalDateTime startTime;

    private LocalDateTime endTime;

    private String address;

    private String description;

    @OneToOne
    private Categories category;

    @ManyToMany
    private Set<User> participants;
}
