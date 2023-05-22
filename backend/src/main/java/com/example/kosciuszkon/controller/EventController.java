package com.example.kosciuszkon.controller;

import com.example.kosciuszkon.dto.EventDTO;
import com.example.kosciuszkon.entity.Event;
import com.example.kosciuszkon.exceptions.WrongEventDetailsException;
import com.example.kosciuszkon.service.EventService;
import com.example.kosciuszkon.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/event")
@RequiredArgsConstructor
public class EventController {

    private final EventService eventService;
    private final UserService userService;

    @PostMapping("/new")
    public void createEvent(@RequestBody EventDTO eventDetails) {
        eventService.createEvent(eventDetails);
    }

    @GetMapping("/details")
    public ResponseEntity<Event> getEventDetails(@RequestParam Long eventId) {
        return ResponseEntity.ok().body(eventService.getEventDetails(eventId));
    }

    @GetMapping("/all")
    public ResponseEntity<List<Event>> getEventsInCategory(@RequestParam String categoryName) {
        return ResponseEntity.ok().body(eventService.getEventsInCategory(categoryName));
    }

    @PostMapping("/signup")
    public void signupForEvent(@AuthenticationPrincipal UsernamePasswordAuthenticationToken user,
                               @RequestParam Long eventId) {
        eventService.joinEvent(eventId, userService.findByUsername(user.getName()));
    }

    @ExceptionHandler(WrongEventDetailsException.class)
    public String wrongEventDetailsException() {
        return "Wrong event details";
    }
}
