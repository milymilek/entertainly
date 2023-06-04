package com.example.kosciuszkon.controller;


import com.example.kosciuszkon.entity.Categories;
import com.example.kosciuszkon.service.CategoryService;
import com.example.kosciuszkon.service.UserService;
import lombok.AllArgsConstructor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping("/categories")
public class CategoriesController {

    private final UserService userService;

    private final CategoryService categoryService;


    @PostMapping("/add")
    public void addCategories(@AuthenticationPrincipal UsernamePasswordAuthenticationToken user,
                              @RequestBody List<Categories> categories) {
        categoryService.addAllForUser(categories, userService.findByUsername(user.getName()));
    }

    @GetMapping("/getCategoriesForLoggedUser")
    public List<Categories> getCategoriesForLoggedUser(@AuthenticationPrincipal UsernamePasswordAuthenticationToken user) {
        return categoryService.getForLoggedUser(userService.findByUsername(user.getName()));
    }
}
