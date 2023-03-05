package com.example.kosciuszkon.connector;

import com.theokanning.openai.OpenAiService;
import com.theokanning.openai.completion.CompletionRequest;

public class RecomendationConnector {

    public static OpenAiService connect(String authToken){
        String token = "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";
        OpenAiService service = new OpenAiService(token);
        return service;
    }
}
