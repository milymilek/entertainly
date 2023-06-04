package com.example.kosciuszkon.repository;

import com.example.kosciuszkon.entity.Categories;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CategoryRepository extends JpaRepository<Categories, Long> {

    Optional<Categories> findByName(String name);
}
