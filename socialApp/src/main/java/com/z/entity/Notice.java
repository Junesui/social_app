package com.z.entity;

import java.io.Serializable;

import lombok.Data;

/**
 * 消息通知表
 */
@Data
public class Notice implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long receiverId;
    private Long actionUserId;
    private Integer type;
    private Long objectId;
    private Boolean isDeleted;
    private Long createdAt;
    private Long updatedAt;

}
