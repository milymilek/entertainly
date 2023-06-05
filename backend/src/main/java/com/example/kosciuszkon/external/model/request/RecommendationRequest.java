package com.example.kosciuszkon.external.model.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class RecommendationRequest extends BaseRequest implements Serializable {
    private Long user_id;
    private String msg_type;
}
