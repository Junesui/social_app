package com.z.entity;

import java.io.Serializable;
import lombok.Data;

/**
 * 举报表
 */
@Data
public class Report implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long reporterId;
    private Long reprotedId;
    private Long reportReasonId;
    private Integer type;
    private String attachImg1;
    private String attachImg2;
    private String attachImg3;
    private String attachImg4;
    private String attachImg5;
    private String description;
    private Boolean isHandled;
    private Long handlerId;
    private Long handledAt;
    private Boolean isDeleted;
    private Long createdAt;
    private Long updatedAt;

}
