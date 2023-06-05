package com.example.kosciuszkon.external.model.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class RecommendationResponse {
    private Long user_id;
    private String interest_reco;
}
