package com.z.entity;

import java.io.Serializable;

import lombok.Data;

/**
 * 登录状态表
 */
@Data
public class LoginStatus implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long userId;
    private Boolean isOnline;
    private String onlineStatus;
    private Boolean isDeleted;
    private Long createdAt;
    private Long updatedAt;

}
