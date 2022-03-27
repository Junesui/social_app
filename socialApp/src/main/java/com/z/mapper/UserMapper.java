package com.z.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.z.entity.User;
import com.z.entity.UserAuth;

/**
 * 用户相关接口
 */
@Mapper
public interface UserMapper {

    // 通过用户名和登录类型查找用户
    UserAuth findByUsername(@Param("username") String username, @Param("type") Integer type);

    // 保存用户信息表
    void saveUser(User user);

    // 保存用户登录表
    void saveUserAuth(UserAuth userAuth);

}
