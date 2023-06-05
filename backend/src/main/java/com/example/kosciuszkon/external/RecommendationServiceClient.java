package com.example.kosciuszkon.external;

import com.example.kosciuszkon.external.model.request.RecommendationRequest;
import com.example.kosciuszkon.external.model.request.ResultRequest;
import com.example.kosciuszkon.external.model.response.RecommendationResponse;
import com.example.kosciuszkon.external.model.RequestBuilder;
import com.example.kosciuszkon.external.model.ResponseBuilder;
import com.example.kosciuszkon.external.model.response.ResultResponse;
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
        return ResponseBuilder.buildRecommendationResponse(response);
    }

    public ResultResponse send(ResultRequest request)
            throws URISyntaxException, IOException, InterruptedException {
        String serviceUri = "http://localhost:8000";
        String path = "/assign_group";
        var HttpRequest = RequestBuilder.buildRequest(request, new URI(serviceUri + path));
        HttpResponse<String> response = HttpClient
                .newBuilder()
                .proxy(ProxySelector.getDefault())
                .build()
                .send(HttpRequest, HttpResponse.BodyHandlers.ofString());
        return ResponseBuilder.buildResultResponse(response);
    }
}
