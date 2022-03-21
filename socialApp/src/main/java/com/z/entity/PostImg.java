package com.z.entity;

import java.io.Serializable;

import lombok.Data;

/**
 * 投稿图片表
 */
@Data
public class PostImg implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long postId;
    private String img;
    private String imgThumbnail;
    private Long createdAt;
    private Long updatedAt;

}
