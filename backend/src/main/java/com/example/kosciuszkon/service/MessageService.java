package com.example.kosciuszkon.service;

import com.example.kosciuszkon.dto.MessageDTO;
import com.example.kosciuszkon.entity.Message;
import com.example.kosciuszkon.entity.User;
import com.example.kosciuszkon.repository.MessageRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class MessageService {

    private final MessageRepository messageRepository;

    private final UserService userService;

    private final CategoryService categoryService;

    public Message save(Message messageEntity) {
        return messageRepository.save(messageEntity);
    }

    public List<MessageDTO> findByCategoryName(String name) {
        return messageRepository.findAllByCategoryName(name)
                .stream().sorted(Comparator.comparing(Message::getCreatedAt))
                .map(it -> {
                    var msg = new MessageDTO();
                    msg.setCategoryName(it.getCategoryName());
                    msg.setMessage(it.getMessage());
                    return msg;
                }).collect(Collectors.toList());
    }

    @Transactional
    public List<User> createNotificationList(String categoryName) {
        var category = categoryService.getByName(categoryName);
        if (category.isPresent()) {
            return userService.findAllUsersByCategory(category.get());
        }
        return Collections.emptyList();
    }

}
