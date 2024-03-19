package com.example.QuanLyDoiBong.Controller;

import com.example.QuanLyDoiBong.DTO.MatchDTO;
import com.example.QuanLyDoiBong.DTO.ThongKeMatch;
import com.example.QuanLyDoiBong.Entities.Match;
import com.example.QuanLyDoiBong.Services.MatchesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
public class MatchesController {
    private final MatchesService matchesService;
    @Autowired
    public MatchesController(MatchesService matchesService) {
        this.matchesService = matchesService;
    }
    @GetMapping("/getAllMatch")
    public List<Match> getAllMatch(){
        return matchesService.getAllMatch();
    }
    @PostMapping("/insertMatches")
    public ResponseEntity<Object> insertMatch(@RequestBody MatchDTO matchDTO){
        return matchesService.insertMacth(matchDTO);
    }
    @PutMapping("/updateMatches")
    public ResponseEntity<Object> updateMatch(@RequestBody MatchDTO matchDTO){
        return matchesService.updateMacth(matchDTO);
    }
    @DeleteMapping("/deleteMatches/{IDMatch}")
    public ResponseEntity<Object> deleteMatch(@PathVariable int IDMatch){
        return matchesService.deleteMacth(IDMatch);
    }

    @GetMapping("/thongke/{IDTour}")
    public ResponseEntity<List<ThongKeMatch>> getThongKe(@PathVariable int IDTour){
        return matchesService.thongKe(IDTour);
    }
}
