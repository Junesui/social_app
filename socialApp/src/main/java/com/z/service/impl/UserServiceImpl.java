package com.z.service.impl;

import org.springframework.beans.factory.annotation.Autowired;

import com.z.entity.UserAuth;
import com.z.mapper.UserMapper;
import com.z.service.UserService;

public class UserServiceImpl implements UserService {
    
    @Autowired
    private UserMapper userMapper;

    @Override
    public UserAuth findByUsername(String username, Integer type) {
        return userMapper.findByUsername(username,type);
    }

}
