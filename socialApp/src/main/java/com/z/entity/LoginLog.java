package com.z.entity;

import java.io.Serializable;

import lombok.Data;

/**
 * 登录日志表
 */
@Data
public class LoginLog implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long userId;
    private Long userAuthId;
    private String platform;
    private String model;
    private String brand;
    private String skdVersion;
    private String sysVersion;
    private String loginIp;
    private String loginAddress;
    private Long loginAt;
    private Boolean isDeleted;
    private Long createdAt;
    private Long updatedAt;

}
