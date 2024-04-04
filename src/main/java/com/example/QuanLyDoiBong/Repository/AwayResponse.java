package com.example.QuanLyDoiBong.Repository;

import com.example.QuanLyDoiBong.Entities.AwayTeam;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AwayResponse extends JpaRepository<AwayTeam, Integer> {

}
