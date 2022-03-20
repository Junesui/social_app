package com.z.mapper;

import org.apache.ibatis.annotations.Param;

import com.z.entity.UserAuth;

/**
 * 用户相关接口
 */
public interface UserMapper {

    // 通过用户名和登录类型查找用户
    UserAuth findByUsername(@Param("username") String username, @Param("type") Integer type);

}
