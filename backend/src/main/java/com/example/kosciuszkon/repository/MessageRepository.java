package com.example.kosciuszkon.repository;

import com.example.kosciuszkon.entity.Message;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MessageRepository extends JpaRepository<Message, Integer> {

    List<Message> findAllByCategoryName(String categoryName);
}
