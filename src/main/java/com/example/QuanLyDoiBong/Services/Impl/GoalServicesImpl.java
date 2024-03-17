package com.example.QuanLyDoiBong.Services.Impl;

import com.example.QuanLyDoiBong.DTO.GoalDTO;
import com.example.QuanLyDoiBong.Entities.Goal;
import com.example.QuanLyDoiBong.Entities.Match;
import com.example.QuanLyDoiBong.Entities.Player;
import com.example.QuanLyDoiBong.Entities.Team;
import com.example.QuanLyDoiBong.Repository.GoalRepository;
import com.example.QuanLyDoiBong.Repository.MatchRepository;
import com.example.QuanLyDoiBong.Repository.PlayerRepository;
import com.example.QuanLyDoiBong.Repository.TeamRepository;
import com.example.QuanLyDoiBong.Services.GoalServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class GoalServicesImpl implements GoalServices {
    private final GoalRepository goalRepository;
    private final MatchRepository matchRepository;
    private final PlayerRepository playerRepository;
    private final TeamRepository teamRepository;
    @Autowired
    public GoalServicesImpl(GoalRepository goalRepository, MatchRepository matchRepository, PlayerRepository playerRepository, TeamRepository teamRepository) {
        this.goalRepository = goalRepository;
        this.matchRepository = matchRepository;
        this.playerRepository = playerRepository;
        this.teamRepository = teamRepository;
    }
    @Override
    public List<Goal> getAllGoal() {
        return goalRepository.findAll();
    }

    @Override
    public ResponseEntity<Object> insertGoal(GoalDTO goal) {
        try{
            Match getMatch =  matchRepository.findById(goal.getIdmatch()).get();
            Player getPlayer = playerRepository.findById(goal.getIdplayer()).get();
            Team getTeam = teamRepository.findById(goal.getIdteam()).get();
            if(getMatch != null && getPlayer != null && getTeam != null){
                Goal newObj = new Goal();
                newObj.setGoalTime(goal.getGoal_time());
                newObj.setMatch(getMatch);
                newObj.setPlayer(getPlayer);
                newObj.setTeam(getTeam);
                goalRepository.save(newObj);
                return new ResponseEntity<>(Map.of("message:", "Thêm thành công", "data:", newObj), HttpStatus.OK);
            }else{
                return new ResponseEntity<>("Không tìm thấy", HttpStatus.NOT_FOUND);
            }

        }catch(Exception ex){
            return new ResponseEntity<>(Map.of("message:", "Lỗi", "error:", ex.getMessage()), HttpStatus.BAD_REQUEST);
        }
    }
}
