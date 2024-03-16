package com.example.QuanLyDoiBong.Services.Impl;

import com.example.QuanLyDoiBong.DTO.MatchDTO;
import com.example.QuanLyDoiBong.Entities.Match;
import com.example.QuanLyDoiBong.Entities.Team;
import com.example.QuanLyDoiBong.Entities.Tournament;
import com.example.QuanLyDoiBong.Repository.MatchRepository;
import com.example.QuanLyDoiBong.Repository.TeamRepository;
import com.example.QuanLyDoiBong.Repository.TournamentRepository;
import com.example.QuanLyDoiBong.Services.MatchesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class MatchesServiceImpl implements MatchesService {
    private final MatchRepository matchRepository;
    private final TournamentRepository tournamentRepository;
    private final TeamRepository teamRepository;
    @Autowired
    public MatchesServiceImpl(MatchRepository matchRepository, TournamentRepository tournamentRepository, TeamRepository teamRepository) {
        this.matchRepository = matchRepository;
        this.tournamentRepository = tournamentRepository;
        this.teamRepository = teamRepository;
    }
    @Override
    public List<Match> getAllMatch() {
        return matchRepository.findAll();
    }

    @Override
    public ResponseEntity<Object> insertMacth(MatchDTO match) {
        try{
            Tournament getTour = tournamentRepository.findById(match.getIDTournament()).get();
            Team homeTeam = teamRepository.findById(match.getHomeTeamID()).get();
            Team awayTeam = teamRepository.findById(match.getAwayTeamID()).get();
            Match newObj =  new Match(0,
                    getTour,
                    homeTeam,
                    awayTeam,
                    match.getHomeTeamScore(),
                    match.getAwayTeamScore(),
                    match.getMatchDate(),
                    match.getStatus(),
                    match.getYellowCardsHomeTeam(),
                    match.getRedCardsHomeTeam(),
                    match.getYellowCardsAwayTeam(),
                    match.getRedCardsAwayTeam(),
                    match.getLoaiTranDau()
            );
            matchRepository.save(newObj);
            return new ResponseEntity<>(Map.of("message", "Lỗi", "data", newObj), HttpStatus.BAD_REQUEST);
        }catch(Exception ex){
            return new ResponseEntity<>(Map.of("message", "Lỗi", "error", ex.getMessage()), HttpStatus.BAD_REQUEST);
        }
    }

    @Override
    public ResponseEntity<Object> updateMacth(MatchDTO match) {
        try{
            Tournament getTour = tournamentRepository.findById(match.getIDTournament()).get();
            Team homeTeam = teamRepository.findById(match.getHomeTeamID()).get();
            Team awayTeam = teamRepository.findById(match.getAwayTeamID()).get();
            Match select = matchRepository.findById(match.getIDMatch()).get();
            if(getTour != null && homeTeam != null && awayTeam != null && select != null){
                select.setIDTournaments(getTour);
                select.setHomeTeam(homeTeam);
                select.setAwayTeam(awayTeam);
                select.setHomeTeamScore(match.getHomeTeamScore());
                select.setAwayTeamScore(match.getAwayTeamScore());
                select.setMatchDate(match.getMatchDate());
                select.setStatus(match.getStatus());
                select.setYellowCardsHomeTeam(match.getYellowCardsHomeTeam());
                select.setRedCardsHomeTeam(match.getRedCardsHomeTeam());
                select.setYellowCardsAwayTeam(match.getYellowCardsAwayTeam());
                select.setRedCardsAwayTeam(match.getRedCardsAwayTeam());
                select.setLoaiTranDau(match.getLoaiTranDau());
                matchRepository.save(select);
                return new ResponseEntity<>(Map.of("message", "Thành công", "data", select), HttpStatus.OK);
            }else{
                return new ResponseEntity<>(Map.of("message", "Lỗi", "error", "Không tìm thấy"), HttpStatus.NOT_FOUND);
            }

        }catch(Exception ex){
            return new ResponseEntity<>(Map.of("message", "Lỗi", "error", ex.getMessage()), HttpStatus.BAD_REQUEST);
        }
    }

    @Override
    public ResponseEntity<Object> deleteMacth(int IDMatch) {
        try{
            Match delete = matchRepository.findById(IDMatch).get();
            if(delete != null){
                matchRepository.delete(delete);
                return new ResponseEntity<>(Map.of("message", "Thành công"), HttpStatus.OK);
            }else{
                return new ResponseEntity<>(Map.of("message", "Lỗi", "error", "Không tìm thấy"), HttpStatus.NOT_FOUND);
            }
        }catch(Exception ex){
            return new ResponseEntity<>(Map.of("message", "Lỗi", "error", ex.getMessage()), HttpStatus.BAD_REQUEST);
        }
    }
}
