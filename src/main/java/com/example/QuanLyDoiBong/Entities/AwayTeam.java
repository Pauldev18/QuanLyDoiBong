package com.example.QuanLyDoiBong.Entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "awayteam")
public class AwayTeam {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_away_team")
    private int idAwayTeam;
    @Column(name = "team_away_name")
    private String teamAwayName;
    @Column(name = "coach_away_name")
    private String coachAwayName;
    @Column(name = "country_away")
    private String countryAway;
    @Column(name = "shows")
    private boolean shows;
}