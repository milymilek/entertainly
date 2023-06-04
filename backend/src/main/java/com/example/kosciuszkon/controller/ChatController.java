package com.example.kosciuszkon.controller;

import com.example.kosciuszkon.dto.ChatMessage;
import com.example.kosciuszkon.service.ChatService;
import lombok.RequiredArgsConstructor;
import org.springframework.messaging.MessageHeaders;
import org.springframework.messaging.handler.annotation.Headers;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class ChatController {

    private final ChatService chatService;

    @MessageMapping("/chat.sendMessage")
    @SendTo("/topic/public")
    public ChatMessage sendMessage(@Payload ChatMessage chatMessage, @Headers MessageHeaders headers,
                                   SimpMessageHeaderAccessor headerAccessor) {
        var categoryName = headerAccessor.getHeader("category");
//        chatService.saveMessage(chatMessage, categoryName.toString());
        return chatMessage;
    }

    @MessageMapping("/chat.addUser")
    @SendTo("/topic/public")
    public ChatMessage addUser(@Payload ChatMessage chatMessage, SimpMessageHeaderAccessor headerAccessor) {
        headerAccessor.getSessionAttributes().put("username", chatMessage.getSender());
        var categoryName = headerAccessor.getHeader("category");
//        var username = headerAccessor.getUser().getName();
//        chatService.getChatHistory(categoryName.toString(), username);
        return chatMessage;
    }

}