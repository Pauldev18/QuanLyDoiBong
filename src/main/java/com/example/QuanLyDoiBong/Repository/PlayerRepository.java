package com.example.QuanLyDoiBong.Repository;

import com.example.QuanLyDoiBong.Entities.Player;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PlayerRepository extends JpaRepository<Player, Integer> {
}
