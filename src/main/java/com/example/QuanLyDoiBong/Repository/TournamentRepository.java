package com.example.QuanLyDoiBong.Repository;

import com.example.QuanLyDoiBong.Entities.Tournament;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TournamentRepository extends JpaRepository<Tournament, Integer> {
}
