package com.example.QuanLyDoiBong.Services.Impl;

import com.example.QuanLyDoiBong.Entities.Standings;
import com.example.QuanLyDoiBong.Repository.StandingsRepository;
import com.example.QuanLyDoiBong.Services.StandingsServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StandingsServiceImpl implements StandingsServices {
    @Autowired
    private StandingsRepository standingsRepository;
    @Override
    public List<Standings> getAllAsc() {
        return standingsRepository.findAllByOrderByPointsDesc();
    }
}
