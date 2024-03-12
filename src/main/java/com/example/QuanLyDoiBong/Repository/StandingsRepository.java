package com.example.QuanLyDoiBong.Repository;

import com.example.QuanLyDoiBong.Entities.Standings;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface StandingsRepository extends JpaRepository<Standings, Integer> {
}
