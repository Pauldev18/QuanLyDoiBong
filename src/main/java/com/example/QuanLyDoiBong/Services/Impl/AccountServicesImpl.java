package com.example.QuanLyDoiBong.Services.Impl;

import com.example.QuanLyDoiBong.Entities.Account;
import com.example.QuanLyDoiBong.Repository.AccountRepository;
import com.example.QuanLyDoiBong.Services.AccountServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
public class AccountServicesImpl implements AccountServices {
    @Autowired
    private AccountRepository accountRepository;
    @Override
    public ResponseEntity<Object> getAccount(String userName, String passWord) {
        Account account = accountRepository.findAccountByPassWordAndUserName(userName, passWord);
        if(account != null){
            return new ResponseEntity<>(account, HttpStatus.OK);
        }
        else{
            return new ResponseEntity<>("Sai tài khoản hoặc mật khâủ", HttpStatus.NOT_FOUND);
        }
    }
}
