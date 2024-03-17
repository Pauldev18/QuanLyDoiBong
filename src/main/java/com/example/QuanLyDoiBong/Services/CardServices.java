package com.example.QuanLyDoiBong.Services;

import com.example.QuanLyDoiBong.DTO.CardDTO;
import com.example.QuanLyDoiBong.Entities.Card;
import org.springframework.http.ResponseEntity;

import java.util.List;

public interface CardServices {
    ResponseEntity<Object> insertCard(CardDTO cardDTO);
    List<Card> getAllCard();
}
