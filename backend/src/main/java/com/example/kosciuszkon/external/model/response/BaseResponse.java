package com.example.kosciuszkon.external.model.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class BaseResponse {
    private Long user_id;
    private String interest_reco;
    private List<String> groups;
}
