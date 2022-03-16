package com.z.entity;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 用户创建的组的表
 */
@Data
public class Group implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long ownerId;
    private Long groupCategoryId;
    private String title;
    private String description;
    private String cover;
    private String coverThumbnail;
    private Boolean isNeedAgree;
    private Boolean isCallingTop;
    private Boolean isOnlyAgeVerfy;
    private Boolean isOnlySameGender;
    private Boolean isDeleted;
    private Long createdAt;
    private Long updatedAt;

}
