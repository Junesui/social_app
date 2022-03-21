package com.z.entity;

import java.io.Serializable;

import lombok.Data;

/**
 * 通话房间-用户关联表
 */
@Data
public class CallingUser implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long callingRoomId;
    private Long userId;
    private Boolean isOwner;
    private Long joinAt;
    private Long leaveAt;
    private Long createdAt;
    private Long updatedAt;

}
