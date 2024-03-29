package com.example.kosciuszkon.service;

import com.example.kosciuszkon.dto.ChatMessage;
import com.example.kosciuszkon.entity.Message;
import com.example.kosciuszkon.exceptions.UserNotFoundException;
import com.example.kosciuszkon.repository.CategoryRepository;
import com.example.kosciuszkon.repository.MessageRepository;
import com.example.kosciuszkon.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.validation.ConstraintViolationException;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ChatService {

    private final MessageRepository messageRepository;

    private final CategoryRepository categoryRepository;

    private final UserRepository userRepository;

    public List<ChatMessage> getChatHistory(String categoryName){
        var messages = messageRepository.findByCategory_Name(categoryName);
        return messages.stream().map(it -> {
            var res = new ChatMessage();
            res.setType(ChatMessage.MessageType.JOIN);
            res.setContent(it.getContent());
            res.setSender(it.getOwner().getUsername());
            return res;
        }).collect(Collectors.toList());
    }

    public void saveMessage(ChatMessage messageDTO, String categoryName){
        var category = categoryRepository.findByName(categoryName)
                .orElseThrow(() -> new ConstraintViolationException("could not found category", null));
        var user = userRepository.findByUsername(messageDTO.getSender())
                .orElseThrow(UserNotFoundException::new);
        var message = new Message();
        message.setCategory(category);
        message.setOwner(user);
        message.setContent(messageDTO.getContent());
        messageRepository.save(message);
    }
}
