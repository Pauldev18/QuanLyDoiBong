package com.example.QuanLyDoiBong.Services;

import com.example.QuanLyDoiBong.DTO.PlayerDTO;
import com.example.QuanLyDoiBong.Entities.Player;
import org.springframework.http.ResponseEntity;

import java.util.List;

public interface PlayerService {
    List<Player> getAllPlayer();
    ResponseEntity<Object> updatePlayer(PlayerDTO player);
    ResponseEntity<Object> deletePlayer(int IDPlayer);
}
