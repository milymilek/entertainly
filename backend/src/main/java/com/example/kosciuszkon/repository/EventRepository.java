package com.example.kosciuszkon.repository;

import com.example.kosciuszkon.entity.Event;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EventRepository extends JpaRepository<Event, Long> {
}
