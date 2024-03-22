package com.example.QuanLyDoiBong.Services;

import com.example.QuanLyDoiBong.DTO.GoalDTO;
import com.example.QuanLyDoiBong.DTO.TopScorerDTO;
import com.example.QuanLyDoiBong.Entities.Goal;
import org.springframework.http.ResponseEntity;

import java.util.List;

public interface GoalServices {
    List<Goal> getAllGoal();
    ResponseEntity<Object> insertGoal(GoalDTO goal);
    List<TopScorerDTO> getTopScorers();
    List<Goal> getGoalHome(int idmatch, int idteam);
    List<Goal> getGoalAway(int idmatch, int idteam);
}
