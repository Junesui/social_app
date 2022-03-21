package com.z.entity;

import java.io.Serializable;

import lombok.Data;

/**
 * 用户表
 */
@Data
public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private String userid;
    private String telephone;
    private String email;
    private String nickname;
    private String biography;
    private String avatar;
    private String avatarThumbnail;
    private String cover;
    private String coverThumbnail;
    private String province;
    private Integer gender;
    private String birthday;
    private Boolean isAgeVerified;
    private Boolean isVip;
    private Long vipStartAt;
    private Long vipEndAt;
    private Boolean isNewUser;
    private Boolean isDangerousUser;
    private Integer status;
    private Boolean isDeleted;
    private Long createdAt;
    private Long updatedAt;

}
