package com.example.kosciuszkon.connector;

import com.theokanning.openai.OpenAiService;

public class RecomendationConnector {

    public static OpenAiService connect(String authToken){
        OpenAiService service = new OpenAiService(authToken);
        return service;
    }
}
