package com.z.entity;

import java.io.Serializable;

import lombok.Data;

/**
 * 屏蔽用户表
 */
@Data
public class UserBlock implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long userId;
    private Long blockedUserId;
    private Boolean isBlock;
    private Long createdAt;
    private Long updatedAt;

}
