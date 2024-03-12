package com.example.QuanLyDoiBong.Entities;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "matches")
public class Match {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int matchID;

    @ManyToOne
    @JoinColumn(name = "IDTournaments")
    private Tournament tournament;

    @ManyToOne
    @JoinColumn(name = "HomeTeamID")
    private Team homeTeam;

    @ManyToOne
    @JoinColumn(name = "AwayTeamID")
    private Team awayTeam;

    @Column(name = "HomeTeamScore")
    private int homeTeamScore;

    @Column(name = "AwayTeamScore")
    private int awayTeamScore;

    @Column(name = "MatchDate")
    private Date matchDate;

    @Column(name = "Status")
    private String status;

    @Column(name = "YellowCardsHomeTeam")
    private int yellowCardsHomeTeam;

    @Column(name = "RedCardsHomeTeam")
    private int redCardsHomeTeam;

    @Column(name = "YellowCardsAwayTeam")
    private int yellowCardsAwayTeam;

    @Column(name = "RedCardsAwayTeam")
    private int redCardsAwayTeam;

    @Column(name = "LoaiTranDau")
    private String loaiTranDau;
}
