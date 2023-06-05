package com.example.kosciuszkon.external;

import com.example.kosciuszkon.external.model.RecommendationRequest;
import com.example.kosciuszkon.external.model.RecommendationResponse;
import com.example.kosciuszkon.external.model.RequestBuilder;
import com.example.kosciuszkon.external.model.ResponseBuilder;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.net.ProxySelector;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.http.HttpClient;
import java.net.http.HttpResponse;

@Component
public class RecommendationServiceClient {

    public RecommendationResponse send(RecommendationRequest request)
            throws URISyntaxException, IOException, InterruptedException {
        String serviceUri = "http://localhost:8000";
        String path = "/search_preference";
        var HttpRequest = RequestBuilder.buildRequest(request, new URI(serviceUri + path));
        HttpResponse<String> response = HttpClient
                .newBuilder()
                .proxy(ProxySelector.getDefault())
                .build()
                .send(HttpRequest, HttpResponse.BodyHandlers.ofString());
        return ResponseBuilder.buildResponse(response);
    }
}
