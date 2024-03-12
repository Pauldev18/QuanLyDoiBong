package com.example.QuanLyDoiBong.Repository;

import com.example.QuanLyDoiBong.Entities.Card;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CardRepository extends JpaRepository<Card, Integer> {
}
