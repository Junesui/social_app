package com.socialapp.entity;

import java.io.Serializable;
import lombok.Data;

/**
 * 用户年龄认证图片表
 */
@Data
public class AgeVerifyImg implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long userId;
    private String img;
    private Boolean isDeleted;
    private Long createdAt;
    private Long updatedAt;
}
