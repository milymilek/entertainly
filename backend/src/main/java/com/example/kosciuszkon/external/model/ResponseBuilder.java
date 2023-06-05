package com.example.kosciuszkon.external.model;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonParseException;

import java.net.http.HttpResponse;

public class ResponseBuilder {

    public static RecommendationResponse buildResponse(HttpResponse<String> response) {
        try {
            return new ObjectMapper().readValue(response.body(), RecommendationResponse.class);
        } catch (Exception ex) {
            throw new JsonParseException("Invalid response");
        }
    }
}
