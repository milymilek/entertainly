package com.example.kosciuszkon.service;

import com.example.kosciuszkon.connector.RecomendationConnector;
import com.theokanning.openai.completion.chat.ChatCompletionChoice;
import com.theokanning.openai.completion.chat.ChatCompletionRequest;
import com.theokanning.openai.completion.chat.ChatMessage;
import com.theokanning.openai.completion.chat.ChatMessageRole;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.*;

@Component
public class RecomenadationService {

    private final String authToken;

    public RecomenadationService(@Value("${api.token}") String authToken) {
        this.authToken = authToken;
    }

    public List<String> send(List<String> feautes){
        var connectionService = RecomendationConnector.connect(authToken);
        var rs = connectionService.createChatCompletion(
                buildChatRq(buildRecommendationRequest(feautes)));
        var recommendations =  Optional.of(rs.getChoices().get(0))
                .map(ChatCompletionChoice::getMessage)
                .map(ChatMessage::getContent)
                .map(it -> it.replaceAll("\n", "").replace(".", "").split("[0-9]"))
                .map(Arrays::asList)
                .orElse(Collections.emptyList());
        System.out.println(rs.getChoices().get(0).getMessage().getContent());
        return parseResult(recommendations);
    }

    private ChatCompletionRequest buildChatRq(String message){
        var cm = new ChatMessage();
        cm.setContent(message);
        cm.setRole(ChatMessageRole.USER.value());
        return ChatCompletionRequest.builder()
                .model("gpt-3.5-turbo-0301")
                .messages(List.of(cm))
                .build();
    }

    private String buildRecommendationRequest(List<String> features){
        var sb = new StringBuilder();
        sb.append("list hobbies for someone who is into ");
        features.forEach(it -> sb.append(it).append(","));
        System.out.println(sb.toString());
        return sb.toString();
    }

    private List<String> parseResult(List<String> recommendations){
        List<String> result = new ArrayList<>();
        recommendations.forEach(it -> {
            if(!it.isBlank()){
                result.add(it.trim());
            }
        });
        return result;
    }
}
