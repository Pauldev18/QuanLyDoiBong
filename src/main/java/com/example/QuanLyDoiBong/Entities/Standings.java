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
@Table(name = "Standings")
public class Standings {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int IDStandings;

    @ManyToOne
    @JoinColumn(name = "TeamID")
    private Team team;

    @ManyToOne
    @JoinColumn(name = "IDTournaments")
    private Tournament tournament;

    @Column(name = "Points")
    private int points;

}
