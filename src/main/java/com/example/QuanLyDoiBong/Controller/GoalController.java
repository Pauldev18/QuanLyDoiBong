package com.example.QuanLyDoiBong.Controller;

import com.example.QuanLyDoiBong.DTO.GoalDTO;
import com.example.QuanLyDoiBong.DTO.TopScorerDTO;
import com.example.QuanLyDoiBong.Entities.Goal;
import com.example.QuanLyDoiBong.Services.GoalServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class GoalController {
    private final GoalServices goalServices;
    @Autowired
    public GoalController(GoalServices goalServices) {
        this.goalServices = goalServices;
    }
    @GetMapping("/getAllGoals")
    public List<Goal> getAllGoal(){
        return goalServices.getAllGoal();
    }
    @PostMapping("/insertGoals")
    public ResponseEntity<Object> insertGoals(@RequestBody GoalDTO goalDTO){
        return goalServices.insertGoal(goalDTO);
    }
    @GetMapping("/top-scorers")
    public List<TopScorerDTO> getTopScorers() {
        return goalServices.getTopScorers();
    }
    @GetMapping("/getGoalHome")
    public List<Goal> getGoalHome(@RequestParam("idmatch") int idmatch,
                                  @RequestParam("idteam") int idteam)
}
