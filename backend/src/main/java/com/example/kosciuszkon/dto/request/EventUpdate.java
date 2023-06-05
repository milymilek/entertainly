package com.example.kosciuszkon.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class EventUpdate {
    private Long eventId;
    private LocalDateTime newStartTime;
    private LocalDateTime newEndTime;
}
