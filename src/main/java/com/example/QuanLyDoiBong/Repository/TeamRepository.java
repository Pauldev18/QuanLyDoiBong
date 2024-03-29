package com.example.QuanLyDoiBong.Repository;

import com.example.QuanLyDoiBong.Entities.Team;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TeamRepository extends JpaRepository<Team, Integer> {
}
