package com.example.QuanLyDoiBong.Controller;

import com.example.QuanLyDoiBong.Entities.Standings;
import com.example.QuanLyDoiBong.Services.StandingsServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@CrossOrigin
@RestController
public class StandingController {

    private StandingsServices standingsServices;
    @Autowired
    public StandingController(StandingsServices standingsServices) {
        this.standingsServices = standingsServices;
    }
    @GetMapping("/bxh")
    public List<Standings> getBXH(){
        return standingsServices.getAllAsc();
    }
}
