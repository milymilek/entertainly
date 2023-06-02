package com.example.kosciuszkon.repository;

import com.example.kosciuszkon.entity.Categories;
import com.example.kosciuszkon.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, String> {

    Optional<User> findByUsername(String s);

//    @Query(value = "select uc.users_username from categories c join users_categories uc " +
//            "on c.name = :c_name and uc.categories_id = c.id;", nativeQuery = true)
//    List<String> findUsernamesByCategoryName(@Param(value = "c_name") String name);

    List<User> findAllByCategories(Categories categories);

}
