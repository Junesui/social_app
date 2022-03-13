package com.socialapp.entity;

import java.io.Serializable;
import java.util.Date;
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
    private String identifier;
    private String credential;
    private String salt;
    private Boolean isDeleted;
    private Long createdAt;
    private Long updatedAt;

}
