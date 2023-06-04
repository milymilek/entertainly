package com.example.kosciuszkon.repository;

import com.example.kosciuszkon.entity.Message;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MessageRepository extends JpaRepository<Message, Long> {

    List<Message> findByCategory_Name(String categoryName);
}
