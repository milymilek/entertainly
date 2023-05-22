package com.example.kosciuszkon.service;

import com.example.kosciuszkon.dto.EventDTO;
import com.example.kosciuszkon.entity.Categories;
import com.example.kosciuszkon.entity.Event;
import com.example.kosciuszkon.entity.User;
import com.example.kosciuszkon.exceptions.WrongEventDetailsException;
import com.example.kosciuszkon.repository.CategoryRepository;
import com.example.kosciuszkon.repository.EventRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class EventService {
    private final EventRepository eventRepository;
    private final CategoryRepository categoryRepository;

    public void createEvent(EventDTO eventDetails) {
        Categories category = categoryRepository.findByName(eventDetails.getCategoryName())
                .orElseThrow(WrongEventDetailsException::new);
        Event event = Event.builder()
                .eventTime(eventDetails.getEventTime())
                .address(eventDetails.getAddress())
                .description(eventDetails.getDescription())
                .category(category)
                .participants(new ArrayList<>())
                .build();
        eventRepository.save(event);
    }

    public void joinEvent(Long eventId, User user) {
        Event event = eventRepository.getOne(eventId);
        event.getParticipants().add(user);
        eventRepository.save(event);
    }

    public Event getEventDetails(Long eventId) {
        return eventRepository.getOne(eventId);
    }

    public List<Event> getEventsInCategory(String categoryName) {
        Categories category = categoryRepository.findByName(categoryName)
                .orElseThrow(WrongEventDetailsException::new);
        return eventRepository.findAll().stream()
                .filter(e -> e.getCategory().equals(category) && e.getEventTime().isAfter(LocalDateTime.now()))
                .collect(Collectors.toList());
    }
}
