package com.example.QuanLyDoiBong.DTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ThongKeMatch {
    private String TeamName;
    private long soTranDaDau;
    private long soBanThua;
    private long soBanThang;
    private long tongSoTranThang;
    private long tongSoTranThua;
    private long tongSoTranHoa;
    private long point;
}
