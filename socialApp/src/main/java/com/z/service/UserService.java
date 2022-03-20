package com.z.service;

import com.z.entity.UserAuth;

/**
 * 用户相关接口
 */
public interface UserService {

    //通过用户名和登录类型查找用户
    UserAuth findByUsername(String username, Integer type);

    
}
