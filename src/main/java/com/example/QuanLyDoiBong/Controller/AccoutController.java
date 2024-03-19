package com.example.QuanLyDoiBong.Controller;

import com.example.QuanLyDoiBong.Entities.Account;
import com.example.QuanLyDoiBong.Services.AccountServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AccoutController {
    private AccountServices accountServices;
    @Autowired
    public AccoutController(AccountServices accountServices) {
        this.accountServices = accountServices;
    }
    @PostMapping("/signin")
    public ResponseEntity<Object> login(@RequestParam("username") String username,
                                        @RequestParam("password") String password){
        return accountServices.getAccount(username, password);
    }
}
