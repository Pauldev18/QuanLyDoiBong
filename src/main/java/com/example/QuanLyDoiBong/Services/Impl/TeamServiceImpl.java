package com.example.QuanLyDoiBong.Services.Impl;

import com.example.QuanLyDoiBong.Entities.Team;
import com.example.QuanLyDoiBong.Repository.TeamRepository;
import com.example.QuanLyDoiBong.Services.TeamServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class TeamServiceImpl implements TeamServices {
    private final TeamRepository teamRepo;
    @Autowired
    public TeamServiceImpl(TeamRepository teamRepo) {
        this.teamRepo = teamRepo;
    }
    @Override
    public List<Team> getAllTeam() {
        return teamRepo.findAll();
    }

    @Override
    public ResponseEntity<Object> updateTeam(Team team) {
        try{
            Optional<Team> updateTeam = teamRepo.findById(team.getIDTeam());
            System.out.println(team.getIDTeam());
            System.out.println(updateTeam);
            if(updateTeam.isPresent()){
                Team teamUpdate = updateTeam.get();
                teamUpdate.setTeamName(team.getTeamName());
                teamUpdate.setCountry(team.getCountry());
                teamUpdate.setCoachName(team.getCoachName());
                Team savedTeam = teamRepo.save(teamUpdate);
                return new ResponseEntity<>(savedTeam, HttpStatus.OK);
            }else{
                return new ResponseEntity<>("Không tìm thấy team", HttpStatus.NOT_FOUND);
            }
        }catch (Exception e){
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @Override
    public ResponseEntity<Object> deleteTeam(int IDTeam) {
        try{
            Optional<Team> delete = teamRepo.findById(IDTeam);
            if(delete.isPresent()){
                teamRepo.delete(delete.get());
                return new ResponseEntity<>("Xóa thành công", HttpStatus.OK);
            }else{
                return new ResponseEntity<>("Không tìm thấy team", HttpStatus.NOT_FOUND);
            }
        }catch (Exception e){
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }
}
