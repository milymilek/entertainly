package com.example.kosciuszkon.controller;

import com.example.kosciuszkon.external.RecommendationServiceClient;
import com.example.kosciuszkon.external.model.RecommendationMessage;
import com.example.kosciuszkon.external.model.request.RecommendationRequest;
import com.example.kosciuszkon.external.model.request.ResultRequest;
import com.example.kosciuszkon.external.model.response.BaseResponse;
import com.example.kosciuszkon.external.model.response.RecommendationResponse;
import com.example.kosciuszkon.external.model.response.ResultResponse;
import com.example.kosciuszkon.service.CategoryService;
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
import java.util.Collections;

@RestController
@AllArgsConstructor
@RequestMapping("/recommendation")
public class RecommendationController {

    private final RecommendationServiceClient client;
    private final UserService userService;
    private final CategoryService categoryService;

    @PostMapping("/get")
    public BaseResponse getRecommendation(@AuthenticationPrincipal UsernamePasswordAuthenticationToken user,
                                                    @RequestBody RecommendationMessage message)
            throws URISyntaxException, IOException, InterruptedException {
        Long userId = userService.getUserId(user.getName());
        String requestType = message.getMessage();
        BaseResponse finalResponse = new BaseResponse();
        finalResponse.setUser_id(userId);
        if (requestType.equals("END")) {
            var request = new ResultRequest(userId);
            ResultResponse response = client.send(request);
            finalResponse.setGroups(response.getGroups());
            finalResponse.setInterest_reco("");
            categoryService.addCategoriesToUser(response.getGroups(), userService.findByUsername(user.getName()));
        } else {
            var request = new RecommendationRequest(userId, message.getMessage());
            RecommendationResponse response = client.send(request);
            finalResponse.setInterest_reco(response.getInterest_reco());
            finalResponse.setGroups(Collections.emptyList());
        }

        return finalResponse;
    }
}
