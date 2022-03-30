package com.z.controller;

import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.z.common.R;
import com.z.util.RedisUtil;

@RestController
public class TestController {

    @Autowired
    private RedisUtil redisUtil;

    @GetMapping("/test")
    public R test() {
        Long a = redisUtil.getExpire("phone_code_login18712345678", TimeUnit.MINUTES);
        return R.success().data(a);
    }

}
