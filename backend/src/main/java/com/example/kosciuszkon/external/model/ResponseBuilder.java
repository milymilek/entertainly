package com.example.kosciuszkon.external.model;

import com.example.kosciuszkon.external.model.response.RecommendationResponse;
import com.example.kosciuszkon.external.model.response.ResultResponse;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonParseException;

import java.net.http.HttpResponse;

public class ResponseBuilder {

    public static RecommendationResponse buildRecommendationResponse(HttpResponse<String> response) {
        try {
            return new ObjectMapper().readValue(response.body(), RecommendationResponse.class);
        } catch (Exception ex) {
            throw new JsonParseException("Invalid response");
        }
    }

    public static ResultResponse buildResultResponse(HttpResponse<String> response) {
        try {
            return new ObjectMapper().readValue(response.body(), ResultResponse.class);
        } catch (Exception ex) {
            throw new JsonParseException("Invalid response");
        }
    }
}
