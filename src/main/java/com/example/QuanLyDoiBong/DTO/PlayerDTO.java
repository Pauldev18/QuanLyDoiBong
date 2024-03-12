package com.example.QuanLyDoiBong.DTO;

import com.example.QuanLyDoiBong.Entities.Team;
import jakarta.persistence.Column;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PlayerDTO {
    private int IDPlayer;
    private String fullName;
    private Date dateOfBirth;
    private String country;
    private String position;
    private String jerseyNumber;
    private String photo;
    private String height;
    private String weight;
    private String email;
    private String phone;
    private int IDTeam;
    private Date contractStartDate;
    private Date contractEndDate;
}
