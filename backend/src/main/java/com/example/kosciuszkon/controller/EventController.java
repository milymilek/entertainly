package com.example.kosciuszkon.controller;

import com.example.kosciuszkon.dto.request.EventDTO;
import com.example.kosciuszkon.dto.request.EventUpdate;
import com.example.kosciuszkon.entity.Event;
import com.example.kosciuszkon.exceptions.EventNotFoundException;
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
    public void createEvent(@AuthenticationPrincipal UsernamePasswordAuthenticationToken user,
                            @RequestBody EventDTO eventDetails) {
        Long userId = userService.getUserId(user.getName());
        eventService.createEvent(eventDetails, userId);
    }

    @GetMapping("/details/{id}")
    public ResponseEntity<Event> getEventDetails(@PathVariable Long id) {
        return ResponseEntity.ok().body(eventService.getEventDetails(id));
    }

    @GetMapping("/all/{category}")
    public ResponseEntity<List<Event>> getEventsInCategory(@PathVariable String category) {
        return ResponseEntity.ok().body(eventService.getEventsInCategory(category));
    }

    @PostMapping("/signup")
    public void signupForEvent(@AuthenticationPrincipal UsernamePasswordAuthenticationToken user,
                               @RequestParam Long eventId) {
        eventService.joinEvent(eventId, userService.findByUsername(user.getName()));
    }

    @PatchMapping("/update")
    public Event updateEvent(@AuthenticationPrincipal UsernamePasswordAuthenticationToken user,
                            @RequestBody EventUpdate eventUpdate) {
        Long userId = userService.getUserId(user.getName());
        return eventService.updateEventTime(eventUpdate, userId);
    }

    @DeleteMapping("/delete/{id}")
    public void deleteEvent(@AuthenticationPrincipal UsernamePasswordAuthenticationToken user,
                            @PathVariable Long id) {
        Long userId = userService.getUserId(user.getName());
        eventService.deleteEvent(id, userId);
    }

    @GetMapping("/myEvents")
    public List<Event> findUserEvents(@AuthenticationPrincipal UsernamePasswordAuthenticationToken user) {
        Long userId = userService.getUserId(user.getName());
        return eventService.getUserEvents(userId);
    }

    @PatchMapping("/leave/{id}")
    public void leaveEvent(@AuthenticationPrincipal UsernamePasswordAuthenticationToken user,
                           @PathVariable Long id) {
        Long userId = userService.getUserId(user.getName());
        eventService.leaveEvent(id, userId);
    }

    @ExceptionHandler(WrongEventDetailsException.class)
    public String wrongEventDetailsException() {
        return "Wrong event details";
    }

    @ExceptionHandler(EventNotFoundException.class)
    public String eventNotFoundExceptionHandler() {
        return "Event not found";
    }
}
