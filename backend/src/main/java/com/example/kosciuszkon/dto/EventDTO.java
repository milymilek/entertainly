package com.example.kosciuszkon.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class EventDTO {
    private LocalDateTime eventTime;
    private String address;
    private String description;
    private String categoryName;
}
