package com.example.QuanLyDoiBong.DTO;

import com.example.QuanLyDoiBong.Entities.Player;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TopScorerDTO {
    private Player player;
    private int goalsScored;
}
