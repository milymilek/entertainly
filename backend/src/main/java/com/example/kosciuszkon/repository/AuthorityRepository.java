package com.example.kosciuszkon.repository;

import com.example.kosciuszkon.entity.Authority;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AuthorityRepository extends JpaRepository<Authority, Long> {
}
