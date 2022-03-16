package com.z.entity;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 用户参加的组的表
 */
@Data
public class JoinGroup implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long userId;
    private Long groupId;
    private Boolean isJoin;
    private Long createdAt;
    private Long updatedAt;

}
