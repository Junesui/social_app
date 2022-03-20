package com.z.vo;

import lombok.Data;

/**
 * 登录时的数据
 */
@Data
public class LoginVo {

    private String username;
    private String password;
    private Integer loginType;
}
