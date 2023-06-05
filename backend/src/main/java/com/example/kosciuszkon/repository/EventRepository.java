package com.example.kosciuszkon.repository;

import com.example.kosciuszkon.entity.Event;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface EventRepository extends JpaRepository<Event, Long> {
    Optional<Event> findByIdAndEventCreatorId(Long id, Long eventCreatorId);
}
