package com.example.QuanLyDoiBong.Services;

import com.example.QuanLyDoiBong.Entities.Account;
import org.springframework.http.ResponseEntity;

public interface AccountServices {
    ResponseEntity<Object> getAccount(String userName, String passWord);
}
