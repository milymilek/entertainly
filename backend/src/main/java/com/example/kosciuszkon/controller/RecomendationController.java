package com.example.kosciuszkon.controller;

import com.example.kosciuszkon.service.RecomenadationService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/recommendation")
@RequiredArgsConstructor
public class RecomendationController {

    private final RecomenadationService service;

    @GetMapping("/get")
    public List<String> getRecommendations(@RequestBody List<String> features){
        return service.send(features);
    }
}
