package com.example.kosciuszkon.controller;

import com.example.kosciuszkon.service.RecomenadationService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/recommendation")
@RequiredArgsConstructor
public class RecomendationController {

    private final RecomenadationService service;

    @PostMapping("/get")
    public List<String> getRecommendations(@AuthenticationPrincipal UsernamePasswordAuthenticationToken user,
                                           @RequestBody List<String> features){
        return service.send(features);
    }
}
