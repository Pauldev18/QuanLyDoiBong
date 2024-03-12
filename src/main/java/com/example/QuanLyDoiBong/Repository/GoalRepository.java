package com.example.QuanLyDoiBong.Repository;

import com.example.QuanLyDoiBong.Entities.Goal;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface GoalRepository extends JpaRepository<Goal, Integer> {
}
