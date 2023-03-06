package com.example.kosciuszkon.controller;

import com.example.kosciuszkon.dto.MessageDTO;
import com.example.kosciuszkon.dto.WrappedMessagesDto;
import com.example.kosciuszkon.entity.Message;
import com.example.kosciuszkon.entity.User;
import com.example.kosciuszkon.service.CategoryService;
import com.example.kosciuszkon.service.MessageService;
import com.example.kosciuszkon.service.RoomCacheService;
import com.example.kosciuszkon.service.UserService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RestController;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;

@RestController
@CrossOrigin
@RequiredArgsConstructor
public class ChatController {

    private Logger log = LoggerFactory.getLogger(ChatController.class);

    private final MessageService messageService;

    private final SimpMessagingTemplate messagingTemplate;

    private final UserService userService;

    @MessageMapping("/send_message")
    public void sendMessage(@AuthenticationPrincipal UsernamePasswordAuthenticationToken user,
                            MessageDTO messageDTO) {
        var usr = userService.findByUsername(user.getName());
        Message messageEntity = buildMessageEntity(messageDTO, usr);
        Message msg = messageService.save(messageEntity);
        var toSend = messageService.createNotificationList(messageDTO.getCategoryName());
        log.debug("Message saved");
        toSend.forEach(toUserId -> {
            messagingTemplate.convertAndSend("/topic/user/" + toUserId.getUsername(), messageDTO);
        });
    }

    @MessageMapping("/fetch_messages")
    public void fetchMessages(@AuthenticationPrincipal UsernamePasswordAuthenticationToken user,
                              String categoryName) {
         List<MessageDTO> messages = messageService.findByCategoryName(categoryName);
        var wrappedMessagesDto = new WrappedMessagesDto();
        wrappedMessagesDto.setMesssages(messages);
        this.messagingTemplate.convertAndSend("/topic/user/" + user.getName(), wrappedMessagesDto);
    }

    private Message buildMessageEntity(MessageDTO messageDTO, User user) {
        var msg = new Message();
        msg.setMessage(messageDTO.getMessage());
        msg.setCreatedAt(Timestamp.from(Instant.now()));
        msg.setCategoryName(messageDTO.getCategoryName());
        msg.setUsername(user.getUsername());
        return msg;
    }
}
