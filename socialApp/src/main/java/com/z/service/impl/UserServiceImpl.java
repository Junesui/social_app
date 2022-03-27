package com.z.service.impl;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.z.entity.User;
import com.z.entity.UserAuth;
import com.z.mapper.UserMapper;
import com.z.service.UserService;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public UserAuth findByUsername(String username, Integer type) {
        return userMapper.findByUsername(username, type);
    }

    @Transactional
    @Override
    public void saveByPhone(String username, Integer type) {
        // 保存用户信息表
        User user = new User();
        user.setUid(UUID.randomUUID().toString().replace("-", ""));
        user.setTelephone(username);
        user.setIsNewUser(true);
        user.setCreatedAt(System.currentTimeMillis());
        user.setUpdatedAt(System.currentTimeMillis());
        userMapper.saveUser(user);
        Long userId = user.getId();

        // 保存用户登录表
        UserAuth userAuth = new UserAuth();
        userAuth.setUserId(userId);
        userAuth.setType(type);
        userAuth.setUsername(username);
        userAuth.setCreatedAt(System.currentTimeMillis());
        userAuth.setUpdatedAt(System.currentTimeMillis());
        userMapper.saveUserAuth(userAuth);

    }

}
