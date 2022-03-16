package com.z.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.z.common.R;

import cn.hutool.jwt.JWTUtil;

@RestController
public class TestController {
    

    @GetMapping("/test")
    public R test() {
        
        
        
        return R.success();
    }
}
