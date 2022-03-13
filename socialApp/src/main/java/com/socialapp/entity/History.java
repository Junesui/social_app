package com.socialapp.entity;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 主页访问历史表
 */
@Data
public class History implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long visitorId;
    private Long visitedId;
    private Boolean isDeleted;
    private Long createdAt;
    private Long updatedAt;

}
