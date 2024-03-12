package com.example.QuanLyDoiBong.Entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Time;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "goals")
public class Goal{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int IDGoals;

    @ManyToOne
    @JoinColumn(name = "MatchID")
    private Match match;

    @ManyToOne
    @JoinColumn(name = "IDPlayer")
    private Player player;

    @Column(name = "GoalTime")
    private Time goalTime;
}

