package com.example.kosciuszkon;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EnableJpaRepositories
public class KosciuszkonApplication {

    public static void main(String[] args) {
        SpringApplication.run(KosciuszkonApplication.class, args);
    }

}
