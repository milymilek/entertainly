package com.example.kosciuszkon.service;

import com.example.kosciuszkon.entity.Categories;
import com.example.kosciuszkon.entity.User;
import com.example.kosciuszkon.repository.CategoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Component
@RequiredArgsConstructor
public class CategoryService {

    private final CategoryRepository repository;

    @Transactional
    public void addAllForUser(List<Categories> categories, User user){
        categories.forEach(it -> {
            var category = repository.findByName(it.getName());
            if(category.isPresent()){
                user.getCategories().add(category.get());
            }else {
                repository.save(it);
                user.getCategories().add(it);
            }
        });
    }

    @Transactional
    public void addCategoriesToUser(List<String> categories, User user){
        categories.forEach(name -> {
            var category = repository.findByName(name);
            user.getCategories().add(category.get());
        });
    }

    public List<Categories> getForLoggedUser(User user) {
        return user.getCategories();
    }

    public Optional<Categories> getByName(String name){
        return repository.findByName(name);
    }
}
