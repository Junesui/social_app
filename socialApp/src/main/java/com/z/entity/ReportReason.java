package com.z.entity;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 举报理由表
 */
@Data
public class ReportReason implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private String content;
    private Boolean isDeleted;
    private Long createdAt;
    private Long updatedAt;

}
