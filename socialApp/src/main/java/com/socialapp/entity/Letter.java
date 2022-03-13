package com.socialapp.entity;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 留言表
 */
@Data
public class Letter implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long userId;
    private Long letterUserId;
    private String letter;
    private Boolean isDeleted;
    private Long createdAt;
    private Long updatedAt;

}
