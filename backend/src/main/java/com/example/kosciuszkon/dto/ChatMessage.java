package com.example.kosciuszkon.dto;


import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ChatMessage {
    private MessageType type;
    private String content;
    private String sender;
    private String categoryName;

    public enum MessageType {
        CHAT,
        JOIN,
        LEAVE
    }
}