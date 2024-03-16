package com.example.QuanLyDoiBong.Services;

import com.example.QuanLyDoiBong.Entities.Team;
import org.springframework.http.ResponseEntity;

import java.util.List;

public interface TeamServices {
    List<Team> getAllTeam();
    ResponseEntity<Object> updateTeam(Team team);
    ResponseEntity<Object> deleteTeam(int IDTeam);
    ResponseEntity<Object> insertTeam(Team team);
}
