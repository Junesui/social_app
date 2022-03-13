package com.socialapp.entity;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 粉丝表
 */
@Data
public class Follower implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long userId;
    private Long followerId;
    private Boolean isFollow;
    private Long createdAt;
    private Long updatedAt;

}
