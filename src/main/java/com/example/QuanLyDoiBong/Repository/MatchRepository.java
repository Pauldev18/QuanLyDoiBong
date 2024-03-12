package com.example.QuanLyDoiBong.Repository;

import com.example.QuanLyDoiBong.Entities.Match;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MatchRepository extends JpaRepository<Match, Integer> {
}
