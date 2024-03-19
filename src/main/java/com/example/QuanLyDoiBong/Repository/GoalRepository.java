package com.example.QuanLyDoiBong.Repository;

import com.example.QuanLyDoiBong.Entities.Goal;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GoalRepository extends JpaRepository<Goal, Integer> {
    @Query("SELECT g.player, COUNT(g.IDGoals) AS goalsScored " +
            "FROM Goal g " +
            "GROUP BY g.player " +
            "ORDER BY goalsScored DESC")
    List<Object[]> findTopScorers();
}
