package com.example.kosciuszkon.controller;

import com.example.kosciuszkon.external.RecommendationServiceClient;
import com.example.kosciuszkon.external.model.RecommendationMessage;
import com.example.kosciuszkon.external.model.RecommendationRequest;
import com.example.kosciuszkon.external.model.RecommendationResponse;
import com.example.kosciuszkon.service.UserService;
import lombok.AllArgsConstructor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.net.URISyntaxException;

@RestController
@AllArgsConstructor
@RequestMapping("/recommendation")
public class RecommendationController {

    private final RecommendationServiceClient client;
    private final UserService userService;

    @PostMapping("/get")
    public RecommendationResponse getRecommendation(@AuthenticationPrincipal UsernamePasswordAuthenticationToken user,
                                                    @RequestBody RecommendationMessage message)
            throws URISyntaxException, IOException, InterruptedException {
        Long userId = userService.getUserId(user.getName());
        var request = new RecommendationRequest(userId, message.getMessage());
        return client.send(request);
    }
}
