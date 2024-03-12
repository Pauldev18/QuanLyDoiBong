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
@Table(name = "cards")
public class Card {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int IDCard;
    @ManyToOne
    @JoinColumn(name = "MatchID")
    private Match match;

    @ManyToOne
    @JoinColumn(name = "IDPlayer")
    private Player player;

    @Column(name = "YellowCards")
    private int yellowCards;
    @Column(name = "RedCards")
    private int redCards;
}

