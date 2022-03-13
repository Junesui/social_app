package com.socialapp.entity;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 投稿表
 */
@Data
public class Post implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long userId;
    private Long groupId;
    private String content;
    private Integer type;
    private Boolean isDeleted;
    private Long createdAt;
    private Long updatedAt;

}
