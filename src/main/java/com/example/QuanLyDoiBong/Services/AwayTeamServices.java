package com.example.QuanLyDoiBong.Services;

import com.example.QuanLyDoiBong.Entities.AwayTeam;
import com.example.QuanLyDoiBong.Entities.Team;
import org.springframework.http.ResponseEntity;

import java.util.List;

public interface AwayTeamServices {
    List<AwayTeam> getAlAwayTeam();
    ResponseEntity<Object> updateAwayTeam(AwayTeam teamAway);
    ResponseEntity<Object> deleteAwayTeam(int IDTeaAway);
    ResponseEntity<Object> insertAwayTeam(AwayTeam teamAway);
}
