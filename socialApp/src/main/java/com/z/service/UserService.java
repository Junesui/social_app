package com.z.service;

import com.z.entity.UserAuth;

/**
 * 用户相关接口
 */
public interface UserService {

    //通过用户名和登录类型查找用户
    UserAuth findByUsername(String username, Integer type);

    // 通过手机号注册
    void saveByPhone(String username, Integer type);

    
}
