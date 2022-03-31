package com.z.dto;

import lombok.Data;

/**
 * 登录时从页面传输的数据对象
 */
@Data
public class LoginDTO {
    // 用户名
    private String username;
    // 密码
    private String password;
    // 登录类型
    private Integer loginType;
}
