package com.example.QuanLyDoiBong.Repository;

import com.example.QuanLyDoiBong.Entities.Match;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MatchRepository extends JpaRepository<Match, Integer> {
    @Query(value = "SELECT \n" +
            "    Team.team_name AS TeamName,\n" +
            "    COUNT(DISTINCT matches.idmatch) AS MatchesPlayed,\n" +
            "    SUM(CASE WHEN matches.home_teamid = Team.idteam THEN matches.away_team_score ELSE matches.home_team_score END) AS Loss,\n" +
            "    SUM(CASE WHEN matches.home_teamid = Team.idteam THEN matches.home_team_score ELSE matches.away_team_score END) AS Goal,\n" +
            "    SUM(CASE WHEN matches.home_teamid = Team.idteam AND matches.home_team_score > matches.away_team_score THEN 1\n" +
            "             WHEN matches.away_teamid = Team.idteam AND matches.away_team_score > matches.home_team_score THEN 1 ELSE 0 END) AS Wins,\n" +
            "    SUM(CASE WHEN matches.home_teamid = Team.idteam AND matches.home_team_score < matches.away_team_score THEN 1\n" +
            "             WHEN matches.away_teamid = Team.idteam AND matches.away_team_score < matches.home_team_score THEN 1 ELSE 0 END) AS Losses,\n" +
            "    SUM(CASE WHEN matches.home_team_score = matches.away_team_score THEN 1 ELSE 0 END) AS Draws,\n" +
            "    SUM(CASE WHEN matches.home_teamid = Team.idteam AND matches.home_team_score > matches.away_team_score THEN 3\n" +
            "             WHEN matches.away_teamid = Team.idteam AND matches.away_team_score > matches.home_team_score THEN 3\n" +
            "             WHEN matches.home_teamid = Team.idteam AND matches.home_team_score = matches.away_team_score THEN 1\n" +
            "             WHEN matches.away_teamid = Team.idteam AND matches.home_team_score = matches.away_team_score THEN 1 ELSE 0 END) AS Points\n" +
            "FROM \n" +
            "    Team\n" +
            "LEFT JOIN \n" +
            "    matches ON Team.idteam = matches.home_teamid OR Team.idteam = matches.away_teamid\n" +
            "WHERE \n" +
            "    matches.idtournaments = ?\n" +
            "    AND matches.status = 'Finished'\n" +
            "GROUP BY \n" +
            "    Team.idteam;\n", nativeQuery = true)
    List<Object[]> thongKe(int tournamentId);

}
