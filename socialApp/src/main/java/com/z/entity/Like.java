package com.z.entity;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 点赞表
 */
@Data
public class Like implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long postId;
    private Long commentId;
    private Long userId;
    private Boolean isLike;
    private Long createdAt;
    private Long updatedAt;

}
