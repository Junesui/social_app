package com.z.entity;

import java.io.Serializable;

import lombok.Data;

/**
 * 评论表
 */
@Data
public class Comment implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long postId;
    private Long commentatorId;
    private Long parentId;
    private String content;
    private Boolean isDeleted;
    private Long createdAt;
    private Long updatedAt;

}
