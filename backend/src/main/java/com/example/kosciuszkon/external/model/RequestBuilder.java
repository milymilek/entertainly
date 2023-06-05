package com.example.kosciuszkon.external.model;

import com.example.kosciuszkon.external.model.request.BaseRequest;
import com.google.gson.Gson;

import java.net.URI;
import java.net.http.HttpRequest;
import java.time.Duration;
import java.time.temporal.ChronoUnit;

public class RequestBuilder {

    public static HttpRequest buildRequest(BaseRequest request, URI uri) {
        var jsonBody = new Gson().toJson(request);
        return HttpRequest.newBuilder()
                .uri(uri)
                .timeout(Duration.of(10, ChronoUnit.SECONDS))
                .headers("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(jsonBody))
                .build();
    }
}
