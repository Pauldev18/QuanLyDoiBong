package com.example.QuanLyDoiBong.Services;

import com.example.QuanLyDoiBong.DTO.MatchDTO;
import com.example.QuanLyDoiBong.DTO.ThongKeFull;
import com.example.QuanLyDoiBong.DTO.ThongKeMatch;
import com.example.QuanLyDoiBong.Entities.Match;
import org.springframework.http.ResponseEntity;

import java.util.List;
import java.util.Map;

public interface MatchesService {
    List<Match> getAllMatch();
    ResponseEntity<Object> insertMacth(MatchDTO match);
    ResponseEntity<Object> updateMacth(MatchDTO match);
    ResponseEntity<Object> deleteMacth(int IDMatch);
    ResponseEntity<List<ThongKeMatch>> thongKe(int IDTour);

    ResponseEntity<List<Map<String, Object>>> thongke2(Integer idtour, Integer idteam);

}
