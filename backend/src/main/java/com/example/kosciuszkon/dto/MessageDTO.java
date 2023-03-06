package com.example.kosciuszkon.dto;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MessageDTO {

    private int id;

    private String message;

    private String categoryName;

}
