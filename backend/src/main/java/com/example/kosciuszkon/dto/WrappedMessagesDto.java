package com.example.kosciuszkon.dto;

import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Setter
@NoArgsConstructor
public class WrappedMessagesDto {
    private List<MessageDTO> messsages;
}
