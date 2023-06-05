package com.example.kosciuszkon.config.security;

import com.example.kosciuszkon.config.authentication.AuthFailureHandler;
import com.example.kosciuszkon.config.authentication.AuthSuccessHandler;
import com.example.kosciuszkon.config.authentication.JsonObjectAuthFilter;
import com.example.kosciuszkon.config.authorization.JwtAuthorizationFilter;
import com.example.kosciuszkon.repository.TokenRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.security.provisioning.UserDetailsManager;
import org.springframework.security.web.authentication.HttpStatusEntryPoint;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import javax.sql.DataSource;
import java.util.Arrays;

@Configuration
@RequiredArgsConstructor
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {

    private final DataSource dataSource;
    private final ObjectMapper objectMapper;

    private final AuthSuccessHandler authSuccessHandler;

    private final AuthFailureHandler authFailureHandler;

    private final TokenRepository tokenRepository;

    @Value("${auth.secret}")
    private String secret;

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.jdbcAuthentication().dataSource(dataSource);
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .cors().and().csrf().disable()
                .authorizeRequests()
                .antMatchers("/swagger-ui.html").permitAll()
                .antMatchers("/v2/api-docs").permitAll()
                .antMatchers("/webjars/**").permitAll()
                .antMatchers("/swagger-resources/**").permitAll()
                .antMatchers("/signup").permitAll()
                .antMatchers("/**").permitAll()
                .anyRequest().authenticated()
                .and()
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and()
                .formLogin().permitAll()
                .and()
                .addFilter(jsonObjectAuthFilter())
                .addFilter(new JwtAuthorizationFilter(authenticationManager(), createUserDetailsManager(), secret, tokenRepository))
                .exceptionHandling()
                .authenticationEntryPoint(new HttpStatusEntryPoint(HttpStatus.UNAUTHORIZED));
    }

    public JsonObjectAuthFilter jsonObjectAuthFilter() throws Exception {
        var authFilter = new JsonObjectAuthFilter(objectMapper);
        authFilter.setAuthenticationSuccessHandler(authSuccessHandler);
        authFilter.setAuthenticationFailureHandler(authFailureHandler);
        authFilter.setAuthenticationManager(super.authenticationManager());
        return authFilter;
    }

    @Bean
    public UserDetailsManager createUserDetailsManager() {
        return new JdbcUserDetailsManager(dataSource);
    }

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.setAllowedOrigins(Arrays.asList("http://localhost:3000"));
        configuration.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "DELETE", "OPTIONS"));
        configuration.setAllowedHeaders(Arrays.asList("*"));
        configuration.setAllowCredentials(true);
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }
}
