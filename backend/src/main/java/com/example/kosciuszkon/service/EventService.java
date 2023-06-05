package com.example.kosciuszkon.service;

import com.example.kosciuszkon.dto.request.EventDTO;
import com.example.kosciuszkon.dto.request.EventUpdate;
import com.example.kosciuszkon.entity.Categories;
import com.example.kosciuszkon.entity.Event;
import com.example.kosciuszkon.entity.User;
import com.example.kosciuszkon.exceptions.EventNotFoundException;
import com.example.kosciuszkon.exceptions.WrongEventDetailsException;
import com.example.kosciuszkon.repository.CategoryRepository;
import com.example.kosciuszkon.repository.EventRepository;
import com.example.kosciuszkon.repository.UserRepository;
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
    private final UserRepository userRepository;
    private final CategoryRepository categoryRepository;

    public void createEvent(EventDTO eventDetails, Long creatorId) {
        Categories category = categoryRepository.findByName(eventDetails.getCategoryName())
                .orElseThrow(WrongEventDetailsException::new);
        Event event = Event.builder()
                .startTime(eventDetails.getStartTime())
                .endTime(eventDetails.getEndTime())
                .address(eventDetails.getAddress())
                .description(eventDetails.getDescription())
                .category(category)
                .participants(new ArrayList<>())
                .eventCreatorId(creatorId)
                .build();
        eventRepository.save(event);
    }

    public void joinEvent(Long eventId, User user) {
        Event event = eventRepository.getOne(eventId);
        event.getParticipants().add(user);
        eventRepository.save(event);
    }

    public Event getEventDetails(Long eventId) {
        return eventRepository.findById(eventId).orElseThrow(EventNotFoundException::new);
    }

    public List<Event> getEventsInCategory(String categoryName) {
        Categories category = categoryRepository.findByName(categoryName)
                .orElseThrow(WrongEventDetailsException::new);
        return eventRepository.findAll().stream()
                .filter(e -> e.getCategory().equals(category) && e.getStartTime().isAfter(LocalDateTime.now()))
                .collect(Collectors.toList());
    }

    public void deleteEvent(Long eventId, Long creatorId) {
        Event event = eventRepository.findByIdAndEventCreatorId(eventId, creatorId).orElseThrow(EventNotFoundException::new);
        eventRepository.delete(event);
    }

    public Event updateEventTime(EventUpdate eventUpdate, Long userId) {
        Event event = eventRepository.findByIdAndEventCreatorId(eventUpdate.getEventId(), userId).orElseThrow(EventNotFoundException::new);
        event.setStartTime(eventUpdate.getNewStartTime());
        event.setEndTime(eventUpdate.getNewEndTime());
        eventRepository.save(event);
        return event;
    }

    public List<Event> getUserEvents(Long userId) {
        return eventRepository.findAll()
                .stream()
                .filter(event -> event.getParticipants()
                        .stream()
                        .anyMatch(user -> user.getId().equals(userId))
                )
                .collect(Collectors.toList());
    }

    public void leaveEvent(Long eventId, Long userId) {
        Event event = eventRepository.findById(eventId).orElseThrow(EventNotFoundException::new);
        User user = userRepository.findById(userId);
        event.getParticipants().remove(user);
        eventRepository.save(event);
    }
}
