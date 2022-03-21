package com.z.entity;

import java.io.Serializable;

import lombok.Data;

/**
 * 用户授权表
 */
@Data
public class UserAuth implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long userId;
    private Integer type;
    private String username;
    private String password;
    private String salt;
    private Boolean isDeleted;
    private Long createdAt;
    private Long updatedAt;

}
