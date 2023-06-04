package com.example.kosciuszkon.entity;

import lombok.*;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

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

    //TODO add event creator, and allow him to delete event
    //TODO leave event
    //TODO edit event time
    //TODO all event for given user

    private LocalDateTime startTime;

    private LocalDateTime endTime;

    private String address;

    private String description;

    @OneToOne
    private Categories category;

    @OneToMany
    private List<User> participants;
}
